//
// Created by Alexey Rogatkin on 02.06.14.
//

#import <Foundation/Foundation.h>
#import "AbstractAccessorFactory.h"
#import "ARHCPropertyInfo.h"

@interface CCommonAccessorFactory : AbstractAccessorFactory

@property (readonly) BOOL needPresentedAccessor;
@property (readonly) ARHCPropertyInfo *propertyInfo;

@end