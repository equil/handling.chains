//
// Created by Alexey Rogatkin on 01.06.14.
//

#import <objc/runtime.h>
#import "ARHCCAdaptedPropertyAccessor.h"

@implementation ARHCCAdaptedPropertyAccessor

#pragma mark - Initialization

@synthesize accessorName = _accessorName;
@synthesize accessorType = _accessorType;

- (instancetype)initWithObjcProperty:(objc_property_t)property
                        accessorType:(ARHCCAdaptedPropertyAccessorType)type
{
    if (property == nil)
    {
        return nil;
    }

    self = [super init];
    if (self != nil)
    {
        _accessorType = type;
    }
    return self;
}

#pragma mark - Forward invocation for adapter support

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
}

@end