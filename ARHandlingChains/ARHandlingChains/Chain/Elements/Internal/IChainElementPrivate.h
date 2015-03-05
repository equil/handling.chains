//
// Created by Alexey Rogatkin on 18.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHIHandlingChainQueue.h"
#import "IHandlingChainQueuePrivate.h"

@class ARHAbstractHandlingChain;

@protocol IChainElementPrivate <NSObject>

@property (nonatomic, strong) ARHAbstractHandlingChain *chain;
@property (nonatomic, strong) id <ARHIHandlingChainQueue, IHandlingChainQueuePrivate> queue;

- (void)handle;

@end