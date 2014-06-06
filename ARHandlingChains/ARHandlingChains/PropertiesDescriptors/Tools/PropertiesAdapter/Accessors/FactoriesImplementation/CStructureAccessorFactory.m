//
// Created by Alexey Rogatkin on 03.06.14.
//

#import "CStructureAccessorFactory.h"
#import "CAdaptedObjectStrongGetter.h"
#import "CAdaptedObjectStrongSetter.h"
#import "CAdaptedStructureGetter.h"
#import "CAdaptedStructureSetter.h"

@interface CCommonAccessorFactory ()

- (id <IAdaptedPropertyAccessor>)internalCreateGetterAccessor;

- (id <IAdaptedPropertyAccessor>)internalCreateSetterAccessor;
@end

@implementation CStructureAccessorFactory

- (id <IAdaptedPropertyAccessor>)internalCreateGetterAccessor
{
    CAdaptedStructureGetter *result = [[CAdaptedStructureGetter alloc] initWithPropertyName:self.propertyInfo.name
                                                                                               type:self.propertyInfo.type];
    result.accessorName = self.propertyInfo.getter;
    return result;
}

- (id <IAdaptedPropertyAccessor>)internalCreateSetterAccessor
{
    CAdaptedStructureSetter *result = [[CAdaptedStructureSetter alloc] initWithPropertyName:self.propertyInfo.name
                                                                                               type:self.propertyInfo.type];
    result.accessorName = self.propertyInfo.setter;
    return result;
}

@end