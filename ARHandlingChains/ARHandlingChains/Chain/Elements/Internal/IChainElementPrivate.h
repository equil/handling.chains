//
// Created by Alexey Rogatkin on 18.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHIHandlingChainQueue.h"
#import "IHandlingChainQueuePrivate.h"

@class ARHAbstractHandlingChain;

@protocol IChainElementPrivate <NSObject>

@property (nonatomic, weak) ARHAbstractHandlingChain *chain;
@property (nonatomic, weak) id <ARHIHandlingChainQueue, IHandlingChainQueuePrivate> queue;

- (void)handle;

@end