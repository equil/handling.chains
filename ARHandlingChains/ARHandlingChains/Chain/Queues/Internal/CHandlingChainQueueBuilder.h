//
// Created by Alexey Rogatkin on 16.06.14.
//

#import <Foundation/Foundation.h>
#import "CHandlingChainQueue.h"
#import "ARHAbstractChainElement.h"

@class ARHAbstractHandlingChain;

@interface CHandlingChainQueueBuilder : NSObject

- (id)initWithChain: (ARHAbstractHandlingChain *) chain;

- (void) add: (Class) elementClass;
- (void) addDelegate: (id<ARHIHandlingChainQueueDelegate>) delegate;
- (void) setInitialContext: (NSMutableDictionary *) context;

- (id<ARHIHandlingChainQueue>) build;

@end