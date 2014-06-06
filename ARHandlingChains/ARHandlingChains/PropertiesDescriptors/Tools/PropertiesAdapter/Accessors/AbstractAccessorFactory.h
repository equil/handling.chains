//
// Created by Alexey Rogatkin on 02.06.14.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "IAdaptedPropertyAccessor.h"
#import "ARHCPropertyInfo.h"

@interface AbstractAccessorFactory : NSObject

- (id<IAdaptedPropertyAccessor>)createGetterAccessor;
- (id<IAdaptedPropertyAccessor>)createSetterAccessor;
- (id<IAdaptedPropertyAccessor>)createPresentedAccessor;

+ (AbstractAccessorFactory *) newFactoryFor: (ARHCPropertyInfo *) property needPresentedAccessor: (BOOL) needPresentedAccessor;

@end