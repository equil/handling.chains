//
// Created by Alexey Rogatkin on 03.06.14.
//

#import "ARHCCObjectWeakAccessorFactory.h"
#import "ARHCCAdaptedObjectWeakGetter.h"
#import "ARHCCAdaptedObjectWeakSetter.h"

@implementation ARHCCObjectWeakAccessorFactory

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateGetterAccessor
{
    ARHCCAdaptedObjectWeakGetter *result = [[ARHCCAdaptedObjectWeakGetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.getter;
    return result;
}

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateSetterAccessor
{
    ARHCCAdaptedObjectWeakSetter *result = [[ARHCCAdaptedObjectWeakSetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.setter;
    return result;
}

@end