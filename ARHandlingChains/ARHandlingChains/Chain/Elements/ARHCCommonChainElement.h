//
// Created by Alexey Rogatkin on 17.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHAbstractChainElement.h"
#import "ARHCIDAPDError.h"

@interface ARHCCommonChainElement : ARHAbstractChainElement<ARHCIDAPDError>

- (void) placeErrorWithAdditionalInfo: (id) additionalInfo;

@end