//
// Created by Alexey Rogatkin on 03.06.14.
//

#import "ARHCCStructureAccessorFactory.h"
#import "ARHCCAdaptedObjectStrongGetter.h"
#import "ARHCCAdaptedObjectStrongSetter.h"
#import "ARHCCAdaptedStructureGetter.h"
#import "ARHCCAdaptedStructureSetter.h"

@interface ARHCCCommonAccessorFactory ()

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateGetterAccessor;

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateSetterAccessor;
@end

@implementation ARHCCStructureAccessorFactory

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateGetterAccessor
{
    ARHCCAdaptedStructureGetter *result = [[ARHCCAdaptedStructureGetter alloc] initWithPropertyName:self.propertyInfo.name
                                                                                               type:self.propertyInfo.type];
    result.accessorName = self.propertyInfo.getter;
    return result;
}

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateSetterAccessor
{
    ARHCCAdaptedStructureSetter *result = [[ARHCCAdaptedStructureSetter alloc] initWithPropertyName:self.propertyInfo.name
                                                                                               type:self.propertyInfo.type];
    result.accessorName = self.propertyInfo.setter;
    return result;
}

@end