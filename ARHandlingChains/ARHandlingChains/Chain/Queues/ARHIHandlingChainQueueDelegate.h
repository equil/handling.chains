//
// Created by Alexey Rogatkin on 16.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHCHandlingChainQueue.h"

@protocol ARHIHandlingChainQueueDelegate <NSObject>

@optional

- (void)queueStarted:(ARHCHandlingChainQueue *)queue;
- (void)queueCompleted:(ARHCHandlingChainQueue *)queue canceled:(BOOL)isCanceled;

@end