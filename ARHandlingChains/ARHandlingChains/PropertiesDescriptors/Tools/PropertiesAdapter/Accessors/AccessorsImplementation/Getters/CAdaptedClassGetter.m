//
// Created by Alexey Rogatkin on 05.06.14.
//

#import "CAdaptedClassGetter.h"

@implementation CAdaptedClassGetter

- (NSMethodSignature *)signature
{
    return [NSMethodSignature signatureWithObjCTypes:"#@:"];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    Class aClass = NSClassFromString ([dictionary objectForKey:self.propertyName]);
    [invocation setReturnValue:&aClass];
}

@end