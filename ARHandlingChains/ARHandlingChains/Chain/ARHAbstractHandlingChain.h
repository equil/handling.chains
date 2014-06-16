//
// Created by Alexey Rogatkin on 18.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARHIFutureContext.h"

@protocol ARHIChainQueuesPool;

@interface ARHAbstractHandlingChain : NSObject

- (id)initWithElementsClasses:(NSArray *)elements;
- (id)initWithElementsClasses:(NSArray *)elements
                         pool: (id <ARHIChainQueuesPool>)pool;

- (id<ARHIFutureContext>)handle;
- (id<ARHIFutureContext>)handleWithInitialContext:(NSDictionary *)initialContext;

@end