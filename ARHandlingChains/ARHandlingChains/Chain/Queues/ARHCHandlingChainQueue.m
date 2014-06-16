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
}

@synthesize canceled = _canceled;
@synthesize delegate = _delegate;

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
            [_delegate queueCompleted:self
                             canceled:_canceled];
        });

        [_delegate queueStarted:self];
        dispatch_resume (_queue);
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

@end