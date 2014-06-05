//
// Created by Alexey Rogatkin on 27.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHCCMutableDictionaryPropertiesAdapter.h"
#import "ARHCCPropertiesDescriptorsAccessorsHolder.h"
#import "ARHCIAdaptedPropertyAccessor.h"

typedef enum
{
    UnknownMethodForProperty = 0,
    SetterMethodForProperty = 1,
    GetterMethodForProperty = 2,
    PresentedMethodForProperty = 3
} ForwardMethodType;

static NSString *const kMutableDictionaryAutomaticAdapterPresentedSuffix = @"Presented";

@implementation ARHCCMutableDictionaryPropertiesAdapter
{
@private
    NSMutableDictionary *_state;
    ARHCCPropertiesDescriptorsAccessorsHolder *_holder;
}

- (instancetype)initWithDictionary:(NSMutableDictionary *)state
{
    self = [super init];
    if (self)
    {
        _state = state;
        _holder = [ARHCCPropertiesDescriptorsAccessorsHolder holder];
    }

    return self;
}

@synthesize state = _state;

#pragma mark - Forwarding support

- (BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL result = [super respondsToSelector:aSelector];
    if (!result)
    {
        //result = [self detectTypeForSelector:aSelector] != UnknownMethodForProperty;
        result = [_holder.accessors objectForKey:NSStringFromSelector (aSelector)] != nil;
    }
    return result;
}

- (NSString *)getKey:(SEL)aSelector
          methodType:(ForwardMethodType)aType
{
    NSString *result = nil;
    NSString *stringSelector = NSStringFromSelector (aSelector);

    if (aType == GetterMethodForProperty)
    {
        result = stringSelector;
    }

    if (aType == SetterMethodForProperty)
    {
        result = [NSString stringWithFormat:@"%@%@",
                                            [[stringSelector substringWithRange:NSMakeRange (3, 1)] lowercaseString],
                                            [stringSelector substringWithRange:NSMakeRange (4, stringSelector.length - 5)]];
    }

    if (aType == PresentedMethodForProperty)
    {
        result = [stringSelector substringToIndex:stringSelector.length - kMutableDictionaryAutomaticAdapterPresentedSuffix.length];
    }

    return result;
}

- (ForwardMethodType)detectTypeForSelector:(SEL)aSelector
{

    NSString *selector = NSStringFromSelector (aSelector);
    NSArray *array = [selector componentsSeparatedByString:@":"];
    if (array.count == 1)
    {
        if ([array[ 0 ] hasSuffix:kMutableDictionaryAutomaticAdapterPresentedSuffix])
        {
            return PresentedMethodForProperty;
        }
        else
        {
            return GetterMethodForProperty;
        }
    }
    if (array.count == 2 && [array[ 0 ] length] > 3 && [array[ 0 ] hasPrefix:@"set"]
            && [[array[ 0 ] substringWithRange:NSMakeRange (3, 1)] isEqualToString:[[array[ 0 ] substringWithRange:NSMakeRange (3, 1)] uppercaseString]]
            && [array[ 1 ] isEqualToString:@""])
    {
        return SetterMethodForProperty;
    }
    return UnknownMethodForProperty;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *result = [super methodSignatureForSelector:aSelector];
//    ForwardMethodType methodType = [self detectTypeForSelector:aSelector];
//
//    if (methodType == SetterMethodForProperty)
//    {
//        result = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
//    }
//
//    if (methodType == GetterMethodForProperty)
//    {
//        result = [NSMethodSignature signatureWithObjCTypes:"@@:"];
//    }
//
//    if (methodType == PresentedMethodForProperty)
//    {
//        result = [NSMethodSignature signatureWithObjCTypes:"c@:"];
//    }

    id <ARHCIAdaptedPropertyAccessor> accessor = [_holder.accessors objectForKey:NSStringFromSelector (aSelector)];
    if (accessor != nil)
    {
        result = accessor.signature;
    }

    return result;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
//    ForwardMethodType methodType = [self detectTypeForSelector:anInvocation.selector];
//    NSString *key = [self getKey:anInvocation.selector
//                      methodType:methodType];
//
//    if (methodType == GetterMethodForProperty)
//    {
//        NSObject *value = [_state objectForKey:key];
//        [anInvocation setReturnValue:&value];
//
//        return;
//    }
//
//    if (methodType == SetterMethodForProperty)
//    {
//        void *temp;
//        [anInvocation getArgument:&temp
//                          atIndex:2];
//        NSObject *newValue = (__bridge NSObject *) temp;
//        if (newValue == nil)
//        {
//            [_state removeObjectForKey:key];
//        }
//        else
//        {
//            [_state setObject:newValue
//                       forKey:key];
//        }
//    }
//
//    if (methodType == PresentedMethodForProperty)
//    {
//        BOOL result = [_state objectForKey:key] != nil;
//        [anInvocation setReturnValue:&result];
//    }

    id <ARHCIAdaptedPropertyAccessor> accessor = [_holder.accessors objectForKey:NSStringFromSelector (anInvocation.selector)];
    if (accessor != nil)
    {
        [accessor performWithInvocation:anInvocation
                               delegate:_state];
    }
    else
    {
        [super forwardInvocation:anInvocation];
    }
}

@end