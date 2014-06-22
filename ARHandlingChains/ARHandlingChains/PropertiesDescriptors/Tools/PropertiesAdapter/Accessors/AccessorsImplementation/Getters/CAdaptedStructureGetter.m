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
    NSString *signature = [NSString stringWithFormat:@"%@%s%s", self.type, @encode(NSObject *), @encode(SEL)];
    return [NSMethodSignature signatureWithObjCTypes:[signature cStringUsingEncoding:NSUTF8StringEncoding]];
}

- (void)performWithInvocation:(NSInvocation *)invocation
                     delegate:(NSMutableDictionary *)dictionary
{
    NSData *data = [dictionary objectForKey:self.propertyName];

    NSUInteger sizeOfType;
    NSGetSizeAndAlignment ([self.type cStringUsingEncoding:NSUTF8StringEncoding], &sizeOfType, NULL);
    void *temp = malloc (sizeOfType);

    [data getBytes:temp];

    [invocation setReturnValue:temp];
    free(temp);
}

@end