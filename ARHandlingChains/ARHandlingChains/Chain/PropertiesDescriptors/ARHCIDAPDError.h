//
// Created by Alexey Rogatkin on 28.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARHCIPropertiesDescriptor.h"
#import "CErrorHandle.h"

@protocol ARHCIDAPDError <ARHCIPropertiesDescriptor>

@optional

@property(nonatomic, strong) CErrorHandle *error;
@property(nonatomic, readonly) BOOL errorPresented;

@end