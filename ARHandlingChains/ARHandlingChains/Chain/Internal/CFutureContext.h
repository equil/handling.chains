//
// Created by Alexey Rogatkin on 16.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHIFutureContext.h"
#import "ARHCMutableDictionaryPropertiesAdapter.h"
#import "ARHCHandlingChainQueue.h"
#import "ARHIHandlingChainQueueDelegate.h"

@interface CFutureContext : NSObject<ARHIFutureContext, ARHIHandlingChainQueueDelegate>

- (void) set: (ARHCMutableDictionaryPropertiesAdapter *) context;

@property (nonatomic, assign) ARHCHandlingChainQueue *respondedQueue;

@end