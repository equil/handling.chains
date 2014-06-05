//
// Created by Alexey Rogatkin on 04.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHCCAdaptedCommonGetter.h"

@interface ARHCCAdaptedScalarNumberGetter : ARHCCAdaptedCommonGetter

@property (nonatomic, strong) NSString *type;

- (id)initWithPropertyName: (NSString *) propertyName type: (NSString *) type;

@end