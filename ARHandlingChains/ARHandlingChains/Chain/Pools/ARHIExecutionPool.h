//
// Created by Alexey Rogatkin on 16.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHIHandlingChainQueue.h"
#import "ARHIFutureContext.h"

@protocol ARHIExecutionPool <NSObject>

- (id <ARHIFutureContext>)executeQueue:(id<ARHIHandlingChainQueue>)queue;
- (void) cancelAllQueues;

@end