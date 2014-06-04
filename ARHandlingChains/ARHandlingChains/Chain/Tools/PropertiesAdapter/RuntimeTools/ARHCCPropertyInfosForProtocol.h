//
// Created by Alexey Rogatkin on 04.06.14.
//

#import <Foundation/Foundation.h>

@interface ARHCCPropertyInfosForProtocol : NSObject<NSFastEnumeration>

- (instancetype)initWithProtocol:(Protocol *)protocol;

@end