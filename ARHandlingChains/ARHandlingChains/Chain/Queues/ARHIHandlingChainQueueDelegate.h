//
// Created by Alexey Rogatkin on 16.06.14.
//

#import <Foundation/Foundation.h>

@protocol ARHIHandlingChainQueue;

@protocol ARHIHandlingChainQueueDelegate <NSObject>

@optional

- (void)queueStarted:(id <ARHIHandlingChainQueue>)queue;

- (void)queueCompleted:(id <ARHIHandlingChainQueue>)queue;

@end