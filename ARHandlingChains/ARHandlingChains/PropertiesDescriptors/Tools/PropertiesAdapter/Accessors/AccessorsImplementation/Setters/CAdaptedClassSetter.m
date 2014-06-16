//
// Created by Alexey Rogatkin on 05.06.14.
//

#import "CAdaptedClassSetter.h"

@implementation CAdaptedClassSetter

- (NSMethodSignature *)signature
{
    return [NSMethodSignature signatureWithObjCTypes:"v@:#"];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    Class aClass;
    [invocation getArgument:&aClass
                    atIndex:2];

    [dictionary setObject:NSStringFromClass (aClass)
                   forKey:self.propertyName];
}

@end