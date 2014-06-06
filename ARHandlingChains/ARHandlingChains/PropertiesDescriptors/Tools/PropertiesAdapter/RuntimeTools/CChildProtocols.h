//
// Created by Alexey Rogatkin on 04.06.14.
//

#import <Foundation/Foundation.h>

@interface CChildProtocols : NSObject<NSFastEnumeration>

- (instancetype)initWithProtocol:(Protocol *)parentProtocol;

@end