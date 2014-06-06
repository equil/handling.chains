//
// Created by Alexey Rogatkin on 06.06.14.
//

#import <Foundation/Foundation.h>

@interface CQueue : NSObject

- (void) enqueue: (id) object;
- (id) dequeue;

@end