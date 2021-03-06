//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "CAdaptedObjectWeakGetter.h"
#import "CWeakObjectHolder.h"

@implementation CAdaptedObjectWeakGetter

- (NSMethodSignature *)signature
{
    NSString *signature = [NSString stringWithFormat:@"%s%s%s", @encode(NSObject *), @encode(NSObject *), @encode(SEL)];
    return [NSMethodSignature signatureWithObjCTypes:[signature cStringUsingEncoding:NSUTF8StringEncoding]];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    CWeakObjectHolder *objectHandle = [dictionary objectForKey:self.propertyName];
    NSObject *value = [objectHandle weakReference];
    [invocation setReturnValue:&value];
}

@end