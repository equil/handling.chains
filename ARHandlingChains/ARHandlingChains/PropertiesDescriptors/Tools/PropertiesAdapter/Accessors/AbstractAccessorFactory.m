//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "AbstractAccessorFactory.h"
#import "CCommonAccessorFactory.h"
#import "CObjectWeakAccessorFactory.h"
#import "CObjectStrongAccessorFactory.h"
#import "CScalarNumberAccessorFactory.h"
#import "CStructureAccessorFactory.h"
#import "CSelectorAccessorFactory.h"
#import "CClassAccessorFactory.h"

@interface CCommonAccessorFactory ()

- (instancetype)initWithPropertyInfo:(ARHCPropertyInfo *)propertyInfo
               needPresentedAccessor:(BOOL)needPresentedAccessor;
@end

@implementation AbstractAccessorFactory

- (id <IAdaptedPropertyAccessor>)createGetterAccessor
{
    return nil;
}

- (id <IAdaptedPropertyAccessor>)createSetterAccessor
{
    return nil;
}

- (id <IAdaptedPropertyAccessor>)createPresentedAccessor
{
    return nil;
}

+ (AbstractAccessorFactory *)newFactoryFor:(ARHCPropertyInfo *)info
                         needPresentedAccessor:(BOOL)needPresentedAccessor
{
    if (info == nil)
    {
        return nil;
    }

    CCommonAccessorFactory *result = nil;

    if (info.typeOfType == ARHCCPropertyInfoObjectType)
    {
        if (info.copied)
        {
            NSLog (@"Warning: Copy propeties in PropertyDescriptors not supported. Assume that it will be strong reference without copy.");
        }

        if (info.weakOrAssign)
        {
            result = [[CObjectWeakAccessorFactory alloc] initWithPropertyInfo:info
                                                            needPresentedAccessor:needPresentedAccessor];
        }
        else
        {
            result = [[CObjectStrongAccessorFactory alloc] initWithPropertyInfo:info
                                                              needPresentedAccessor:needPresentedAccessor];
        }
    }

    if (info.typeOfType == ARHCCPropertyInfoScalarNumberType)
    {
        result = [[CScalarNumberAccessorFactory alloc] initWithPropertyInfo:info
                                                          needPresentedAccessor:needPresentedAccessor];
    }

    if (info.typeOfType == ARHCCPropertyInfoStructureType)
    {
        result = [[CStructureAccessorFactory alloc] initWithPropertyInfo:info
                                                       needPresentedAccessor:needPresentedAccessor];
    }

    if (info.typeOfType == ARHCCPropertyInfoSelectorType)
    {
        result = [[CSelectorAccessorFactory alloc] initWithPropertyInfo:info
                                                      needPresentedAccessor:needPresentedAccessor];
    }

    if (info.typeOfType == ARHCCPropertyInfoClassType)
    {
        result = [[CClassAccessorFactory alloc] initWithPropertyInfo:info
                                                   needPresentedAccessor:needPresentedAccessor];
    }

    return result;
}

@end