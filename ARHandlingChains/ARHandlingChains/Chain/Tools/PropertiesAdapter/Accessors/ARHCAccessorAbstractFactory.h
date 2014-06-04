//
// Created by Alexey Rogatkin on 02.06.14.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "ARHCIAdaptedPropertyAccessor.h"
#import "ARHCCPropertyInfo.h"

@interface ARHCAccessorAbstractFactory : NSObject

- (id<ARHCIAdaptedPropertyAccessor>)createGetterAccessor;
- (id<ARHCIAdaptedPropertyAccessor>)createSetterAccessor;
- (id<ARHCIAdaptedPropertyAccessor>)createPresentedAccessor;

+ (ARHCAccessorAbstractFactory *) newFactoryFor: (ARHCCPropertyInfo *) property needPresentedAccessor: (BOOL) needPresentedAccessor;

@end