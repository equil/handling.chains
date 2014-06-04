//
// Created by Alexey Rogatkin on 04.06.14.
//

#import "ARHCCObjcPropertyHolder.h"

@implementation ARHCCObjcPropertyHolder
{
}

- (instancetype)initWithProperty:(objc_property_t)property
{
    self = [super init];
    if (self)
    {
        _property = property;
    }
    return self;
}

+ (instancetype)holderWithProperty:(objc_property_t)property
{
    return [[self alloc] initWithProperty:property];
}

@end