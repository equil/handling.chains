//
// Created by Alexey Rogatkin on 03.06.14.
//

#import "ARHCCClassAccessorFactory.h"
#import "ARHCCAdaptedObjectStrongGetter.h"
#import "ARHCCAdaptedObjectStrongSetter.h"
#import "ARHCCAdaptedClassGetter.h"
#import "ARHCCAdaptedClassSetter.h"

@interface ARHCCCommonAccessorFactory ()

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateGetterAccessor;

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateSetterAccessor;
@end

@implementation ARHCCClassAccessorFactory

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateGetterAccessor
{
    ARHCCAdaptedClassGetter *result = [[ARHCCAdaptedClassGetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.getter;
    return result;
}

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateSetterAccessor
{
    ARHCCAdaptedClassSetter *result = [[ARHCCAdaptedClassSetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.setter;
    return result;
}

@end