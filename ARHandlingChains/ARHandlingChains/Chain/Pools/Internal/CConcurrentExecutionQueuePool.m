//
// Created by Alexey Rogatkin on 19.06.14.
//

#import "CConcurrentExecutionQueuePool.h"
#import "IHandlingChainQueuePrivate.h"

@implementation CConcurrentExecutionQueuePool
{
    dispatch_queue_t _queue;
    NSMutableArray *_futures;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _queue = dispatch_queue_create ("com.equil.handling.chain.CConcurrentExecutionQueuePool", DISPATCH_QUEUE_CONCURRENT);
        _futures = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)needToStart:(id <ARHIHandlingChainQueue, IHandlingChainQueuePrivate>)queue
{
    @synchronized (self)
    {
        dispatch_async (_queue, ^
        {
            [queue execute];
        });
    }
}

- (void)started:(id <ARHIHandlingChainQueue, IHandlingChainQueuePrivate>)queue
{
    @synchronized (self)
    {
        [_futures addObject:(id) queue.futureContext];
    }
}

- (void)completed:(id <ARHIHandlingChainQueue, IHandlingChainQueuePrivate>)queue
{
    @synchronized (self)
    {
        id futureContext = queue.futureContext;
        if (futureContext != nil)
        {
            [_futures removeObject:futureContext];
        }
    }
}

- (void)cancelAllQueues
{
    @synchronized (self)
    {
        for (id <ARHIFutureContext> futureContext in _futures)
        {
            [futureContext cancelHandling];
        }
    }
}

@end