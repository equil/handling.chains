//
// Created by Alexey Rogatkin on 17.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHAbstractChainElement.h"
#import "ARHIErrorPD.h"

@interface ARHCCommonChainElement : ARHAbstractChainElement<ARHIErrorPD>

- (void) placeErrorWithAdditionalInfo: (id) additionalInfo;

@end