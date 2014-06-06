//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "CAdaptedObjectWeakGetter.h"
#import "CWeakObjectHandle.h"

@implementation CAdaptedObjectWeakGetter

- (NSMethodSignature *)signature
{
    return [NSMethodSignature signatureWithObjCTypes:"@@:"];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    CWeakObjectHandle *objectHandle = [dictionary objectForKey:self.propertyName];
    NSObject *value = [objectHandle weakReference];
    [invocation setReturnValue:&value];
}

@end