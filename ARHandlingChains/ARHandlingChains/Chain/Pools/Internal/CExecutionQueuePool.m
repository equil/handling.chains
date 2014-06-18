//
// Created by Alexey Rogatkin on 18.06.14.
//

#import "CExecutionQueuePool.h"
#import "ARHIHandlingChainQueue.h"
#import "IHandlingChainQueuePrivate.h"

@interface CExecutionQueuePool () <ARHIHandlingChainQueueDelegate>
@end

@implementation CExecutionQueuePool
{
}

- (id <ARHIFutureContext>)executeQueue:(id <ARHIHandlingChainQueue>)queue
{
    id<ARHIHandlingChainQueue, IHandlingChainQueuePrivate> privateQueue = (id<ARHIHandlingChainQueue, IHandlingChainQueuePrivate>)queue;
    if (queue != nil && !queue.handled)
    {
        [queue addDelegate:self];
        [self needToStart:queue];
    }
    return privateQueue.futureContext;
}

- (void)queueStarted:(id <ARHIHandlingChainQueue>)queue
{
    [self started:queue];
}

- (void)queueCompleted:(id <ARHIHandlingChainQueue>)queue
{
    [queue removeDelegate:self];
    [self completed:queue];
}

- (void)needToStart:(id <ARHIHandlingChainQueue>)queue
{
}

- (void)started:(id <ARHIHandlingChainQueue>)queue
{
}

- (void)needToComplete:(id <ARHIHandlingChainQueue>)queue
{
}

- (void)completed:(id <ARHIHandlingChainQueue>)queue
{
}

@end