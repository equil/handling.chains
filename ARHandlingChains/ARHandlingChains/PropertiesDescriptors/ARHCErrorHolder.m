//
// Created by Alexey Rogatkin on 21.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHCErrorHolder.h"

@implementation ARHCErrorHolder {
}

@synthesize elementClass = _elementClass;
@synthesize chainClass = _chainClass;
@synthesize additionalInfo = _additionalInfo;
@synthesize rootError = _rootError;

- (NSString *)signature {
    NSMutableString *result = [[NSMutableString alloc] initWithString:@""];
    ARHCErrorHolder *holder = self;

    do {
        if (![result isEqualToString:@""]) {
            [result appendString:@":"];
        }
        [result appendString:NSStringFromClass(holder.elementClass)];

        holder = holder.rootError;
    } while (holder != nil);

    return result;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"@chainError -> {"];
    [description appendFormat:@"\n\tsignature: %@,", self.signature];
    [description appendFormat:@"\n\tinfo: %@", [[self.additionalInfo description] stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"]];
    [description appendString:@"\n}>"];
    return description;
}


@end