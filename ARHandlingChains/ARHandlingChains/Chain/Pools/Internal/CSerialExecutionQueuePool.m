//
// Created by Alexey Rogatkin on 17.06.14.
//

#import "CSerialExecutionQueuePool.h"
#import "IHandlingChainQueuePrivate.h"

@implementation CSerialExecutionQueuePool
{
    NSMutableArray *_toExecute;
    id <ARHIHandlingChainQueue, IHandlingChainQueuePrivate> _current;
    id <ARHIHandlingChainQueue, IHandlingChainQueuePrivate> _starting;

    dispatch_semaphore_t _startingSemaphore;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _toExecute = [[NSMutableArray alloc] init];
        _startingSemaphore = dispatch_semaphore_create (1);
    }
    return self;
}

- (void)started:(id <ARHIHandlingChainQueue>)queue
{
    @synchronized (self)
    {
        _starting = nil;
        _current = (id <ARHIHandlingChainQueue, IHandlingChainQueuePrivate>) queue;
    }
}

- (void)completed:(id <ARHIHandlingChainQueue>)queue
{
    @synchronized (self)
    {
        _current = nil;
        [self startNext];
    }
}

- (void)needToStart:(id <ARHIHandlingChainQueue>)queue
{
    @synchronized (self)
    {
        [_toExecute addObject:queue];
        [self startNext];
    }
}

- (void)startNext
{
    if (_starting != nil || _current != nil || _toExecute.count < 1)
    {
        return;
    }
    _starting = [_toExecute objectAtIndex:0];
    [_toExecute removeObjectAtIndex:0];
    [_starting execute];
}

- (void)cancelAllQueues
{
    @synchronized (self)
    {
        [_toExecute removeAllObjects];
        [_current cancel];
        [_starting cancel];
    }
}

@end