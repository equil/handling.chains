//
// Created by Alexey Rogatkin on 18.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHIExecutionPool.h"

@interface CExecutionQueuePool : NSObject<ARHIExecutionPool>

- (void)needToStart: (id <ARHIHandlingChainQueue>)queue;
- (void)started: (id <ARHIHandlingChainQueue>)queue;
- (void)needToComplete: (id <ARHIHandlingChainQueue>)queue;
- (void)completed: (id <ARHIHandlingChainQueue>)queue;

@end