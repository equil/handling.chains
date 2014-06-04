//
// Created by Alexey Rogatkin on 19.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHCAbstractChainElement.h"
#import "ARHCCMutableDictionaryPropertiesAdapter.h"

NSString *const kChainContextKeyCancelExecution = @"cancelExecution";

@implementation ARHCAbstractChainElement
{
    ARHCCMutableDictionaryPropertiesAdapter *_adapter;
}

#pragma mark - Public interface behavior

- (void)handle
{
    NSLog(@"\n====== %@ ---> %@ ======", NSStringFromClass (self.chainClass), NSStringFromClass ([self class]));
    if (self.mustCancel)
    {
        NSLog(@"\tПропуск обработки, цепочка перешла в режим отмены.\n");
        return;
    }
    if (![self canProcess])
    {
//        NSLog(@"%@ can't process event from JaCarta subsystem", NSStringFromClass ([self class]));
        NSLog(@"\tПропуск обработки, условия обработки не выполнены.\n");
        return;
    }
    NSLog(@"\tСостояние контекста до выполнения: %@", [self descriptionForInternalContextWithPrefix:@"\t"]);
    [self process];
    NSLog(@"\tСостояние контекста после выполнения: %@\n\n", [self descriptionForInternalContextWithPrefix:@"\t"]);
}

- (NSString *)descriptionForInternalContextWithPrefix:(NSString *)prefix
{
    NSString *result = [[self.internalContext description] stringByReplacingOccurrencesOfString:@"\n"
                                                                                     withString:[prefix stringByAppendingString:@"\n"]];
    return result;
}

- (BOOL)mustCancel
{
    return [self.internalContext objectForKey:kChainContextKeyCancelExecution] != nil;
}

- (void)setMustCancel:(BOOL)mustCancel
{
    if (mustCancel)
    {
        [self.internalContext setObject:@""
                                 forKey:kChainContextKeyCancelExecution];
    }
    else
    {
        [self.internalContext removeObjectForKey:kChainContextKeyCancelExecution];
    }
}


#pragma mark - Abstract behavior for overloading

- (void)process
{
    NSLog(@"Метод [ARHCAbstractChainElement process] должен быть переопределен в потомке без вызова метода родителя");
}

- (BOOL)canProcess
{
    NSLog(@"Метод [ARHCAbstractChainElement canProcess] должен быть переопределен в потомке без вызова метода родителя");
    return NO;
}

#pragma mark - GCD context adaptation

- (NSMutableDictionary *)internalContext
{
    return (__bridge NSMutableDictionary *) dispatch_get_context (dispatch_get_current_queue ());
}

- (ARHCCMutableDictionaryPropertiesAdapter *)context
{
    if (_adapter == nil || ![self.internalContext isEqual:_adapter.state])
    {
        _adapter = [[ARHCCMutableDictionaryPropertiesAdapter alloc] initWithDictionary:self.internalContext];
    }
    return _adapter;
}

#pragma mark - Method forwarding for properties adoptation

- (BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL result = [super respondsToSelector:aSelector];

    if (!result)
    {
        result = [self.context respondsToSelector:aSelector];
    }
    return result;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [self.context forwardInvocation:anInvocation];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (![super respondsToSelector:aSelector])
    {
        signature = [self.context methodSignatureForSelector:aSelector];
    }
    return signature;
}

@end