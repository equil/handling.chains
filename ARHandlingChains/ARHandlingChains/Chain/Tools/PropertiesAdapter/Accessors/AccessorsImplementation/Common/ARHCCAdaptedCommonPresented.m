//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "ARHCCAdaptedCommonPresented.h"

@implementation ARHCCAdaptedCommonPresented

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