//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "ARHCCAdaptedObjectStrongGetter.h"

@implementation ARHCCAdaptedObjectStrongGetter

- (NSMethodSignature *)signature
{
    return [NSMethodSignature signatureWithObjCTypes:"@@:"];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    NSObject *value = [dictionary objectForKey:self.propertyName];
    [invocation setReturnValue:&value];
}

@end