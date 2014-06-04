//
// Created by Alexey Rogatkin on 04.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHCIPropertiesDescriptor.h"

@protocol ARHCITestSuperPropertyDescriptor <ARHCIPropertiesDescriptor>

@property(nonatomic, retain) NSString *extraWithoutPresented;
@property(nonatomic, retain) NSString *extraWithPresented;
@property(nonatomic, readonly) BOOL extraWithPresentedPresented;


@end