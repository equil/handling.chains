//
// Created by Alexey Rogatkin on 05.06.14.
//

#import "CAdaptedClassGetter.h"

@implementation CAdaptedClassGetter

- (NSMethodSignature *)signature
{
    NSString *signature = [NSString stringWithFormat:@"%s%s%s", @encode(Class), @encode(NSObject *), @encode(SEL)];
    return [NSMethodSignature signatureWithObjCTypes:[signature cStringUsingEncoding:NSUTF8StringEncoding]];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    Class aClass = NSClassFromString ([dictionary objectForKey:self.propertyName]);
    [invocation setReturnValue:&aClass];
}

@end