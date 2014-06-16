//
// Created by Alexey Rogatkin on 28.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ARHCMutableDictionaryPropertiesAdapter.h"
#import "CWeakObjectHandle.h"
#import "ARHIPropertiesDescriptor.h"
#import "ARHIChainContextInspector.h"

@protocol ARHIDAPDContextInspector <ARHIPropertiesDescriptor>

@optional

@property (nonatomic, strong) id <ARHIChainContextInspector> inspector;
@property (nonatomic, readonly) BOOL inspectorPresented;

@end