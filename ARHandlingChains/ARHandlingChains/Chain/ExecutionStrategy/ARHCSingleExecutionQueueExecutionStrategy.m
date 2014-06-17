//
// Created by Alexey Rogatkin on 16.06.14.
//

#import "ARHCSingleExecutionQueueExecutionStrategy.h"

@implementation ARHCSingleExecutionQueueExecutionStrategy
{
@private
    NSMutableSet *_toDelete;
    ARHCHandlingChainQueue *_current;
    ARHCHandlingChainQueue *_toExecute;

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

- (void)placeToPool:(ARHCHandlingChainQueue *)queue
{
    if (queue == nil || queue.handled)
    {
        return;
    }

    dispatch_semaphore_wait (_startingSemaphore, DISPATCH_TIME_FOREVER);
    _toExecute = queue;
    [_toDelete addObject:_current];
    [_current cancel];
    _current = nil;
    [_toExecute execute];
}

- (void)queueStarted:(ARHCHandlingChainQueue *)queue
{
    if (queue != _toExecute)
    {
        NSLog (@"Error: started queue %@ not expected to execute.", queue);
    }
    _current = _toExecute;
    _toExecute = nil;
    dispatch_semaphore_signal (_startingSemaphore);
}



- (void)queueCompleted:(ARHCHandlingChainQueue *)queue
              canceled:(BOOL)isCanceled
{
    if (_current == queue)
    {
        _current = nil;
    }
    [_toDelete removeObject:queue];
}

@end