//
// Created by Alexey Rogatkin on 30.05.14.
//

#import <Foundation/Foundation.h>

@interface CPropertiesDescriptorsAccessorsHolder : NSObject

@property (nonatomic, readonly) NSDictionary *accessors;

+ (CPropertiesDescriptorsAccessorsHolder *) holder;

@end