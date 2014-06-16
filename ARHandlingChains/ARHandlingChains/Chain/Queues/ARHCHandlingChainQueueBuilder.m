//
// Created by Alexey Rogatkin on 16.06.14.
//

#import "ARHCHandlingChainQueueBuilder.h"

@implementation ARHCHandlingChainQueueBuilder
{
    dispatch_queue_t _queue;
    ARHCHandlingChainQueue *_handlingChainQueue;
    Class _chainClass;
}

- (id)initWithChainClass:(Class)chainClass
{
    self = [super init];
    if (self)
    {
        [self reinitialize];
        _chainClass = chainClass;
    }
    return self;
}



- (void)reinitialize
{
    _queue = dispatch_queue_create ("com.equil.handling.chain", DISPATCH_QUEUE_SERIAL);
    dispatch_suspend (_queue);
    _handlingChainQueue = [[ARHCHandlingChainQueue alloc] initWithQueue:_queue];
}

- (void)add:(Class)elementClass
{
    @synchronized (self)
    {
        if (![elementClass isSubclassOfClass:[ARHAbstractChainElement class]]) {
            NSLog (@"Warning: chain contains unsupported element class %@. May be you forgot extend it from ARHAbstractChainElement?", elementClass);
            return;
        }

        ARHAbstractChainElement *element = [[elementClass alloc] init];
        dispatch_async (_queue, ^
        {
            [element handle];
        });
        element.queue = _handlingChainQueue;
        element.chainClass = _chainClass;
    }
}

- (void)setDelegate:(id <ARHIHandlingChainQueueDelegate>)delegate
{
    @synchronized (self)
    {
        _handlingChainQueue.delegate = delegate;
    }
}

- (void)setInitialContext:(NSMutableDictionary *)context
{
    [_handlingChainQueue.context addEntriesFromDictionary:context];
}

- (ARHCHandlingChainQueue *)build
{
    @synchronized (self)
    {
        ARHCHandlingChainQueue *result = _handlingChainQueue;

        [self reinitialize];

        return result;
    }
}

@end