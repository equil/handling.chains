//
// Created by Alexey Rogatkin on 27.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARHCMutableDictionaryPropertiesAdapter : NSObject

@property (nonatomic, readonly) NSDictionary *state;

- (instancetype)initWithDictionary:(NSMutableDictionary *)state;

@end