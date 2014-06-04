//
// Created by Alexey Rogatkin on 02.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHCAccessorAbstractFactory.h"
#import "ARHCCPropertyInfo.h"

@interface ARHCCCommonAccessorFactory : ARHCAccessorAbstractFactory

@property (readonly) BOOL needPresentedAccessor;
@property (readonly) ARHCCPropertyInfo *propertyInfo;

@end