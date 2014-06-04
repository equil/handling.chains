//
// Created by Alexey Rogatkin on 02.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHCAbstractAdaptedPropertyAccessor.h"

@interface ARHCCAdaptedCommonSetter : ARHCAbstractAdaptedPropertyAccessor

- (void)storeObject:(NSObject *)object
           delegate:(NSMutableDictionary *)delegate;
@end