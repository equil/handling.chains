//
// Created by Alexey Rogatkin on 17.06.14.
//

#import "ARHCSerialExecutionQueuePool.h"

@implementation ARHCSerialExecutionQueuePool
{
    NSMutableArray *_toExecute;
    ARHCHandlingChainQueue *_current;
    ARHCHandlingChainQueue *_starting;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _toExecute = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)placeToPool:(ARHCHandlingChainQueue *)queue
{
    @synchronized (self)
    {
        [_toExecute addObject:queue];
        if (_current == nil)
        {
            [self startNext];
        }
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

- (void)queueStarted:(ARHCHandlingChainQueue *)queue
{
    @synchronized (self)
    {
        if (queue != _starting)
        {
            NSLog (@"Error: unexpected queue of pool %@ started", [self class]);
            return;
        }

        if (_current != nil)
        {
            NSLog (@"Error: queue of pool %@ started when previous queue didn't finish execution", [self class]);
            return;
        }

        _current = _starting;
        _starting = nil;
    }
}

- (void)queueCompleted:(ARHCHandlingChainQueue *)queue
              canceled:(BOOL)isCanceled
{
    @synchronized (self)
    {
        if (queue != _current)
        {
            NSLog (@"Error: unexpected queue of pool %@ started", [self class]);
            return;
        }

        _current = nil;
        [self startNext];
    }
}

@end