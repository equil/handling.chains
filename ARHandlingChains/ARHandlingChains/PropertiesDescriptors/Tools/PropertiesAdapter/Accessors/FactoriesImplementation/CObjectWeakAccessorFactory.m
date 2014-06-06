//
// Created by Alexey Rogatkin on 03.06.14.
//

#import "CObjectWeakAccessorFactory.h"
#import "CAdaptedObjectWeakGetter.h"
#import "CAdaptedObjectWeakSetter.h"

@implementation CObjectWeakAccessorFactory

- (id <IAdaptedPropertyAccessor>)internalCreateGetterAccessor
{
    CAdaptedObjectWeakGetter *result = [[CAdaptedObjectWeakGetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.getter;
    return result;
}

- (id <IAdaptedPropertyAccessor>)internalCreateSetterAccessor
{
    CAdaptedObjectWeakSetter *result = [[CAdaptedObjectWeakSetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.setter;
    return result;
}

@end