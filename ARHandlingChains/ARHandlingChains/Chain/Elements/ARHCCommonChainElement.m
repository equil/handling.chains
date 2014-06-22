//
// Created by Alexey Rogatkin on 17.06.14.
//

#import "ARHCCommonChainElement.h"
#import "IChainElementPrivate.h"
#import "ARHAbstractHandlingChain.h"

@interface ARHAbstractChainElement()<IChainElementPrivate>
@end

@implementation ARHCCommonChainElement

- (BOOL)canProcess
{
    return !self.errorPresented;
}

- (void)placeErrorWithAdditionalInfo:(NSDictionary *)additionalInfo
{
    ARHCErrorHolder *error = [[ARHCErrorHolder alloc] init];
    error.additionalInfo = additionalInfo;
    error.elementClass = [self class];
    error.chainClass = [self.chain class];

    self.error = error;
}

@end