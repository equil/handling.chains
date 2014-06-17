//
// Created by Alexey Rogatkin on 18.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHAbstractHandlingChain.h"
#import "ARHAbstractChainElement.h"
#import "ARHCSingleExecutionQueueExecutionStrategy.h"
#import "ARHCHandlingChainQueueBuilder.h"
#import "CFutureContext.h"

@implementation ARHAbstractHandlingChain
{
@private
    id <ARHIChainQueuesExecutionStrategy> _pool;
    NSArray *_elementsClasses;
    ARHCHandlingChainQueueBuilder *_queueBuilder;
}

#pragma mark - Initialization

- (id)initWithElementsClasses:(NSArray *)elements;
{
    return [self initWithElementsClasses:elements
                                    pool:[[ARHCSingleExecutionQueueExecutionStrategy alloc] init]];
}

- (id)initWithElementsClasses:(NSArray *)elements
                         pool:(id <ARHIChainQueuesExecutionStrategy>)pool
{
    self = [super init];
    if (self)
    {
        _elementsClasses = elements;
        _pool = pool;
        _queueBuilder = [[ARHCHandlingChainQueueBuilder alloc] initWithChainClass:[self class]];
    }
    return self;
}



#pragma mark - Interface behavior methods

- (id <ARHIFutureContext>)handle
{
    return [self handleWithInitialContext:@{ }];
}

- (id <ARHIFutureContext>)handleWithInitialContext:(NSDictionary *)initialContext
{
    CFutureContext *result = [[CFutureContext alloc] init];

    [_queueBuilder setInitialContext:[initialContext mutableCopy]];
    [_queueBuilder addDelegate:_pool];
    [_queueBuilder addDelegate:result];
    for (Class elementClass in _elementsClasses)
    {
        [_queueBuilder add:elementClass];
    }

    ARHCHandlingChainQueue *queue = [_queueBuilder build];

    result.respondedQueue = queue;

    [_pool placeToPool:queue];

    return result;
}

@end