//
// Created by Alexey Rogatkin on 05.06.14.
//

#import "CAdaptedSelectorGetter.h"

@implementation CAdaptedSelectorGetter

- (NSMethodSignature *)signature
{
    NSString *signature = [NSString stringWithFormat:@"%s%s%s", @encode(SEL), @encode(NSObject *), @encode(SEL)];
    return [NSMethodSignature signatureWithObjCTypes:[signature cStringUsingEncoding:NSUTF8StringEncoding]];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    SEL selector = NSSelectorFromString ([dictionary objectForKey:self.propertyName]);
    [invocation setReturnValue:&selector];
}

@end