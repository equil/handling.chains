//
// Created by Alexey Rogatkin on 19.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHAbstractChainElement.h"
#import "IChainElementPrivate.h"
#import "ARHCMutableDictionaryPropertiesAdapter.h"

@interface ARHAbstractChainElement()<IChainElementPrivate>
@end

@implementation ARHAbstractChainElement
{
    ARHCMutableDictionaryPropertiesAdapter *_adapter;
}

#pragma mark - Public interface behavior

- (void)handle
{
//    NSLog(@"\n====== %@ ---> %@ ======", NSStringFromClass (self.chainClass), NSStringFromClass ([self class]));
    if (self.queue.canceled)
    {
//        NSLog(@"\tПропуск обработки, цепочка перешла в режим отмены.\n");
        return;
    }
    if (![self canProcess])
    {
//        NSLog(@"%@ can't process event from JaCarta subsystem", NSStringFromClass ([self class]));
//        NSLog(@"\tПропуск обработки, условия обработки не выполнены.\n");
        return;
    }
//    NSLog(@"\tСостояние контекста до выполнения: %@", [self descriptionForInternalContextWithPrefix:@"\t"]);
    [self process];
//    NSLog(@"\tСостояние контекста после выполнения: %@\n\n", [self descriptionForInternalContextWithPrefix:@"\t"]);
}

- (NSString *)descriptionForInternalContextWithPrefix:(NSString *)prefix
{
    NSMutableDictionary *context = ((id<IHandlingChainQueuePrivate>) self.queue).context;
    NSString *result = [[context description] stringByReplacingOccurrencesOfString:@"\n"
                                                                                   withString:[prefix stringByAppendingString:@"\n"]];
    return result;
}

#pragma mark - Abstract behavior for overloading

- (void)process
{
    NSLog (@"Метод [ARHAbstractChainElement process] должен быть переопределен в потомке без вызова метода родителя");
}

- (BOOL)canProcess
{
    NSLog (@"Метод [ARHAbstractChainElement canProcess] должен быть переопределен в потомке без вызова метода родителя");
    return NO;
}

#pragma mark - queue context adaptation

- (ARHCMutableDictionaryPropertiesAdapter *)context
{
    NSMutableDictionary *context = ((id<IHandlingChainQueuePrivate>) self.queue).context;
    if (_adapter == nil || ![context isEqual:_adapter.state])
    {
        _adapter = [[ARHCMutableDictionaryPropertiesAdapter alloc] initWithDictionary:context];
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