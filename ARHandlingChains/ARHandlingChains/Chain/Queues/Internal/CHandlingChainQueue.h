//
// Created by Alexey Rogatkin on 16.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHIHandlingChainQueue.h"
#import "IHandlingChainQueuePrivate.h"

@interface CHandlingChainQueue : NSObject<ARHIHandlingChainQueue, IHandlingChainQueuePrivate>

@end