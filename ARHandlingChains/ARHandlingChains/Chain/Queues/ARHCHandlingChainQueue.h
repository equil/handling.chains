//
// Created by Alexey Rogatkin on 16.06.14.
//

#import <Foundation/Foundation.h>

@protocol ARHIHandlingChainQueueDelegate;

@interface ARHCHandlingChainQueue : NSObject

@property (nonatomic, readonly) BOOL canceled;
@property (nonatomic, readonly) BOOL handled;
@property (nonatomic, readonly) NSMutableDictionary *context;

@property (nonatomic, assign) id<ARHIHandlingChainQueueDelegate> delegate;

- (id)initWithQueue:(dispatch_queue_t)queue;

- (void)execute;
- (void)cancel;

@end