//
// Created by Alexey Rogatkin on 16.06.14.
//

#import "CHandlingChainQueueBuilder.h"
#import "IChainElementPrivate.h"
#import "ARHAbstractHandlingChain.h"

@implementation CHandlingChainQueueBuilder
{
    dispatch_queue_t _queue;
    id <ARHIHandlingChainQueue, IHandlingChainQueuePrivate> _handlingChainQueue;
    __weak ARHAbstractHandlingChain *_chain;
}

- (id)initWithChain:(ARHAbstractHandlingChain *)chain
{
    self = [super init];
    if (self)
    {
        [self reinitialize];
        _chain = chain;
    }
    return self;
}

- (void)reinitialize
{
    _queue = dispatch_queue_create ("com.equil.handling.chain", DISPATCH_QUEUE_SERIAL);
    dispatch_suspend (_queue);
    _handlingChainQueue = [[CHandlingChainQueue alloc] initWithQueue:_queue];
}

- (void)add:(Class)elementClass
{
    @synchronized (self)
    {
        if (![elementClass isSubclassOfClass:[ARHAbstractChainElement class]])
        {
            NSLog (@"Warning: chain contains unsupported element class %@. May be you forgot extend it from ARHAbstractChainElement?", elementClass);
            return;
        }

        ARHAbstractChainElement<IChainElementPrivate> *element = [[elementClass alloc] init];
        dispatch_async (_queue, ^
        {
            [element handle];
        });
        element.queue = _handlingChainQueue;
        element.chain = _chain;
    }
}

- (void)addDelegate:(id <ARHIHandlingChainQueueDelegate>)delegate
{
    @synchronized (self)
    {
        [_handlingChainQueue addDelegate:delegate];
    }
}

- (void)setInitialContext:(NSMutableDictionary *)context
{
    [_handlingChainQueue.context addEntriesFromDictionary:context];
}

- (id <ARHIHandlingChainQueue>)build
{
    @synchronized (self)
    {
        id <ARHIHandlingChainQueue> result = _handlingChainQueue;

        [self reinitialize];

        return result;
    }
}

@end