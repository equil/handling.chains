//
// Created by Alexey Rogatkin on 16.06.14.
//

#import <Foundation/Foundation.h>

@protocol ARHIFutureContext <NSObject>

- (id) get;
- (void)cancelHandling;

@end