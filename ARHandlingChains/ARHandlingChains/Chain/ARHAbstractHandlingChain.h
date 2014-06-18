//
// Created by Alexey Rogatkin on 18.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARHIFutureContext.h"
#import "ARHIHandlingChainQueue.h"

@protocol ARHIExecutionPool;

@interface ARHAbstractHandlingChain : NSObject

- (id)initWithElementsClasses:(NSArray *)elements;

- (id<ARHIHandlingChainQueue>)buildQueue;
- (id<ARHIHandlingChainQueue>)buildQueueWithInitialContext:(NSDictionary *)initialContext;

@end