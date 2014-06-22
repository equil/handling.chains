//
// Created by Alexey Rogatkin on 21.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "CWeakObjectHolder.h"

@implementation CWeakObjectHolder
{
    NSPointerArray *_array;
}

- (instancetype)initWithObject:(NSObject *)object
{
    self = [super init];
    if (self)
    {
        _array = [NSPointerArray weakObjectsPointerArray];
        [_array addPointer:(__bridge void *) object];
    }

    return self;
}

+ (instancetype)handleWithObject:(NSObject *)object
{
    return [[self alloc] initWithObject:object];
}

- (NSObject *)weakReference
{
    NSObject *pointer = (__bridge NSObject *) [_array pointerAtIndex:0];
    return pointer;
}

@end