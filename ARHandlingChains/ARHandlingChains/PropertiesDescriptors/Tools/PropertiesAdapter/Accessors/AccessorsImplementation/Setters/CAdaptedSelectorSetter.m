//
// Created by Alexey Rogatkin on 05.06.14.
//

#import "CAdaptedSelectorSetter.h"

@implementation CAdaptedSelectorSetter

- (NSMethodSignature *)signature
{
    return [NSMethodSignature signatureWithObjCTypes:"v@::"];
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