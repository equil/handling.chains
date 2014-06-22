//
// Created by Alexey Rogatkin on 05.06.14.
//

#import "CAdaptedStructureSetter.h"

@implementation CAdaptedStructureSetter
{
}

@synthesize type = _type;

- (id)initWithPropertyName:(NSString *)propertyName
                      type:(NSString *)type
{
    self = [super initWithPropertyName:propertyName];
    if (self != nil)
    {
        _type = type;
    }
    return self;
}

- (NSMethodSignature *)signature
{
    NSString *signature = [NSString stringWithFormat:@"%s%s%s%@", @encode(void), @encode(NSObject *), @encode(SEL), self.type];
    return [NSMethodSignature signatureWithObjCTypes:[signature cStringUsingEncoding:NSUTF8StringEncoding]];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    NSUInteger sizeOfType;
    NSGetSizeAndAlignment ([self.type cStringUsingEncoding:NSUTF8StringEncoding], &sizeOfType, NULL);
    void *tempArgument = malloc (sizeOfType);

    [invocation getArgument:tempArgument
                    atIndex:2];

    NSData *value = [[NSData alloc] initWithBytesNoCopy:tempArgument
                                                 length:sizeOfType
                                           freeWhenDone:YES];
    [dictionary setObject:value
                   forKey:self.propertyName];
}

@end