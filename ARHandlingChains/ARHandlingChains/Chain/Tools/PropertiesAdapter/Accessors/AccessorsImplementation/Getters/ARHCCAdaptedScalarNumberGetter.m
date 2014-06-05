//
// Created by Alexey Rogatkin on 04.06.14.
//

#import "ARHCCAdaptedScalarNumberGetter.h"

@implementation ARHCCAdaptedScalarNumberGetter
{
    NSDictionary *_typeToSelectorMapping;
}

@synthesize type = _type;

- (id)initWithPropertyName:(NSString *)propertyName
                      type:(NSString *)type
{
    _typeToSelectorMapping = @{
            @"c" : NSStringFromSelector (@selector(charValue)),
            @"i" : NSStringFromSelector (@selector(integerValue)),
            @"s" : NSStringFromSelector (@selector(shortValue)),
            @"l" : NSStringFromSelector (@selector(longValue)),
            @"q" : NSStringFromSelector (@selector(longLongValue)),
            @"C" : NSStringFromSelector (@selector(unsignedCharValue)),
            @"I" : NSStringFromSelector (@selector(unsignedIntegerValue)),
            @"S" : NSStringFromSelector (@selector(unsignedShortValue)),
            @"L" : NSStringFromSelector (@selector(unsignedLongValue)),
            @"Q" : NSStringFromSelector (@selector(unsignedLongLongValue)),
            @"f" : NSStringFromSelector (@selector(floatValue)),
            @"d" : NSStringFromSelector (@selector(doubleValue))
    };

    if ([_typeToSelectorMapping objectForKey:type] == nil)
    {
        NSLog (@"Error: getter for scalar number created with unsupported type \"%@\"", type);
        return nil;
    }

    self = [super initWithPropertyName:propertyName];
    if (self != nil)
    {
        _type = type;
    }
    return self;
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    NSNumber *result = [dictionary objectForKey:self.propertyName];

    SEL selector = NSSelectorFromString ([_typeToSelectorMapping objectForKey:_type]);
    NSInvocation *numberInvocation = [NSInvocation invocationWithMethodSignature:
            [NSNumber instanceMethodSignatureForSelector:selector]];
    [numberInvocation setSelector:selector];
    [numberInvocation setTarget:result];
    [numberInvocation invoke];

    NSUInteger sizeOfType;
    NSGetSizeAndAlignment ([self.type cStringUsingEncoding:NSUTF8StringEncoding], &sizeOfType, NULL);
    void *temp = malloc (sizeof(sizeOfType));

    [numberInvocation getReturnValue:temp];
    [invocation setReturnValue:temp];

    free (temp);
}

- (NSMethodSignature *)signature
{
    const char *types = [[NSString stringWithFormat:@"%@@:",
                                                    self.type] cStringUsingEncoding:NSUTF8StringEncoding];
    return [NSMethodSignature signatureWithObjCTypes:types];
}

@end