//
// Created by Alexey Rogatkin on 03.06.14.
//

#import "CSelectorAccessorFactory.h"
#import "CAdaptedObjectStrongGetter.h"
#import "CAdaptedObjectStrongSetter.h"
#import "CAdaptedSelectorGetter.h"
#import "CAdaptedSelectorSetter.h"

@interface CCommonAccessorFactory ()

- (id <IAdaptedPropertyAccessor>)internalCreateGetterAccessor;

- (id <IAdaptedPropertyAccessor>)internalCreateSetterAccessor;
@end

@implementation CSelectorAccessorFactory

- (id <IAdaptedPropertyAccessor>)internalCreateGetterAccessor
{
    CAdaptedSelectorGetter *result = [[CAdaptedSelectorGetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.getter;
    return result;
}

- (id <IAdaptedPropertyAccessor>)internalCreateSetterAccessor
{
    CAdaptedSelectorSetter *result = [[CAdaptedSelectorSetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.setter;
    return result;
}

@end