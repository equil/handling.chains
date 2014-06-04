//
// Created by Alexey Rogatkin on 01.06.14.
//

#import <Foundation/Foundation.h>

typedef enum
{
    ARHCCAdaptedPropertyAccessorTypeSetter = 0,
    ARHCCAdaptedPropertyAccessorTypeGetter = 1,
    ARHCCAdaptedPropertyAccessorTypePresented = 2
} ARHCCAdaptedPropertyAccessorType;

@interface ARHCCAdaptedPropertyAccessor : NSObject

@property (nonatomic, readonly) NSString *accessorName;
@property (nonatomic, readonly) ARHCCAdaptedPropertyAccessorType accessorType;

- (id)initWithObjcProperty:property
              accessorType:(ARHCCAdaptedPropertyAccessorType)type;

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary;

@end