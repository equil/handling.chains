//
// Created by Alexey Rogatkin on 05.06.14.
//

#import "CAdaptedClassSetter.h"

@implementation CAdaptedClassSetter

- (NSMethodSignature *)signature
{
    NSString *signature = [NSString stringWithFormat:@"%s%s%s%s", @encode(void), @encode(NSObject *), @encode(SEL), @encode(Class)];
    return [NSMethodSignature signatureWithObjCTypes:[signature cStringUsingEncoding:NSUTF8StringEncoding]];
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