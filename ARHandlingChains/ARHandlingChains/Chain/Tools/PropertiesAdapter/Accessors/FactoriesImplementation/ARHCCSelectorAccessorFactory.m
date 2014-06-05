//
// Created by Alexey Rogatkin on 03.06.14.
//

#import "ARHCCSelectorAccessorFactory.h"
#import "ARHCCAdaptedObjectStrongGetter.h"
#import "ARHCCAdaptedObjectStrongSetter.h"
#import "ARHCCAdaptedSelectorGetter.h"
#import "ARHCCAdaptedSelectorSetter.h"

@interface ARHCCCommonAccessorFactory ()

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateGetterAccessor;

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateSetterAccessor;
@end

@implementation ARHCCSelectorAccessorFactory

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateGetterAccessor
{
    ARHCCAdaptedSelectorGetter *result = [[ARHCCAdaptedSelectorGetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.getter;
    return result;
}

- (id <ARHCIAdaptedPropertyAccessor>)internalCreateSetterAccessor
{
    ARHCCAdaptedSelectorSetter *result = [[ARHCCAdaptedSelectorSetter alloc] initWithPropertyName:self.propertyInfo.name];
    result.accessorName = self.propertyInfo.setter;
    return result;
}

@end