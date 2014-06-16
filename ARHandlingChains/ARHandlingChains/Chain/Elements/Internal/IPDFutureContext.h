//
// Created by Alexey Rogatkin on 16.06.14.
//

#import <Foundation/Foundation.h>
#import "ARHIPropertiesDescriptor.h"
#import "CFutureContext.h"

@protocol IPDFutureContext <ARHIPropertiesDescriptor>

@optional

@property(nonatomic, strong) CFutureContext *futureContext;
@property(nonatomic, readonly) BOOL futureContextPresented;

@end