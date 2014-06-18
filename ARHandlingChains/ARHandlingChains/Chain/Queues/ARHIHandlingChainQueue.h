//
// Created by Alexey Rogatkin on 18.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHIHandlingChainQueueDelegate.h"

@protocol ARHIHandlingChainQueue <NSObject>

@property (nonatomic, readonly) BOOL canceled;
@property (nonatomic, readonly) BOOL handled;

- (void) addDelegate: (id<ARHIHandlingChainQueueDelegate>) delegate;
- (void) removeDelegate: (id<ARHIHandlingChainQueueDelegate>) delegate;


@end