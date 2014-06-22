//
// Created by Alexey Rogatkin on 05.06.14.
//

#import "CAdaptedSelectorSetter.h"

@implementation CAdaptedSelectorSetter

- (NSMethodSignature *)signature
{
    NSString *signature = [NSString stringWithFormat:@"%s%s%s%s", @encode(void), @encode(NSObject *), @encode(SEL), @encode(SEL)];
    return [NSMethodSignature signatureWithObjCTypes:[signature cStringUsingEncoding:NSUTF8StringEncoding]];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    SEL selector;
    [invocation getArgument:&selector
                    atIndex:2];

    [dictionary setObject:NSStringFromSelector (selector)
                   forKey:self.propertyName];
}

@end