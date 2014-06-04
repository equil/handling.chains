//
// Created by Alexey Rogatkin on 02.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHCIAdaptedPropertyAccessor.h"

@interface ARHCAbstractAdaptedPropertyAccessor : NSObject<ARHCIAdaptedPropertyAccessor>

- (id)initWithPropertyName: (NSString *) propertyName;
@property (nonatomic, readonly) NSString * defaultAccessorName;

@end