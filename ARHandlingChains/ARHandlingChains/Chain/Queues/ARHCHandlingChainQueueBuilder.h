//
// Created by Alexey Rogatkin on 16.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHCHandlingChainQueue.h"
#import "ARHAbstractChainElement.h"

@interface ARHCHandlingChainQueueBuilder : NSObject

- (id) initWithChainClass: (Class) chainClass;

- (void) add: (Class) elementClass;
- (void) addDelegate: (id<ARHIHandlingChainQueueDelegate>) delegate;
- (void) setInitialContext: (NSMutableDictionary *) context;

- (ARHCHandlingChainQueue *) build;

@end