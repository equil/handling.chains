//
// Created by Alexey Rogatkin on 02.06.14.
//

#import <Foundation/Foundation.h>

@protocol ARHCIAdaptedPropertyAccessor <NSObject>

@property (nonatomic, strong) NSString *accessorName;
@property (nonatomic, readonly) NSString *propertyName;

@property (nonatomic, readonly) NSMethodSignature *signature;

- (void) performWithInvocation: (NSInvocation *) invocation delegate: (NSMutableDictionary *) dictionary;

@end