//
// Created by Alexey Rogatkin on 22.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHCCommonHandlingChain.h"
#import "ARHAbstractChainElement.h"
#import "ARHCEInspectContextChainElement.h"
#import "CEErrorNotification.h"
#import "CECompleteNotification.h"
#import "ARHCEnumerableWeakReferencesCollection.h"

NSString *const kARHCHandlingChainCompleteNotification = @"ARHCCompleteNotification";
NSString *const kARHCHandlingChainErrorNotification = @"ARHCErrorNotification";

@implementation ARHCCommonHandlingChain
{
    ARHCEnumerableWeakReferencesCollection *_observers;
}

#pragma mark - Initialization

- (id)initWithElementsClasses:(NSArray *)elementsClasses
{
    NSMutableArray *elements = [elementsClasses mutableCopy];
    [elements addObject:[CEErrorNotification class]];
    [elements addObject:[CECompleteNotification class]];
    self = [super initWithElementsClasses:elementsClasses];
    if (self)
    {
        _observers = [[ARHCEnumerableWeakReferencesCollection alloc] init];
    }
    return self;
}

#pragma mark - Public interface observing

- (void)registerCompleteObserver:(id)observer
                        selector:(SEL)selector
{
    [self registerObserver:observer
                  selector:selector
          notificationName:kARHCHandlingChainCompleteNotification];
}

- (void)registerErrorObserver:(id)observer
                     selector:(SEL)selector
{
    [self registerObserver:observer
                  selector:selector
          notificationName:kARHCHandlingChainErrorNotification];
}

- (void)registerObserver:(id)observer
                selector:(SEL)selector
        notificationName:(NSString *)name
{
    [_observers addObject:observer];
    [_observers onDeallocElement:observer
                              do:^
                              {
                                  [[NSNotificationCenter defaultCenter] removeObserver:observer
                                                                                  name:name
                                                                                object:self];
                              }];
    [[NSNotificationCenter defaultCenter] addObserver:observer
                                             selector:selector
                                                 name:name
                                               object:self];
}


@end