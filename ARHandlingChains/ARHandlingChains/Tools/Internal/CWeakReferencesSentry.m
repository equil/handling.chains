//
// Created by Alexey Rogatkin on 18.06.14.
//

#import "CWeakReferencesSentry.h"
#import "ARHCEnumerableWeakReferencesCollection.h"

char const *kWeakReferencesSentryKey = "WeakReferencesSentryKey";

@interface ARHCEnumerableWeakReferencesCollection (
private)

- (void)detachHash:(NSUInteger)hash;
@end

@implementation CWeakReferencesSentry
{
    NSMutableSet *_collections;
    NSUInteger _hash;
}

@synthesize collections = _collections;

- (instancetype)initWithHash:(NSUInteger)hash
{
    self = [super init];
    if (self)
    {
        _hash = hash;
        _collections = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)dealloc
{
    for (ARHCEnumerableWeakReferencesCollection *referencesCollection in _collections)
    {
        [referencesCollection detachHash:_hash];
    }
}

@end