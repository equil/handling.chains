//
// Created by Alexey Rogatkin on 27.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHCMutableDictionaryPropertiesAdapter.h"
#import "CPropertiesDescriptorsAccessorsHolder.h"
#import "IAdaptedPropertyAccessor.h"
#import "CAdaptedCommonSetter.h"

static NSString *const kMutableDictionaryAutomaticAdapterPresentedSuffix = @"Presented";

@implementation ARHCMutableDictionaryPropertiesAdapter {
@private
    NSMutableDictionary *_state;
    CPropertiesDescriptorsAccessorsHolder *_holder;
}

- (instancetype)initWithDictionary:(NSMutableDictionary *)state {
    self = [super init];
    if (self) {
        _state = state;
        _holder = [CPropertiesDescriptorsAccessorsHolder holder];
    }

    return self;
}

@synthesize state = _state;

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ",
                                                                     NSStringFromClass([self class])];

    [description appendString:@"content: "];
    [description appendString:[self.state description]];
    [description appendString:@">"];
    return description;
}

#pragma mark - Forwarding support

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL result = [super respondsToSelector:aSelector];
    if (!result) {
        result = [_holder.accessors objectForKey:NSStringFromSelector(aSelector)] != nil;
    }
    else {
        NSLog(@"MutableDictionaryAdapter can't detect selector %@. \n"
                "\nMay be you forgot adapt some class by corresponding propertyDescriptor or "
                "note propertyDescriptor in source code through @protocol() link", NSStringFromSelector(aSelector));
    }
    return result;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *result = [super methodSignatureForSelector:aSelector];

    id <IAdaptedPropertyAccessor> accessor = [_holder.accessors objectForKey:NSStringFromSelector(aSelector)];
    if (accessor != nil) {
        result = accessor.signature;
    }
    else {
        NSLog(@"MutableDictionaryAdapter can't detect selector %@. \n"
                "\nMay be you forgot adapt some class by propertyDescriptor or "
                "note propertyDescriptor in source code through @protocol() link", NSStringFromSelector(aSelector));
    }

    return result;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    id <IAdaptedPropertyAccessor> accessor = [_holder.accessors objectForKey:NSStringFromSelector(anInvocation.selector)];
    if (accessor != nil) {
        if ([accessor isKindOfClass:[CAdaptedCommonSetter class]]) {
            [self willChangeValueForKey:accessor.propertyName];
        }
        [accessor performWithInvocation:anInvocation
                               delegate:_state];
        if ([accessor isKindOfClass:[CAdaptedCommonSetter class]]) {
            [self didChangeValueForKey:accessor.propertyName];
        }
    }
    else {
        NSLog(@"MutableDictionaryAdapter can't detect invocation %@. \n"
                "\nMay be you forgot adapt some class by propertyDescriptor or "
                "note propertyDescriptor in source code through @protocol() link", anInvocation);
        [super forwardInvocation:anInvocation];
    }
}

- (id)valueForKey:(NSString *)key {
    return [_state valueForKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [_state setValue:value forKey:key];
}


- (id)copyWithZone:(NSZone *)zone {
    NSMutableDictionary *copyOfState = [_state mutableCopy];
    ARHCMutableDictionaryPropertiesAdapter *result = [[ARHCMutableDictionaryPropertiesAdapter alloc] initWithDictionary:copyOfState];
    return result;
}

@end