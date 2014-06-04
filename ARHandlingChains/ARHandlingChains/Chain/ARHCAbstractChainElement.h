//
// Created by Alexey Rogatkin on 19.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARHCCMutableDictionaryPropertiesAdapter.h"

extern NSString *const kChainContextKeyCancelExecution;

@interface ARHCAbstractChainElement : NSObject

@property (nonatomic, readonly) NSMutableDictionary *internalContext;
@property (nonatomic, readonly) ARHCCMutableDictionaryPropertiesAdapter *context;
@property (nonatomic, assign) BOOL mustCancel;
@property (nonatomic, assign) Class chainClass;

- (void)handle;

- (BOOL)canProcess;

- (void) process;

@end