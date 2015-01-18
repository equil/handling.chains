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
    dispatch_semaphore_wait (_semaphore, DISPATCH_TIME_FOREVER);
    ARHCMutableDictionaryPropertiesAdapter *result = _contextAfterExecution;
    _contextAfterExecution = nil;
    return result;
}

- (void)set:(ARHCMutableDictionaryPropertiesAdapter *)contextAfterExecution
{
    _contextAfterExecution = [contextAfterExecution copy];
    dispatch_semaphore_signal (_semaphore);
}

- (void)cancelHandling
{
    _context
    [self.respondedQueue cancel];
}

@end