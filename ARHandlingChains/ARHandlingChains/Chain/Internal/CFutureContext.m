//
// Created by Alexey Rogatkin on 16.06.14.
//

#import "CFutureContext.h"

@implementation CFutureContext
{
    ARHCMutableDictionaryPropertiesAdapter *_contextAfterExecution;
    dispatch_semaphore_t _semaphore;
}

@synthesize respondedQueue = _respondedQueue;

- (id)init
{
    self = [super init];
    if (self)
    {
        _semaphore = dispatch_semaphore_create (0);
    }
    return self;
}

- (id)get
{
    @synchronized (self)
    {
        dispatch_semaphore_wait (_semaphore, DISPATCH_TIME_FOREVER);
        ARHCMutableDictionaryPropertiesAdapter *result = _contextAfterExecution;
        _contextAfterExecution = nil;
        return result;
    }
}

- (void)set:(ARHCMutableDictionaryPropertiesAdapter *)contextAfterExecution
{
    @synchronized (self)
    {
        _contextAfterExecution = [contextAfterExecution copy];
        dispatch_semaphore_signal (_semaphore);
    }
}

- (void)queueCompleted:(ARHCHandlingChainQueue *)queue
              canceled:(BOOL)isCanceled
{
    ARHCMutableDictionaryPropertiesAdapter *context = nil;
    if (!isCanceled) {
        context = [[ARHCMutableDictionaryPropertiesAdapter alloc] initWithDictionary:queue.context];
    }
    [self set:context];
}

- (void)cancelHandling
{
    [self.respondedQueue cancel];
}

@end