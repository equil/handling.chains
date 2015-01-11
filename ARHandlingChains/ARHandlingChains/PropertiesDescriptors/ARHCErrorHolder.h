//
// Created by Alexey Rogatkin on 21.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARHCErrorHolder : NSObject

@property (nonatomic, strong) id additionalInfo;
@property (nonatomic, assign) Class elementClass;
@property (nonatomic, assign) Class chainClass;

@property (nonatomic, strong) ARHCErrorHolder *rootError;

@end