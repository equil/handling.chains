//
// Created by Alexey Rogatkin on 18.06.14.
//

#import <Foundation/Foundation.h>

#import "ARHIFutureContext.h"

@protocol IHandlingChainQueuePrivate <NSObject>

@property (nonatomic, readonly) id <ARHIFutureContext> futureContext;
@property (nonatomic, readonly) NSMutableDictionary *context;
- (id)initWithQueue:(dispatch_queue_t)queue;
- (void)execute;
- (void)cancel;

@end