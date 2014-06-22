//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "CAdaptedObjectStrongSetter.h"

@implementation CAdaptedObjectStrongSetter

- (NSMethodSignature *)signature
{
    NSString *signature = [NSString stringWithFormat:@"%s%s%s%s", @encode(void), @encode(NSObject *), @encode(SEL), @encode(NSObject *)];
    return [NSMethodSignature signatureWithObjCTypes:[signature cStringUsingEncoding:NSUTF8StringEncoding]];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    void *temp;
    [invocation getArgument:&temp
                    atIndex:2];
    NSObject *object = (__bridge NSObject *) temp;

    [self storeObject:object
             delegate:dictionary];
}

@end