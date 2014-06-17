//
// Created by Alexey Rogatkin on 22.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHCHandlingChain.h"
#import "ARHAbstractChainElement.h"
#import "ARHCEInspectContextContext.h"
#import "CEErrorNotification.h"
#import "CECompleteNotification.h"
#import "ARHIChainQueuesExecutionStrategy.h"

NSString *const kARHCHandlingChainCompleteNotification = @"ARHCCompleteNotification";
NSString *const kARHCHandlingChainErrorNotification = @"ARHCErrorNotification";

@implementation ARHCHandlingChain
{
}

#pragma mark - Initialization

- (id)initWithElementsClasses:(NSArray *)elementsClasses
                         pool:(id <ARHIChainQueuesExecutionStrategy>)pool
{
    NSMutableArray *elements = [elementsClasses mutableCopy];
    [elements addObject:[CEErrorNotification class]];
    [elements addObject:[CECompleteNotification class]];
    return [super initWithElementsClasses:elementsClasses
                                     pool:pool];
}

#pragma mark - Public interface observing

- (void)registerCompleteObserver:(id)observer
                        selector:(SEL)selector
{
    [[NSNotificationCenter defaultCenter] addObserver:observer
                                             selector:selector
                                                 name:kARHCHandlingChainCompleteNotification
                                               object:[self class]];
}

- (void)registerErrorObserver:(id)observer
                     selector:(SEL)selector
{
    [[NSNotificationCenter defaultCenter] addObserver:observer
                                             selector:selector
                                                 name:kARHCHandlingChainErrorNotification
                                               object:[self class]];
}

- (void)removeCompleteObserver:(id)observer
{
    [[NSNotificationCenter defaultCenter] removeObserver:observer
                                                    name:kARHCHandlingChainCompleteNotification
                                                  object:[self class]];
}

- (void)removeErrorObserver:(id)observer
{
    [[NSNotificationCenter defaultCenter] removeObserver:observer
                                                    name:kARHCHandlingChainErrorNotification
                                                  object:[self class]];
}

@end