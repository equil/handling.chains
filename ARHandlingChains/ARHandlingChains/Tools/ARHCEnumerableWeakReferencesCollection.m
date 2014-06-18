//
// Created by Alexey Rogatkin on 18.06.14.
//

#import <objc/runtime.h>
#import "ARHCEnumerableWeakReferencesCollection.h"
#import "CWeakReferencesSentry.h"

@interface ARHCEnumerableWeakReferencesCollection (
private)

- (void)detachHash:(NSUInteger)hash;
@end

@implementation ARHCEnumerableWeakReferencesCollection
{
    NSMutableSet *_internalSet;
    NSMutableDictionary *_onEnumerationTemp;
    NSMutableDictionary *_onDeallocCallbacks;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _internalSet = [[NSMutableSet alloc] init];
        _onEnumerationTemp = [[NSMutableDictionary alloc] init];
        _onDeallocCallbacks = [[NSMutableDictionary alloc] init];
    }

    return self;
}

- (void)addObject:(NSObject *)object
{
    NSUInteger hash = (NSUInteger) object;
    @synchronized (_internalSet)
    {
        [_internalSet addObject:@(hash)];
    }

    CWeakReferencesSentry *sentry = objc_getAssociatedObject (object, kWeakReferencesSentryKey);
    if (sentry == nil)
    {
        sentry = [[CWeakReferencesSentry alloc] initWithHash:hash];
        objc_setAssociatedObject (object, kWeakReferencesSentryKey, sentry, OBJC_ASSOCIATION_RETAIN);
    }
    [sentry.collections addObject:self];
}

- (void)removeObject:(NSObject *)object
{
    NSUInteger hash = (NSUInteger) object;
    @synchronized (_internalSet)
    {
        [_internalSet removeObject:@(hash)];
        [_onDeallocCallbacks removeObjectForKey:@(hash)];
    }
    CWeakReferencesSentry *sentry = objc_getAssociatedObject (object, kWeakReferencesSentryKey);
    if (sentry != nil)
    {
        [sentry.collections removeObject:self];
    }
}

- (void)onDeallocElement:(NSObject *)object
                      do:(void (^)())block
{
    NSUInteger hash = (NSUInteger) object;
    @synchronized (_internalSet)
    {
        if ([[_internalSet member:@(hash)] isEqual:@(hash)])
        {
            NSMutableArray *callbacks = [_onDeallocCallbacks objectForKey:@(hash)];
            if (callbacks == nil) {
                callbacks = [[NSMutableArray alloc] init];
                [_onDeallocCallbacks setObject:callbacks
                                        forKey:@(hash)];
            }
            [callbacks addObject:[block copy]];
        }
    }
}

- (void)detachHash:(NSUInteger)hash
{
    @synchronized (_internalSet)
    {
        [_internalSet removeObject:@(hash)];
        NSMutableArray *callbacks = [_onDeallocCallbacks objectForKey:@(hash)];
        for (void (^callback)() in callbacks)
        {
            callback();
        }
        [_onDeallocCallbacks removeObjectForKey:@(hash)];
    }
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)len
{
    NSUInteger count = 0;
    unsigned long countOfItemsAlreadyEnumerated = state->state;

    NSMutableArray *tempObjects;
    if (countOfItemsAlreadyEnumerated == 0)
    {
        NSNumber *key = [self getNextKeyForTemp];
        tempObjects = [[NSMutableArray alloc] init];

        [_onEnumerationTemp setObject:tempObjects
                               forKey:key];

        @synchronized (_internalSet)
        {
            for (NSNumber *hash in _internalSet)
            {
                [tempObjects addObject:(__bridge id) (void *) [hash unsignedIntegerValue]];
            }
        }

        state->mutationsPtr = &state->extra[ 0 ];
        state->extra[ 1 ] = [key unsignedLongValue];
    }
    tempObjects = [_onEnumerationTemp objectForKey:@(state->extra[ 1 ])];

    if (countOfItemsAlreadyEnumerated < tempObjects.count)
    {
        state->itemsPtr = buffer;
        while ((countOfItemsAlreadyEnumerated < tempObjects.count) && (count < len))
        {
            buffer[ count ] = tempObjects[ countOfItemsAlreadyEnumerated ];
            count++;
            countOfItemsAlreadyEnumerated++;
        }
    }

    state->state = countOfItemsAlreadyEnumerated;

    if (count == 0)
    {
        [_onEnumerationTemp removeObjectForKey:@(state->extra[ 1 ])];
    }

    return count;
}

- (NSNumber *)getNextKeyForTemp
{
    unsigned long maximum = 0;
    for (NSNumber *key in [_onEnumerationTemp allKeys])
    {
        if (maximum < [key unsignedLongValue])
        {
            maximum = [key unsignedLongValue];
        }
    }
    maximum += 1;
    return @(maximum);
}

@end


