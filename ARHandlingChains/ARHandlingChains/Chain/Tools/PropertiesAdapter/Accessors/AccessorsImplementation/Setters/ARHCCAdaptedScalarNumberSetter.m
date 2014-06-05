//
// Created by Alexey Rogatkin on 04.06.14.
//

#import "ARHCCAdaptedScalarNumberSetter.h"

@implementation ARHCCAdaptedScalarNumberSetter
{
    NSDictionary *_typeToSelectorMapping;
}

@synthesize type = _type;

- (id)initWithPropertyName:(NSString *)propertyName
                      type:(NSString *)type
{
    _typeToSelectorMapping = @{
            @"c" : NSStringFromSelector (@selector(numberWithChar:)),
            @"i" : NSStringFromSelector (@selector(numberWithInteger:)),
            @"s" : NSStringFromSelector (@selector(numberWithShort:)),
            @"l" : NSStringFromSelector (@selector(numberWithLong:)),
            @"q" : NSStringFromSelector (@selector(numberWithLongLong:)),
            @"C" : NSStringFromSelector (@selector(numberWithUnsignedChar:)),
            @"I" : NSStringFromSelector (@selector(numberWithUnsignedInteger:)),
            @"S" : NSStringFromSelector (@selector(numberWithUnsignedShort:)),
            @"L" : NSStringFromSelector (@selector(numberWithUnsignedLong:)),
            @"Q" : NSStringFromSelector (@selector(numberWithUnsignedLongLong:)),
            @"f" : NSStringFromSelector (@selector(numberWithFloat:)),
            @"d" : NSStringFromSelector (@selector(numberWithDouble:))
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
    SEL selector = NSSelectorFromString ([_typeToSelectorMapping objectForKey:_type]);
    NSInvocation *numberInvocation = [NSInvocation invocationWithMethodSignature:
            [NSNumber methodSignatureForSelector:selector]];
    [numberInvocation setSelector:selector];

    NSUInteger sizeOfType;
    NSGetSizeAndAlignment ([self.type cStringUsingEncoding:NSUTF8StringEncoding], &sizeOfType, NULL);
    void *tempArgument = malloc (sizeof(sizeOfType));

    [invocation getArgument:tempArgument
                    atIndex:2];
    [numberInvocation setArgument:tempArgument
                          atIndex:2];

    free (tempArgument);

    [numberInvocation setTarget:[NSNumber class]];
    [numberInvocation invoke];

    void *tempResult;
    [numberInvocation getReturnValue:&tempResult];
    NSNumber *result = (__bridge NSNumber *) tempResult;

    [dictionary setObject:result
                   forKey:self.propertyName];
}

- (NSMethodSignature *)signature
{
    const char *types = [[NSString stringWithFormat:@"v@:%@",
                                                    self.type] cStringUsingEncoding:NSUTF8StringEncoding];
    return [NSMethodSignature signatureWithObjCTypes:types];
}




@end