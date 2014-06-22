//
// Created by Alexey Rogatkin on 18.06.14.
//

#import <Foundation/Foundation.h>

extern char const *kWeakReferencesSentryKey;

@interface CWeakReferencesSentry : NSObject

@property (nonatomic, readonly) NSUInteger hash;
@property (nonatomic, readonly) NSMutableSet *collections;

- (instancetype)initWithHash:(NSUInteger)hash;

@end