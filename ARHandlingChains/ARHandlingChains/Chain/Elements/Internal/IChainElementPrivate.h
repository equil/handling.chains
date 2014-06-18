//
// Created by Alexey Rogatkin on 18.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHIHandlingChainQueue.h"
#import "IHandlingChainQueuePrivate.h"

@protocol IChainElementPrivate <NSObject>

@property (nonatomic, assign) Class chainClass;
@property (nonatomic, assign) id <ARHIHandlingChainQueue, IHandlingChainQueuePrivate> queue;

- (void)handle;

@end