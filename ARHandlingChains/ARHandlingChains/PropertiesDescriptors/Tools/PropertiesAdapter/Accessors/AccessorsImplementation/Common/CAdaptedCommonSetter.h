//
// Created by Alexey Rogatkin on 02.06.14.
//

#import <Foundation/Foundation.h>
#import "AbstractAdaptedPropertyAccessor.h"

@interface CAdaptedCommonSetter : AbstractAdaptedPropertyAccessor

- (void)storeObject:(NSObject *)object
           delegate:(NSMutableDictionary *)delegate;
@end