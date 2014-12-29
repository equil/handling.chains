//
// Created by Alexey Rogatkin on 16.06.14.
//

#import "CHandlingChainQueue.h"
#import "ARHIExecutionPool.h"
#import "ARHCEnumerableWeakReferencesCollection.h"
#import "CFutureContext.h"

void contextFinalizer (void *context)
{
    CFRelease (context);
}

@interface CHandlingChainQueue (private)
@property (nonatomic, readonly) id <ARHIFutureContext> futureContext;

- (id)initWithQueue:(dispatch_queue_t)suspendedQueue;
- (void)execute;
- (void)cancel;
@end

@implementation CHandlingChainQueue
{
    dispatch_queue_t _queue;
    BOOL _started;
    ARHCEnumerableWeakReferencesCollection *_delegates;

    NSMutableDictionary *_context;

    CFutureContext *_futureContext;
    __weak CFutureContext *_weakFutureContext;
}

@synthesize canceled = _canceled;
@synthesize context = _context;

- (id)initWithQueue:(dispatch_queue_t)suspendedQueue
{
    self = [super init];
    if (self)
    {
        _queue = suspendedQueue;
        _context = [[NSMutableDictionary alloc] init];
        dispatch_set_context (_queue, (__bridge_retained CFMutableDictionaryRef) [NSMutableDictionary new]);
        dispatch_set_finalizer_f (_queue, &contextFinalizer);

        _canceled = NO;
        _started = NO;

        _delegates = [[ARHCEnumerableWeakReferencesCollection alloc] init];
        _futureContext = [[CFutureContext alloc] init];
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

            [_futureContext set:[[ARHCMutableDictionaryPropertiesAdapter alloc] initWithDictionary:self.context]];

            [self propagateCompleteEvent];

            _weakFutureContext = _futureContext;
            _futureContext = nil;
            dispatch_suspend(_queue);
        });

        [self propagateStartedEvent];

        dispatch_resume (_queue);
    }
}

- (void)propagateStartedEvent
{
    for (id <ARHIHandlingChainQueueDelegate> delegate in _delegates)
    {
        if ([delegate respondsToSelector:@selector(queueStarted:)])
        {
            [delegate queueStarted:self];
        }
    }
}

- (void)propagateCompleteEvent
{
    for (id <ARHIHandlingChainQueueDelegate> delegate in _delegates)
    {
        if ([delegate respondsToSelector:@selector(queueCompleted:)])
        {
            [delegate queueCompleted:self];
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
    [_delegates addObject:(id) delegate];
}

- (void)removeDelegate:(id <ARHIHandlingChainQueueDelegate>)delegate
{
    [_delegates removeObject:(id) delegate];
}

- (id <ARHIFutureContext>)futureContext
{
    if (_futureContext == nil)
    {
        return _weakFutureContext;
    }
    return _futureContext;
}

- (void)dealloc {
    dispatch_resume(_queue);
}

@end