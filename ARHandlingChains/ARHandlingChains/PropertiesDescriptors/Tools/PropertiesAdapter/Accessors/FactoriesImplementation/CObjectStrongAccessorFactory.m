//
// Created by Alexey Rogatkin on 03.06.14.
//

#import "CObjectStrongAccessorFactory.h"
#import "CAdaptedObjectStrongGetter.h"
#import "CAdaptedObjectStrongSetter.h"

@interface CCommonAccessorFactory ()
- (id <IAdaptedPropertyAccessor>)internalCreateGetterAccessor;
- (id <IAdaptedPropertyAccessor>)internalCreateSetterAccessor;
@end

@implementation CObjectStrongAccessorFactory

- (id <IAdaptedPropertyAccessor>)internalCreateGetterAccessor
{
    CAdaptedObjectStrongGetter *result = [[CAdaptedObjectStrongGetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.getter;
    return result;
}

- (id <IAdaptedPropertyAccessor>)internalCreateSetterAccessor
{
    CAdaptedObjectStrongSetter *result = [[CAdaptedObjectStrongSetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.setter;
    return result;
}

@end