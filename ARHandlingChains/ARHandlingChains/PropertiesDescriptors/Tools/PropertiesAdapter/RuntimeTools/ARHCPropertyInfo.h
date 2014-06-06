//
// Created by Alexey Rogatkin on 02.06.14.
//

#import <objc/runtime.h>
#import <Foundation/Foundation.h>

typedef enum {
    ARHCCPropertyInfoUnsupportedType = 0,
    ARHCCPropertyInfoScalarNumberType = 1,
    ARHCCPropertyInfoObjectType = 2,
    ARHCCPropertyInfoClassType = 3,
    ARHCCPropertyInfoSelectorType = 4,
    ARHCCPropertyInfoStructureType = 5
} ARHCCPropertyInfoTypeOfType;

@interface ARHCPropertyInfo : NSObject

@property (readonly) BOOL weakOrAssign;
@property (readonly) BOOL strongOrRetain;
@property (readonly) BOOL readonly;
@property (readonly) BOOL copied;
@property (readonly) BOOL nonAtomic;

@property (readonly) NSString *name;
@property (readonly) NSString *getter;
@property (readonly) NSString *setter;
@property (readonly) NSString *type;

@property (readonly) ARHCCPropertyInfoTypeOfType typeOfType;

- (id)initWithProperty:(objc_property_t)property;
@end