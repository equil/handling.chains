//
// Created by Alexey Rogatkin on 18.06.14.
//

#import "ARHCExecutionPoolFactory.h"
#import "CSerialExecutionQueuePool.h"
#import "CSingleExecutionQueuePool.h"
#import "CConcurrentExecutionQueuePool.h"

@implementation ARHCExecutionPoolFactory

+ (id <ARHIExecutionPool>)createPoolWithStrategy:(ARHExecutionPoolStrategy)strategy
{
    if (strategy == ARHExecutionPoolStrategySerial)
    {
        return [[CSerialExecutionQueuePool alloc] init];
    }

    if (strategy == ARHExecutionPoolStrategySingleExecution)
    {
        return [[CSingleExecutionQueuePool alloc] init];
    }

    if (strategy == ARHExecutionPoolStrategyConcurrent)
    {
        return [[CConcurrentExecutionQueuePool alloc] init];
    }

    return nil;
}

@end