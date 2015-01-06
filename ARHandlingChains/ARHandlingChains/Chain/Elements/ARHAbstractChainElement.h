//
// Created by Alexey Rogatkin on 19.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARHAbstractChainElement : NSObject

@property (nonatomic, readonly) id context;
@property (readonly) BOOL mustCancelExecution;

- (BOOL)canProcess;

- (void)process;

- (void)cancelingInitiated;

@end