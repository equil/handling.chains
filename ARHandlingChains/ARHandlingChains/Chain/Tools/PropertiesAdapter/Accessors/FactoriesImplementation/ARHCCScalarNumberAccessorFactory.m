//
// Created by Alexey Rogatkin on 03.06.14.
//

#import "ARHCCScalarNumberAccessorFactory.h"
#import "ARHCCAdaptedObjectStrongGetter.h"
#import "ARHCCAdaptedObjectStrongSetter.h"
#import "ARHCCAdaptedScalarNumberGetter.h"
#import "ARHCCAdaptedScalarNumberSetter.h"

@interface ARHCCCommonAccessorFactory ()

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateGetterAccessor;

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateSetterAccessor;

@end

@implementation ARHCCScalarNumberAccessorFactory

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateGetterAccessor
{
    ARHCCAdaptedScalarNumberGetter *result = [[ARHCCAdaptedScalarNumberGetter alloc] initWithPropertyName:self.propertyInfo.name
                                                                                                     type:self.propertyInfo.type];
    result.accessorName = self.propertyInfo.getter;
    return result;
}

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateSetterAccessor
{
    ARHCCAdaptedScalarNumberSetter *result = [[ARHCCAdaptedScalarNumberSetter alloc] initWithPropertyName:self.propertyInfo.name
                                                                                                     type:self.propertyInfo.type];
    result.accessorName = self.propertyInfo.setter;
    return result;
}

@end