//
// Created by Alexey Rogatkin on 05.06.14.
//

#import "CAdaptedCommonSettersAndGettersTest.h"
#import "IAdaptedPropertyAccessor.h"

@implementation CAdaptedCommonSettersAndGettersTest

#pragma mark - Forwarding support

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *result = [super methodSignatureForSelector:aSelector];
    id<IAdaptedPropertyAccessor> accessor = [_accessors objectForKey:NSStringFromSelector (aSelector)];
    if (accessor != nil)
    {
        result = accessor.signature;
    }
    return result;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    id<IAdaptedPropertyAccessor> accessor = [_accessors objectForKey:NSStringFromSelector (anInvocation.selector)];
    if (accessor != nil)
    {
        [accessor performWithInvocation:anInvocation
                               delegate:_backbone];
    }
    else
    {
        [super forwardInvocation:anInvocation];
    }
}


@end