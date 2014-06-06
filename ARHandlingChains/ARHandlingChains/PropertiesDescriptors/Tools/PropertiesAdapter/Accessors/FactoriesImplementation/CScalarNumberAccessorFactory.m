//
// Created by Alexey Rogatkin on 03.06.14.
//

#import "CScalarNumberAccessorFactory.h"
#import "CAdaptedObjectStrongGetter.h"
#import "CAdaptedObjectStrongSetter.h"
#import "CAdaptedScalarNumberGetter.h"
#import "CAdaptedScalarNumberSetter.h"

@interface CCommonAccessorFactory ()

- (id <IAdaptedPropertyAccessor>)internalCreateGetterAccessor;

- (id <IAdaptedPropertyAccessor>)internalCreateSetterAccessor;

@end

@implementation CScalarNumberAccessorFactory

- (id <IAdaptedPropertyAccessor>)internalCreateGetterAccessor
{
    CAdaptedScalarNumberGetter *result = [[CAdaptedScalarNumberGetter alloc] initWithPropertyName:self.propertyInfo.name
                                                                                                     type:self.propertyInfo.type];
    result.accessorName = self.propertyInfo.getter;
    return result;
}

- (id <IAdaptedPropertyAccessor>)internalCreateSetterAccessor
{
    CAdaptedScalarNumberSetter *result = [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:self.propertyInfo.name
                                                                                                     type:self.propertyInfo.type];
    result.accessorName = self.propertyInfo.setter;
    return result;
}

@end