//
// Created by Alexey Rogatkin on 19.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARHCMutableDictionaryPropertiesAdapter.h"
#import "ARHCHandlingChainQueue.h"

@interface ARHAbstractChainElement : NSObject

@property (nonatomic, assign) ARHCHandlingChainQueue *queue;

@property (nonatomic, readonly) id context;

@property (nonatomic, assign) Class chainClass;

- (void)handle;

- (BOOL)canProcess;

- (void)process;

@end