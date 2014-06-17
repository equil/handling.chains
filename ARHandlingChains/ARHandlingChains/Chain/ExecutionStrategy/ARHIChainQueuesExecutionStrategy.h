//
// Created by Alexey Rogatkin on 16.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHIHandlingChainQueueDelegate.h"
#import "ARHCHandlingChainQueue.h"

@protocol ARHIChainQueuesExecutionStrategy <ARHIHandlingChainQueueDelegate>

- (void)placeToPool:(ARHCHandlingChainQueue *)queue;

@end