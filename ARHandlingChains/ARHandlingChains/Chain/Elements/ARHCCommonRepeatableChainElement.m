//
// Created by Alexey Rogatkin on 07.01.15.
//

#import "ARHCCommonRepeatableChainElement.h"
#import "ARHIExecutionPool.h"
#import "ARHCExecutionPoolFactory.h"
#import "ARHCCommonHandlingChain.h"
#import "ARHCMutableDictionaryPropertiesAdapter.h"


@implementation ARHCCommonRepeatableChainElement {
    id<ARHIExecutionPool> _executionPool;
    id<ARHIFutureContext> _futureContext;
}

- (void)process {
    NSDictionary *initialContext = [[self initialContext] copy];
    NSDictionary *contextAfterExecution = nil;
    do {
        ARHCCommonHandlingChain *handlingChain = [self handlingChain];
        id <ARHIHandlingChainQueue> queue = [handlingChain buildQueueWithInitialContext:[initialContext copy]];
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

}

- (BOOL) needToRepeat: (NSDictionary *) contextAfterExecution {
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