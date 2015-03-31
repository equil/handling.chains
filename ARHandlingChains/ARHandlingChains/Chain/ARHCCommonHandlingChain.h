
//
// Created by Alexey Rogatkin on 22.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARHAbstractHandlingChain.h"

extern NSString *const kARHCHandlingChainCompleteNotification;
extern NSString *const kARHCHandlingChainErrorNotification;

@interface ARHCCommonHandlingChain : ARHAbstractHandlingChain

- (void)registerCompleteObserver:(id)observer
                        selector: (SEL) selector;
- (void)registerErrorObserver:(id)observer
                     selector:(SEL)selector;

- (void)removeCompleteObserver:(id)observer;
- (void)removeErrorObserver:(id)observer;

@end