//
// Created by Alexey Rogatkin on 21.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CErrorHandle : NSObject

@property (nonatomic, strong) NSMutableDictionary *customInfo;
@property (nonatomic, assign) Class elementClass;
@property (nonatomic, assign) Class chainClass;

@end