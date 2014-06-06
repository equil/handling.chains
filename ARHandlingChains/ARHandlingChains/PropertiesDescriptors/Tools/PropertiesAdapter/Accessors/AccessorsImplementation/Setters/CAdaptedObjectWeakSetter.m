//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "CAdaptedObjectWeakSetter.h"
#import "CWeakObjectHandle.h"

@implementation CAdaptedObjectWeakSetter

- (NSMethodSignature *)signature
{
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    void *temp;
    [invocation getArgument:&temp
                    atIndex:2];
    NSObject *object = (__bridge NSObject *) temp;

    if (object != nil)
    {
        object = [CWeakObjectHandle handleWithObject:object];
    }

    [self storeObject:object
             delegate:dictionary];
}

@end