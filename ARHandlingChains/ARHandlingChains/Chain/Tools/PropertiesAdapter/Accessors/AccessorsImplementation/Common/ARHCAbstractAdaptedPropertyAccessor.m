//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "ARHCAbstractAdaptedPropertyAccessor.h"

@implementation ARHCAbstractAdaptedPropertyAccessor

@synthesize accessorName = _accessorName;
@synthesize propertyName = _propertyName;
@synthesize defaultAccessorName = _defaultAccessorName;

- (id)initWithPropertyName:(NSString *)propertyName
{
    self = [super init];
    if (self)
    {
        _propertyName = propertyName;
    }
    return self;
}

- (NSString *)accessorName
{
    if (_accessorName == nil) {
        _accessorName = self.defaultAccessorName;
    }
    return _accessorName;
}

- (NSMethodSignature *)signature
{
    return nil;
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
}

@end