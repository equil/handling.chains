//
// Created by Alexey Rogatkin on 16.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHIHandlingChainQueue.h"
#import "IHandlingChainQueuePrivate.h"

extern NSString *const kCHandlingChainQueueCancelingInitiationKey;

@interface CHandlingChainQueue : NSObject<ARHIHandlingChainQueue, IHandlingChainQueuePrivate>

@end