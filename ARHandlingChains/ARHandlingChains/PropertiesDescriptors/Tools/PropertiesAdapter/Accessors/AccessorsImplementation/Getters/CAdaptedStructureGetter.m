//
// Created by Alexey Rogatkin on 05.06.14.
//

#import "CAdaptedStructureGetter.h"

@implementation CAdaptedStructureGetter
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
    const char *types = [[NSString stringWithFormat:@"%@@:",
                                                    self.type] cStringUsingEncoding:NSUTF8StringEncoding];
    return [NSMethodSignature signatureWithObjCTypes:types];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    NSData *data = [dictionary objectForKey:self.propertyName];

    NSUInteger sizeOfType;
    NSGetSizeAndAlignment ([self.type cStringUsingEncoding:NSUTF8StringEncoding], &sizeOfType, NULL);
    void *temp = malloc (sizeof(sizeOfType));

    [data getBytes:temp];

    [invocation setReturnValue:temp];
}

@end