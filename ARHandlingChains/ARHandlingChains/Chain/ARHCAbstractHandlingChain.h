//
// Created by Alexey Rogatkin on 18.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARHCAbstractHandlingChain : NSObject
{
@protected
    dispatch_queue_t _handlingQueue;
    dispatch_queue_t _tempQueue;
    dispatch_queue_t _masterQueue;
}

- (id)initWithElements:(NSArray *)elements;

- (void)handle;

- (void)handleWithInitialContext:(NSDictionary *)initialContext;

- (void)cancelHandling;

- (NSMutableDictionary *)waitForCompleteAndCopyContext;

@end