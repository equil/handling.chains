//
// Created by Alexey Rogatkin on 05.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHCCAdaptedCommonGetter.h"

@interface ARHCCAdaptedStructureGetter : ARHCCAdaptedCommonGetter

@property (nonatomic, strong) NSString *type;

- (id)initWithPropertyName: (NSString *) propertyName type: (NSString *) type;

@end