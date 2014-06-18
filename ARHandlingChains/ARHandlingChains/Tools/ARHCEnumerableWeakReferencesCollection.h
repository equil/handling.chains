//
// Created by Alexey Rogatkin on 18.06.14.
//

#import <Foundation/Foundation.h>

@interface ARHCEnumerableWeakReferencesCollection : NSObject <NSFastEnumeration>

- (void)addObject:(NSObject *)object;
- (void)removeObject:(NSObject *)object;

- (void) onDeallocElement: (NSObject *) object do:(void(^)())block;

@end