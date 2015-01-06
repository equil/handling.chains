//
// Created by Alexey Rogatkin on 07.01.15.
//

#import <Foundation/Foundation.h>
#import "ARHCCommonChainElement.h"
#import "ARHCCommonHandlingChain.h"


@interface ARHCCommonRepeatableChainElement : ARHCCommonChainElement<ARHIErrorPD>
- (void)processContextAfterExecution:(NSDictionary *)contextAfterExecution;

- (BOOL)needToRepeat:(NSDictionary *)contextAfterExecution;

- (id <ARHIExecutionPool>)executionPool;

- (NSDictionary *)initialContext;

- (NSArray *)elementsClasses;

- (ARHCCommonHandlingChain *)handlingChain;
@end