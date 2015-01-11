//
// Created by Alexey Rogatkin on 07.01.15.
//

#import "ARHCCommonRepeatableChainElement.h"
#import "ARHIExecutionPool.h"
#import "ARHCExecutionPoolFactory.h"
#import "ARHCCommonHandlingChain.h"
#import "ARHCMutableDictionaryPropertiesAdapter.h"
#import "IChainElementPrivate.h"


@interface ARHCCommonRepeatableChainElement()<IChainElementPrivate>
@end

@implementation ARHCCommonRepeatableChainElement {
    id<ARHIExecutionPool> _executionPool;
    id<ARHIFutureContext> _futureContext;
}

- (void)process {
    NSDictionary *contextAfterExecution = nil;
    do {
        ARHCCommonHandlingChain *handlingChain = [self handlingChain];
        id <ARHIHandlingChainQueue> queue = [handlingChain buildQueueWithInitialContext:[[self initialContext] copy]];
        @synchronized (self) {
            if (self.mustCancelExecution) {
                return;
            }
            _futureContext = [_executionPool executeQueue:queue];
        }
        id context = [_futureContext get];
        contextAfterExecution = ((ARHCMutableDictionaryPropertiesAdapter *) context).state;
        if (self.mustCancelExecution) {
            return;
        }
    } while ([self needToRepeat:contextAfterExecution]);

    [self processContextAfterExecution:contextAfterExecution];
}

- (void)processContextAfterExecution:(NSDictionary *)contextAfterExecution {
    id<ARHIErrorPD> context = (id <ARHIErrorPD>) [[ARHCMutableDictionaryPropertiesAdapter alloc] initWithDictionary:[contextAfterExecution mutableCopy]];
    if (context.errorPresented) {
        [self placeErrorWithAdditionalInfo:context.error.additionalInfo
                                  causedBy:context.error];
    }
}

- (BOOL)needToRepeat:(NSDictionary *)contextAfterExecution {
    return NO;
}

- (id <ARHIExecutionPool>)executionPool {
    if (_executionPool == nil) {
        _executionPool = [ARHCExecutionPoolFactory createPoolWithStrategy:ARHExecutionPoolStrategySingleExecution];
    }
    return _executionPool;
}

- (NSDictionary *) initialContext {
    return @{};
}

- (NSArray *)elementsClasses {
    return @[];
}

- (ARHCCommonHandlingChain *) handlingChain {
    return [[ARHCCommonHandlingChain alloc] initWithElementsClasses:[self elementsClasses]];
}

- (void)cancelingInitiated {
    @synchronized (self) {
        [_futureContext cancelHandling];
    }
}

@end