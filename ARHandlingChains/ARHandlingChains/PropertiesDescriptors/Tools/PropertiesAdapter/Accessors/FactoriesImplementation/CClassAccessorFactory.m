//
// Created by Alexey Rogatkin on 03.06.14.
//

#import "CClassAccessorFactory.h"
#import "CAdaptedObjectStrongGetter.h"
#import "CAdaptedObjectStrongSetter.h"
#import "CAdaptedClassGetter.h"
#import "CAdaptedClassSetter.h"

@interface CCommonAccessorFactory ()

- (id <IAdaptedPropertyAccessor>)internalCreateGetterAccessor;

- (id <IAdaptedPropertyAccessor>)internalCreateSetterAccessor;
@end

@implementation CClassAccessorFactory

- (id <IAdaptedPropertyAccessor>)internalCreateGetterAccessor
{
    CAdaptedClassGetter *result = [[CAdaptedClassGetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.getter;
    return result;
}

- (id <IAdaptedPropertyAccessor>)internalCreateSetterAccessor
{
    CAdaptedClassSetter *result = [[CAdaptedClassSetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.setter;
    return result;
}

@end