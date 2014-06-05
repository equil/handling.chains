//
// Created by Alexey Rogatkin on 30.05.14.
//

#import <Foundation/Foundation.h>

@interface ARHCCPropertiesDescriptorsAccessorsHolder : NSObject

@property (nonatomic, readonly) NSDictionary *accessors;

+ (ARHCCPropertiesDescriptorsAccessorsHolder *) holder;

@end