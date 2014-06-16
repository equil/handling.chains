//
// Created by Alexey Rogatkin on 17.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHAbstractChainElement.h"
#import "ARHCIDAPDError.h"

@interface ARHCChainElement : ARHAbstractChainElement<ARHCIDAPDError>

- (void) placeErrorWithAdditionalInfo: (NSDictionary *) additionalInfo;

@end