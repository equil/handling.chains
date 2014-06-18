//
// Created by Alexey Rogatkin on 16.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHIFutureContext.h"
#import "ARHCMutableDictionaryPropertiesAdapter.h"
#import "ARHIHandlingChainQueue.h"
#import "IHandlingChainQueuePrivate.h"
#import "ARHIHandlingChainQueueDelegate.h"

@interface CFutureContext : NSObject<ARHIFutureContext>

- (void) set: (ARHCMutableDictionaryPropertiesAdapter *) context;

@property (nonatomic, assign) id<ARHIHandlingChainQueue, IHandlingChainQueuePrivate> respondedQueue;

@end