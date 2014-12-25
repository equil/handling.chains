//
// Created by Alexey Rogatkin on 27.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHCMutableDictionaryPropertiesAdapter.h"
#import "CPropertiesDescriptorsAccessorsHolder.h"
#import "IAdaptedPropertyAccessor.h"

static NSString *const kMutableDictionaryAutomaticAdapterPresentedSuffix = @"Presented";

@implementation ARHCMutableDictionaryPropertiesAdapter
{
@private
    NSMutableDictionary *_state;
    CPropertiesDescriptorsAccessorsHolder *_holder;
}

- (instancetype)initWithDictionary:(NSMutableDictionary *)state
{
    self = [super init];
    if (self)
    {
        _state = state;
        _holder = [CPropertiesDescriptorsAccessorsHolder holder];
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
        result = [_holder.accessors objectForKey:NSStringFromSelector (aSelector)] != nil;
    }
    return result;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *result = [super methodSignatureForSelector:aSelector];

    id <IAdaptedPropertyAccessor> accessor = [_holder.accessors objectForKey:NSStringFromSelector (aSelector)];
    if (accessor != nil)
    {
        result = accessor.signature;
    }

    return result;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    id <IAdaptedPropertyAccessor> accessor = [_holder.accessors objectForKey:NSStringFromSelector (anInvocation.selector)];
    if (accessor != nil)
    {
        [accessor performWithInvocation:anInvocation
                               delegate:_state];
    }
    else
    {
        NSLog(@"MutableDictionaryAdapter can't detect invocation %@. \n"
                "\nMay be you forgot adapt some class by propertyDescriptor or "
                "note propertyDescriptor in source code through @protocol() link", anInvocation);
        [super forwardInvocation:anInvocation];
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    NSMutableDictionary *copyOfState = [_state mutableCopy];
    ARHCMutableDictionaryPropertiesAdapter *result = [[ARHCMutableDictionaryPropertiesAdapter alloc] initWithDictionary:copyOfState];
    return result;
}

@end