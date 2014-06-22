//
// Created by Alexey Rogatkin on 28.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ARHIPropertiesDescriptor.h"
#import "ARHIChainContextInspector.h"

@protocol ARHIContextInspectorPD <ARHIPropertiesDescriptor>

@optional

@property (nonatomic, strong) id <ARHIChainContextInspector> inspector;
@property (nonatomic, readonly) BOOL inspectorPresented;

@end