//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "CAdaptedObjectStrongGetter.h"

@implementation CAdaptedObjectStrongGetter

- (NSMethodSignature *)signature
{
    NSString *signature = [NSString stringWithFormat:@"%s%s%s", @encode(NSObject *), @encode(NSObject *), @encode(SEL)];
    return [NSMethodSignature signatureWithObjCTypes:[signature cStringUsingEncoding:NSUTF8StringEncoding]];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    NSObject *value = [dictionary objectForKey:self.propertyName];
    [invocation setReturnValue:&value];
}

@end