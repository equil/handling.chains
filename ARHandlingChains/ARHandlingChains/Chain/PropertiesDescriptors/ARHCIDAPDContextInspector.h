//
// Created by Alexey Rogatkin on 28.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ARHCCMutableDictionaryPropertiesAdapter.h"
#import "CWeakObjectHandle.h";
#import "ARHCIPropertiesDescriptor.h"

@protocol ARHCIDAPDContextInspector <ARHCIPropertiesDescriptor>

@optional

@property (nonatomic, strong) CWeakObjectHandle *inspector;
@property (nonatomic, readonly) BOOL inspectorPresented;

@end