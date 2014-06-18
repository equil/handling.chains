//
// Created by Alexey Rogatkin on 18.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHIExecutionPool.h"

typedef enum {
    ARHExecutionPoolStrategySingleExecution = 0,
    ARHExecutionPoolStrategySerial = 1,
} ARHExecutionPoolStrategy;

@interface ARHCExecutionPoolFactory : NSObject

+ (id<ARHIExecutionPool>) createPoolWithStrategy: (ARHExecutionPoolStrategy) strategy;

@end