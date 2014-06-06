//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "CAdaptedCommonPresented.h"

@implementation CAdaptedCommonPresented

- (NSMethodSignature *)signature
{
    return [NSMethodSignature signatureWithObjCTypes:"c@:"];
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