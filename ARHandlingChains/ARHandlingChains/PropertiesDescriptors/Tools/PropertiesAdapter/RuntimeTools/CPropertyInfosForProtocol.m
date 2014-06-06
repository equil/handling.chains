//
// Created by Alexey Rogatkin on 04.06.14.
//

#import <objc/runtime.h>
#import "CPropertyInfosForProtocol.h"
#import "ARHCPropertyInfo.h"

@implementation CPropertyInfosForProtocol
{
    NSMutableArray *_infos;
}

- (instancetype)initWithProtocol:(Protocol *)protocol
{
    if (protocol == nil)
    {
        return nil;
    }

    self = [super init];
    if (self)
    {
        unsigned int count = 0;
        objc_property_t *properties = protocol_copyPropertyList (protocol, &count);

        _infos = [[NSMutableArray alloc] initWithCapacity:count];
        for (int i = 0; i < count; i++)
        {
            [_infos addObject:[[ARHCPropertyInfo alloc] initWithProperty:properties[ i ]]];
        }

        free (properties);
    }

    return self;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)len
{
    return [_infos countByEnumeratingWithState:state
                                       objects:buffer
                                         count:len];
}

@end