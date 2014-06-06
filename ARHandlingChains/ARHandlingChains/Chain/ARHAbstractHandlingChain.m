//
// Created by Alexey Rogatkin on 18.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHAbstractHandlingChain.h"
#import "ARHAbstractChainElement.h"

void contextFinalizer (void *context)
{
    CFRelease (context);
}

@implementation ARHAbstractHandlingChain
{
@private
    NSArray *_elements;
    dispatch_semaphore_t _initializationSemaphore;
}

#pragma mark - Initialization

- (id)initWithElements:(NSArray *)elements;
{
    self = [super init];
    if (self)
    {
        _elements = elements;
        _masterQueue = dispatch_queue_create ("ru.idecide.jacarta.initChain.handling.master", DISPATCH_QUEUE_SERIAL);
        _initializationSemaphore = dispatch_semaphore_create (1);
    }
    return self;
}


#pragma mark - Interface behavior methods

- (void)handle
{
    [self handleWithInitialContext:@{ }];
}

- (void)handleWithInitialContext:(NSDictionary *)initialContext
{
    dispatch_semaphore_wait (_initializationSemaphore, DISPATCH_TIME_FOREVER);
    dispatch_async (_masterQueue, ^
    {
        [self cancelHandling];

        NSMutableDictionary *context = [[NSMutableDictionary alloc] initWithDictionary:initialContext];
        _handlingQueue = [self createSuspendedQueueWithContext:context];
        [self composeQueue:_handlingQueue];
        dispatch_resume (_handlingQueue);
        dispatch_semaphore_signal (_initializationSemaphore);
    });
}

- (void)cancelHandling
{
    if (_handlingQueue == nil)
    {
        return;
    }
    NSMutableDictionary *context = (__bridge NSMutableDictionary *) dispatch_get_context (_handlingQueue);
    [context setObject:@""
                forKey:kChainContextKeyCancelExecution];
    _tempQueue = _handlingQueue;
    _handlingQueue = nil;
}

- (NSMutableDictionary *)waitForCompleteAndCopyContext
{
    dispatch_semaphore_wait (_initializationSemaphore, DISPATCH_TIME_FOREVER);

    if (_handlingQueue == nil)
    {
        NSLog(@"Cancel waiting: handling chain is nil");
        return nil;
    }

    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    dispatch_sync (_handlingQueue, ^
    {
        [result addEntriesFromDictionary:(__bridge NSMutableDictionary *) dispatch_get_context (dispatch_get_current_queue ())];
    });

    dispatch_semaphore_signal (_initializationSemaphore);
    return result;
}



#pragma mark - Supporting and utils private methods


- (void)composeQueue:(dispatch_queue_t)queue
{
    for (id element in _elements)
    {
        if ([element isKindOfClass:[ARHAbstractChainElement class]])
        {
            ARHAbstractChainElement *chainElement = (ARHAbstractChainElement *) element;
            dispatch_async (queue, ^
            {
                [chainElement handle];
            });
        }
    }
}

- (dispatch_queue_t)createSuspendedQueueWithContext:(NSMutableDictionary *)context
{
    dispatch_queue_t result = dispatch_queue_create ("ru.idecide.jacarta.initChain.handling", DISPATCH_QUEUE_SERIAL);
    dispatch_suspend (result);
    dispatch_set_context (result, (__bridge_retained CFMutableDictionaryRef) context);
    dispatch_set_finalizer_f (result, &contextFinalizer);

    return result;
}

@end