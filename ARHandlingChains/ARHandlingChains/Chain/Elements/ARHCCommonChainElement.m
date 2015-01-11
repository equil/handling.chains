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
    [self placeErrorWithAdditionalInfo:additionalInfo causedBy:nil];
}

- (void)placeErrorWithAdditionalInfo:(NSDictionary *)additionalInfo
                            causedBy:(ARHCErrorHolder *)rootError
{
    ARHCErrorHolder *error = [[ARHCErrorHolder alloc] init];
    error.additionalInfo = additionalInfo;
    error.elementClass = [self class];
    error.chainClass = [self.chain class];
    error.rootError = rootError;
    self.error = error;
}



@end