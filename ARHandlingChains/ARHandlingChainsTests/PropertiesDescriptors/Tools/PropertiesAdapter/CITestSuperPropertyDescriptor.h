//
// Created by Alexey Rogatkin on 04.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHIPropertiesDescriptor.h"

@protocol CITestSuperPropertyDescriptor <ARHIPropertiesDescriptor>

@property(nonatomic, retain) NSString *extraWithoutPresented;
@property(nonatomic, retain) NSString *extraWithPresented;
@property(nonatomic, readonly) BOOL extraWithPresentedPresented;


@end