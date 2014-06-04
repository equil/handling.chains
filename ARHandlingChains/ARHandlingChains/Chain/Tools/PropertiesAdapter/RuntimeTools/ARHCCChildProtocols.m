//
// Created by Alexey Rogatkin on 04.06.14.
//

#import <objc/runtime.h>
#import "ARHCCChildProtocols.h"

@implementation ARHCCChildProtocols
{
    Protocol * __unsafe_unretained *_allProtocols;
    unsigned int _count;
    Protocol *_parentProtocol;
}

- (instancetype)initWithProtocol:(Protocol *)parentProtocol
{
    if (parentProtocol == nil) {
        return nil;
    }

    self = [super init];
    if (self)
    {
        _parentProtocol = parentProtocol;
        _allProtocols = objc_copyProtocolList (&_count);
    }

    return self;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)len
{
    NSUInteger count = 0;
    unsigned long countOfItemsAlreadyEnumerated = state->state;

    if(countOfItemsAlreadyEnumerated == 0)
    {
        state->mutationsPtr = &state->extra[0];
    }

    if(countOfItemsAlreadyEnumerated < _count)
    {
        state->itemsPtr = buffer;
        while((countOfItemsAlreadyEnumerated < _count) && (count < len))
        {
            if (protocol_conformsToProtocol (_allProtocols[countOfItemsAlreadyEnumerated], _parentProtocol)
                    && _parentProtocol != _allProtocols[countOfItemsAlreadyEnumerated])
            {
                buffer[count] = _allProtocols[countOfItemsAlreadyEnumerated];
                count++;
            }
            countOfItemsAlreadyEnumerated++;
        }
    }

    state->state = countOfItemsAlreadyEnumerated;

    return count;
}

- (void)dealloc
{
    free (_allProtocols);
}

@end