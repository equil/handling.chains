//
// Created by Alexey Rogatkin on 28.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARHIPropertiesDescriptor.h"
#import "ARHCErrorHolder.h"

@protocol ARHIErrorPD <ARHIPropertiesDescriptor>

@optional

@property(nonatomic, strong) ARHCErrorHolder *error;
@property(nonatomic, readonly) BOOL errorPresented;

@end