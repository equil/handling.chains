//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "CAdaptedCommonPresented.h"

@implementation CAdaptedCommonPresented

- (NSMethodSignature *)signature
{
    NSString *signature = [NSString stringWithFormat:@"%s%s%s", @encode(BOOL), @encode(NSObject *), @encode(SEL)];
    return [NSMethodSignature signatureWithObjCTypes:[signature cStringUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString *)defaultAccessorName
{
    return [NSString stringWithFormat:@"%@Presented", self.propertyName];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    BOOL presented = [dictionary objectForKey:self.propertyName] != nil;
    [invocation setReturnValue:&presented];
}

@end