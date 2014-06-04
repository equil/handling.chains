//
// Created by Alexey Rogatkin on 04.06.14.
//

#import <Foundation/Foundation.h>

@interface ARHCCChildProtocols : NSObject<NSFastEnumeration>

- (instancetype)initWithProtocol:(Protocol *)parentProtocol;

@end