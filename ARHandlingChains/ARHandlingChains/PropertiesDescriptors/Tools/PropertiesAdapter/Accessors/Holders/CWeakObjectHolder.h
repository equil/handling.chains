//
// Created by Alexey Rogatkin on 21.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CWeakObjectHolder : NSObject

@property (nonatomic, readonly) NSObject *weakReference;

+ (instancetype)handleWithObject:(NSObject *)object;

@end