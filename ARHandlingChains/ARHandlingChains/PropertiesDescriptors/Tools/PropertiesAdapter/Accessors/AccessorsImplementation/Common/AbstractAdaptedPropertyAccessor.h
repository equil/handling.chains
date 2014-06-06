//
// Created by Alexey Rogatkin on 02.06.14.
//

#import <Foundation/Foundation.h>
#import "IAdaptedPropertyAccessor.h"

@interface AbstractAdaptedPropertyAccessor : NSObject<IAdaptedPropertyAccessor>

- (id)initWithPropertyName: (NSString *) propertyName;
@property (nonatomic, readonly) NSString * defaultAccessorName;

@end