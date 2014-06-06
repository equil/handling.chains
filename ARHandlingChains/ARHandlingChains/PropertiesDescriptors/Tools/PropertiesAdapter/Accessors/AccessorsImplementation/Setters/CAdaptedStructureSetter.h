//
// Created by Alexey Rogatkin on 05.06.14.
//

#import <Foundation/Foundation.h>
#import "CAdaptedCommonGetter.h"
#import "CAdaptedCommonSetter.h"

@interface CAdaptedStructureSetter : CAdaptedCommonSetter

@property (nonatomic, strong) NSString *type;

- (id)initWithPropertyName: (NSString *) propertyName type: (NSString *) type;

@end