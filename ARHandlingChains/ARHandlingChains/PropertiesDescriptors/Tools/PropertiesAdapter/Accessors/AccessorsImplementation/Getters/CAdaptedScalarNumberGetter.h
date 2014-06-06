//
// Created by Alexey Rogatkin on 04.06.14.
//

#import <Foundation/Foundation.h>
#import "CAdaptedCommonGetter.h"

@interface CAdaptedScalarNumberGetter : CAdaptedCommonGetter

@property (nonatomic, strong) NSString *type;

- (id)initWithPropertyName: (NSString *) propertyName type: (NSString *) type;

@end