//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "ARHCAccessorAbstractFactory.h"
#import "ARHCCCommonAccessorFactory.h"
#import "ARHCCObjectWeakAccessorFactory.h"
#import "ARHCCObjectStrongAccessorFactory.h"
#import "ARHCCScalarNumberAccessorFactory.h"
#import "ARHCCStructureAccessorFactory.h"
#import "ARHCCSelectorAccessorFactory.h"
#import "ARHCCClassAccessorFactory.h"

@interface ARHCCCommonAccessorFactory ()

- (instancetype)initWithPropertyInfo:(ARHCCPropertyInfo *)propertyInfo
               needPresentedAccessor:(BOOL)needPresentedAccessor;
@end

@implementation ARHCAccessorAbstractFactory

- (id <ARHCIAdaptedPropertyAccessor>)createGetterAccessor
{
    return nil;
}

- (id <ARHCIAdaptedPropertyAccessor>)createSetterAccessor
{
    return nil;
}

- (id <ARHCIAdaptedPropertyAccessor>)createPresentedAccessor
{
    return nil;
}

+ (ARHCAccessorAbstractFactory *)newFactoryFor:(ARHCCPropertyInfo *)info
                         needPresentedAccessor:(BOOL)needPresentedAccessor
{
    if (info == nil)
    {
        return nil;
    }

    ARHCCCommonAccessorFactory *result = nil;

    if (info.typeOfType == ARHCCPropertyInfoObjectType)
    {
        if (info.copied)
        {
            NSLog (@"Warning: Copy propeties in PropertyDescriptors not supported. Assume that it will be strong reference without copy.");
        }

        if (info.weakOrAssign)
        {
            result = [[ARHCCObjectWeakAccessorFactory alloc] initWithPropertyInfo:info
                                                            needPresentedAccessor:needPresentedAccessor];
        }
        else
        {
            result = [[ARHCCObjectStrongAccessorFactory alloc] initWithPropertyInfo:info
                                                              needPresentedAccessor:needPresentedAccessor];
        }
    }

    if (info.typeOfType == ARHCCPropertyInfoScalarNumberType)
    {
        result = [[ARHCCScalarNumberAccessorFactory alloc] initWithPropertyInfo:info
                                                          needPresentedAccessor:needPresentedAccessor];
    }

    if (info.typeOfType == ARHCCPropertyInfoStructureType)
    {
        result = [[ARHCCStructureAccessorFactory alloc] initWithPropertyInfo:info
                                                       needPresentedAccessor:needPresentedAccessor];
    }

    if (info.typeOfType == ARHCCPropertyInfoSelectorType)
    {
        result = [[ARHCCSelectorAccessorFactory alloc] initWithPropertyInfo:info
                                                      needPresentedAccessor:needPresentedAccessor];
    }

    if (info.typeOfType == ARHCCPropertyInfoClassType)
    {
        result = [[ARHCCClassAccessorFactory alloc] initWithPropertyInfo:info
                                                   needPresentedAccessor:needPresentedAccessor];
    }

    return result;
}

@end