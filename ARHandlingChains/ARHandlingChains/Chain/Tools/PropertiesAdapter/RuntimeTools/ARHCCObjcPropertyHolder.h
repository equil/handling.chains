//
// Created by Alexey Rogatkin on 04.06.14.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface ARHCCObjcPropertyHolder : NSObject

@property (readonly) objc_property_t property;

- (instancetype)initWithProperty:(objc_property_t)property;
+ (instancetype)holderWithProperty:(objc_property_t)property;

@end