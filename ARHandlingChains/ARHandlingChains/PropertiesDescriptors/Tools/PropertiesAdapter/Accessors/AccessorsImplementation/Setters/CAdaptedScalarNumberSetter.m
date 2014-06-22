//
// Created by Alexey Rogatkin on 04.06.14.
//

#import "CAdaptedScalarNumberSetter.h"

@implementation CAdaptedScalarNumberSetter
{
    NSDictionary *_typeToSelectorMapping;
}

@synthesize type = _type;

- (id)initWithPropertyName:(NSString *)propertyName
                      type:(NSString *)type
{
    _typeToSelectorMapping = @{
            [NSString stringWithUTF8String:@encode(char)] : NSStringFromSelector (@selector(numberWithChar:)),
            [NSString stringWithUTF8String:@encode(BOOL)] : NSStringFromSelector (@selector(numberWithBool:)),
            [NSString stringWithUTF8String:@encode(int)] : NSStringFromSelector (@selector(numberWithInt:)),
            [NSString stringWithUTF8String:@encode(short)] : NSStringFromSelector (@selector(numberWithShort:)),
            [NSString stringWithUTF8String:@encode(long)] : NSStringFromSelector (@selector(numberWithLong:)),
            [NSString stringWithUTF8String:@encode(long long)] : NSStringFromSelector (@selector(numberWithLongLong:)),
            [NSString stringWithUTF8String:@encode(unsigned char)] : NSStringFromSelector (@selector(numberWithUnsignedChar:)),
            [NSString stringWithUTF8String:@encode(unsigned int)] : NSStringFromSelector (@selector(numberWithUnsignedInt:)),
            [NSString stringWithUTF8String:@encode(unsigned short)] : NSStringFromSelector (@selector(numberWithUnsignedShort:)),
            [NSString stringWithUTF8String:@encode(unsigned long)] : NSStringFromSelector (@selector(numberWithUnsignedLong:)),
            [NSString stringWithUTF8String:@encode(unsigned long long)] : NSStringFromSelector (@selector(numberWithUnsignedLongLong:)),
            [NSString stringWithUTF8String:@encode(float)] : NSStringFromSelector (@selector(numberWithFloat:)),
            [NSString stringWithUTF8String:@encode(double)] : NSStringFromSelector (@selector(numberWithDouble:))
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
    NSUInteger alignment;
    NSGetSizeAndAlignment ([invocation.methodSignature getArgumentTypeAtIndex:2], &sizeOfType, &alignment);
    void *tempArgument = malloc (sizeOfType);

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
    NSString *signature = [NSString stringWithFormat:@"%s%s%s%@", @encode(void), @encode(NSObject *), @encode(SEL), self.type];
    return [NSMethodSignature signatureWithObjCTypes:[signature cStringUsingEncoding:NSUTF8StringEncoding]];
}




@end