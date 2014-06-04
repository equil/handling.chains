//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "ARHCAccessorAbstractFactory.h"
#import "ARHCCAdaptedPropertyAccessor.h"
#import "ARHCIAdaptedPropertyAccessor.h"
#import "ARHCCCommonAccessorFactory.h"
#import "ARHCCObjectWeakAccessorFactory.h"
#import "ARHCCObjectStrongAccessorFactory.h"

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

    return result;
}

@end