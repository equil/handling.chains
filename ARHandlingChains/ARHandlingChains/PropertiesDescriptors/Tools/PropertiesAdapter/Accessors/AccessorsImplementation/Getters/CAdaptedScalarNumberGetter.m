//
// Created by Alexey Rogatkin on 04.06.14.
//

#import "CAdaptedScalarNumberGetter.h"

@implementation CAdaptedScalarNumberGetter
{
    NSDictionary *_typeToSelectorMapping;
}

@synthesize type = _type;

- (id)initWithPropertyName:(NSString *)propertyName
                      type:(NSString *)type
{
    _typeToSelectorMapping = @{
            [NSString stringWithUTF8String:@encode(char)] : NSStringFromSelector (@selector(charValue)),
            [NSString stringWithUTF8String:@encode(BOOL)] : NSStringFromSelector (@selector(boolValue)),
            [NSString stringWithUTF8String:@encode(int)] : NSStringFromSelector (@selector(integerValue)),
            [NSString stringWithUTF8String:@encode(short)] : NSStringFromSelector (@selector(shortValue)),
            [NSString stringWithUTF8String:@encode(long)] : NSStringFromSelector (@selector(longValue)),
            [NSString stringWithUTF8String:@encode(long long)] : NSStringFromSelector (@selector(longLongValue)),
            [NSString stringWithUTF8String:@encode(unsigned char)] : NSStringFromSelector (@selector(unsignedCharValue)),
            [NSString stringWithUTF8String:@encode(unsigned int)] : NSStringFromSelector (@selector(unsignedIntegerValue)),
            [NSString stringWithUTF8String:@encode(unsigned short)] : NSStringFromSelector (@selector(unsignedShortValue)),
            [NSString stringWithUTF8String:@encode(unsigned long)] : NSStringFromSelector (@selector(unsignedLongValue)),
            [NSString stringWithUTF8String:@encode(unsigned long long)] : NSStringFromSelector (@selector(unsignedLongLongValue)),
            [NSString stringWithUTF8String:@encode(float)] : NSStringFromSelector (@selector(floatValue)),
            [NSString stringWithUTF8String:@encode(double)] : NSStringFromSelector (@selector(doubleValue))
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
    void *temp = malloc (sizeOfType);

    [numberInvocation getReturnValue:temp];
    [invocation setReturnValue:temp];

    free (temp);
}

- (NSMethodSignature *)signature
{
    NSString *signature = [NSString stringWithFormat:@"%@%s%s", self.type, @encode(NSObject *), @encode(SEL)];
    return [NSMethodSignature signatureWithObjCTypes:[signature cStringUsingEncoding:NSUTF8StringEncoding]];
}

@end