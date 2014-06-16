//
// Created by Alexey Rogatkin on 21.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARHCErrorHandle : NSObject

@property (nonatomic, strong) NSDictionary *additionalInfo;
@property (nonatomic, assign) Class elementClass;
@property (nonatomic, assign) Class chainClass;

@end