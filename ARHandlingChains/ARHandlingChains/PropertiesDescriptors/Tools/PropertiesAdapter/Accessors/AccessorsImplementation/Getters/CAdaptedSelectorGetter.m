//
// Created by Alexey Rogatkin on 05.06.14.
//

#import "CAdaptedSelectorGetter.h"

@implementation CAdaptedSelectorGetter

- (NSMethodSignature *)signature
{
    return [NSMethodSignature signatureWithObjCTypes:":@:"];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    SEL selector = NSSelectorFromString ([dictionary objectForKey:self.propertyName]);
    [invocation setReturnValue:&selector];
}

@end