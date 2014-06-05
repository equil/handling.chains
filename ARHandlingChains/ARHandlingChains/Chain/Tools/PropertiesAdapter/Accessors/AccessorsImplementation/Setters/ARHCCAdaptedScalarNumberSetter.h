//
// Created by Alexey Rogatkin on 04.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHCCAdaptedCommonSetter.h"

@interface ARHCCAdaptedScalarNumberSetter :ARHCCAdaptedCommonSetter

@property (nonatomic, strong) NSString *type;

- (id)initWithPropertyName: (NSString *) propertyName type: (NSString *) type;


@end