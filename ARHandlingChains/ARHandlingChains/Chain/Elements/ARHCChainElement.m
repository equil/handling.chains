//
// Created by Alexey Rogatkin on 17.06.14.
//

#import "ARHCChainElement.h"

@implementation ARHCChainElement

- (BOOL)canProcess
{
    return !self.errorPresented;
}

- (void)placeErrorWithAdditionalInfo:(NSDictionary *)additionalInfo
{
    ARHCErrorHandle *error = [[ARHCErrorHandle alloc] init];
    error.additionalInfo = additionalInfo;
    error.elementClass = [self class];
    error.chainClass = self.chainClass;

    self.error = error;
}

@end