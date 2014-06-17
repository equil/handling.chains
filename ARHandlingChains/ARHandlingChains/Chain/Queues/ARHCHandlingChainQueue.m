//
// Created by Alexey Rogatkin on 16.06.14.
//

#import "ARHCHandlingChainQueue.h"
#import "ARHIChainQueuesPool.h"
#import "ARHIHandlingChainQueueDelegate.h"

void contextFinalizer (void *context)
{
    CFRelease (context);
}

@implementation ARHCHandlingChainQueue
{
    dispatch_queue_t _queue;
    BOOL _started;
    NSMutableArray *_delegates;
}

@synthesize canceled = _canceled;

- (id)initWithQueue:(dispatch_queue_t)queue
{
    self = [super init];
    if (self)
    {
        _queue = queue;
        dispatch_set_context (_queue, (__bridge_retained CFMutableDictionaryRef) [NSMutableDictionary new]);
        dispatch_set_finalizer_f (_queue, &contextFinalizer);

        _canceled = NO;
        _started = NO;

        _delegates = [NSPointerArray weakObjectsPointerArray];
    }
    return self;
}

- (void)execute
{
    @synchronized (self)
    {
        if (_started)
        {
            return;
        }

        _started = YES;

        dispatch_async (_queue, ^
        {
            _started = NO;
            _queue = nil;
            [self propagateCompleteEvent];
        });

        [self propagateStartedEvent];

        dispatch_resume (_queue);
    }
}

- (void)propagateStartedEvent
{
    for (id <ARHIHandlingChainQueueDelegate> (^delegateAccessor) () in _delegates)
    {
        if ([delegateAccessor() respondsToSelector:@selector(queueStarted:)])
        {
            [delegateAccessor() queueStarted:self];
        }
    }
}

- (void)propagateCompleteEvent
{
    for (id <ARHIHandlingChainQueueDelegate> (^delegateAccessor) () in _delegates)
    {
        if ([delegateAccessor() respondsToSelector:@selector(queueCompleted:canceled:)])
        {
            [delegateAccessor() queueCompleted:self
                            canceled:_canceled];
        }
    }
}

- (void)cancel
{
    @synchronized (self)
    {
        if (!_started || _queue == nil)
        {
            return;
        }
        _canceled = YES;
    }
}

- (BOOL)handled
{
    return _queue == nil;
}

- (NSMutableDictionary *)context
{
    return (__bridge NSMutableDictionary *) dispatch_get_context (_queue);
}

- (void)addDelegate:(id <ARHIHandlingChainQueueDelegate>)delegate
{
    @synchronized (_delegates)
    {
        int index = [self indexOfDelegate:delegate];
        if (index == -1)
        {
            __weak id weakDelegate = delegate;
            [_delegates addObject:[^
            {
                return weakDelegate;
            } copy]];
        }
    }
}

- (void)removeDelegate:(id <ARHIHandlingChainQueueDelegate>)delegate
{
    @synchronized (_delegates)
    {
        int indexToDelete = [self indexOfDelegate:delegate];
        if (indexToDelete != -1)
        {
            [_delegates removeObjectAtIndex:(NSUInteger) indexToDelete];
        }
    }
}

- (int)indexOfDelegate:(id <ARHIHandlingChainQueueDelegate>)delegate
{
    @synchronized (_delegates)
    {
        [self compactDelegateCollection];

        int indexOfDelegate = -1;
        for (unsigned int i = 0; i < _delegates.count; i++)
        {
            id <ARHIHandlingChainQueueDelegate> (^delegateAccessor) () = [_delegates objectAtIndex:i];
            if (delegateAccessor () != nil && delegateAccessor () == delegate)
            {
                indexOfDelegate = i;
            }
        }
        return indexOfDelegate;
    }
}

- (void)compactDelegateCollection
{
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];

    for (unsigned int i = 0; i < _delegates.count; i++)
    {
        id <ARHIHandlingChainQueueDelegate> (^delegateAccessor) () = [_delegates objectAtIndex:i];
        if (delegateAccessor () == nil)
        {
            [indexSet addIndex:i];
        }
    }

    [_delegates removeObjectsAtIndexes:indexSet];
}

@end