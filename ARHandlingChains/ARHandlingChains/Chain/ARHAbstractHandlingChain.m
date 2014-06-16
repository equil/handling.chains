//
// Created by Alexey Rogatkin on 18.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHAbstractHandlingChain.h"
#import "ARHAbstractChainElement.h"
#import "CEInitializeFutureContext.h"
#import "ARHCSingleExecutionQueuePool.h"
#import "ARHCHandlingChainQueueBuilder.h"

@implementation ARHAbstractHandlingChain
{
@private
    id <ARHIChainQueuesPool> _pool;
    NSArray *_elementsClasses;
    ARHCHandlingChainQueueBuilder *_queueBuilder;
}

#pragma mark - Initialization

- (id)initWithElementsClasses:(NSArray *)elements;
{
    return [self initWithElementsClasses:elements
                                    pool:[[ARHCSingleExecutionQueuePool alloc] init]];
}

- (id)initWithElementsClasses:(NSArray *)elements
                         pool:(id <ARHIChainQueuesPool>)pool
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

    NSMutableDictionary *initial = [initialContext mutableCopy];
    id <IPDFutureContext> adapter = (id <IPDFutureContext>) [[ARHCMutableDictionaryPropertiesAdapter alloc] initWithDictionary:initial];
    adapter.futureContext = result;

    [_queueBuilder setInitialContext:initial];
    [_queueBuilder setDelegate:_pool];
    for (Class elementClass in _elementsClasses)
    {
        [_queueBuilder add:elementClass];
    }
    [_queueBuilder add:[CEInitializeFutureContext class]];

    ARHCHandlingChainQueue *queue = [_queueBuilder build];

    result.respondedQueue = queue;

    [_pool placeToPool:queue];

    return result;
}

@end