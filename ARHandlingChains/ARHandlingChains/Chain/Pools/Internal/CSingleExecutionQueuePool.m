//
// Created by Alexey Rogatkin on 16.06.14.
//

#import "CSingleExecutionQueuePool.h"
#import "IHandlingChainQueuePrivate.h"

@implementation CSingleExecutionQueuePool
{
@private
    NSMutableSet *_toDelete;
    id <ARHIHandlingChainQueue, IHandlingChainQueuePrivate> _current;
    id <ARHIHandlingChainQueue, IHandlingChainQueuePrivate> _toExecute;

    dispatch_semaphore_t _startingSemaphore;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _startingSemaphore = dispatch_semaphore_create (1);
        _toDelete = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)needToStart:(id <ARHIHandlingChainQueue>)queue
{
    if (_current != nil)
    {
        [_toDelete addObject:_current];
        [_current cancel];
        _current = nil;
    }
    _toExecute = (id <ARHIHandlingChainQueue, IHandlingChainQueuePrivate>) queue;
    [_toExecute execute];
}

- (void)started:(id <ARHIHandlingChainQueue>)queue
{
    _current = _toExecute;
    _toExecute = nil;
}

- (void)needToComplete:(id <ARHIHandlingChainQueue>)queue
{
    if (_current == queue)
    {
        [_toDelete addObject:_current];
        _current = nil;
    }
}

- (void)completed:(id <ARHIHandlingChainQueue>)queue
{
    [_toDelete removeObject:queue];
}

- (void)cancelAllQueues
{
    [_current cancel];
    [_toExecute cancel];
}


@end