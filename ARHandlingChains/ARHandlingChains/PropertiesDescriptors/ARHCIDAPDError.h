//
// Created by Alexey Rogatkin on 28.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARHIPropertiesDescriptor.h"
#import "ARHCErrorHandle.h"

@protocol ARHCIDAPDError <ARHIPropertiesDescriptor>

@optional

@property(nonatomic, strong) ARHCErrorHandle *error;
@property(nonatomic, readonly) BOOL errorPresented;

@end