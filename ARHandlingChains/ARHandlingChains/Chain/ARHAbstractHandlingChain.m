//
// Created by Alexey Rogatkin on 18.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHAbstractHandlingChain.h"
#import "CHandlingChainQueueBuilder.h"

@implementation ARHAbstractHandlingChain
{
@private
    NSArray *_elementsClasses;
    CHandlingChainQueueBuilder *_queueBuilder;
}

#pragma mark - Initialization

- (id)initWithElementsClasses:(NSArray *)elements
{
    self = [super init];
    if (self)
    {
        _elementsClasses = elements;
        _queueBuilder = [[CHandlingChainQueueBuilder alloc] initWithChain:self];
    }
    return self;
}



#pragma mark - Interface behavior methods

- (id <ARHIHandlingChainQueue>)buildQueue
{
    return [self buildQueueWithInitialContext:@{ }];
}

- (id <ARHIHandlingChainQueue>)buildQueueWithInitialContext:(NSDictionary *)initialContext
{
    [_queueBuilder setInitialContext:[initialContext mutableCopy]];
    for (Class elementClass in _elementsClasses)
    {
        [_queueBuilder add:elementClass];
    }
    return [_queueBuilder build];
}

@end