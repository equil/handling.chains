//
// Created by Alexey Rogatkin on 06.06.14.
//

#import "CQueue.h"

@implementation CQueue
{
    NSMutableArray *_backingArray;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _backingArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)enqueue:(id)object
{
    if (object != nil) {
        [_backingArray addObject:object];
    }
}

- (id)dequeue
{
    id result = nil;
    if (_backingArray.count > 0) {
        result = [_backingArray objectAtIndex:0];
        [_backingArray removeObjectAtIndex:0];
    }
    return result;
}

@end