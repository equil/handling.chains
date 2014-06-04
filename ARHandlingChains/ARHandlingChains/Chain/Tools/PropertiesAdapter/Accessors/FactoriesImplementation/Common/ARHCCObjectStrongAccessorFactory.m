//
// Created by Alexey Rogatkin on 03.06.14.
//

#import "ARHCCObjectStrongAccessorFactory.h"
#import "ARHCCAdaptedObjectStrongGetter.h"
#import "ARHCCAdaptedObjectStrongSetter.h"

@interface ARHCCCommonAccessorFactory()
- (id <ARHCIAdaptedPropertyAccessor>)internalCreateGetterAccessor;
- (id <ARHCIAdaptedPropertyAccessor>)internalCreateSetterAccessor;
@end

@implementation ARHCCObjectStrongAccessorFactory

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateGetterAccessor
{
    ARHCCAdaptedObjectStrongGetter *result = [[ARHCCAdaptedObjectStrongGetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.getter;
    return result;
}

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateSetterAccessor
{
    ARHCCAdaptedObjectStrongSetter *result = [[ARHCCAdaptedObjectStrongSetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.setter;
    return result;
}

@end