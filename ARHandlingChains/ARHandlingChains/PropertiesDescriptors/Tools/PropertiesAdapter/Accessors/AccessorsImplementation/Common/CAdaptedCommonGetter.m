//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "CAdaptedCommonGetter.h"

@implementation CAdaptedCommonGetter

- (NSString *)defaultAccessorName
{
    return self.propertyName;
}

@end