//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "CAdaptedCommonSetter.h"

@implementation CAdaptedCommonSetter

- (NSString *)defaultAccessorName
{
    NSRange firstCharacter = { .location = 0, .length = 1 };
    NSString *character = [self.propertyName substringWithRange:firstCharacter];

    NSString *name = [self.propertyName stringByReplacingCharactersInRange:firstCharacter
                                                                withString:[character uppercaseString]];

    return [NSString stringWithFormat:@"set%@:",
                                      name];
}

- (void)storeObject:(NSObject *)object
           delegate:(NSMutableDictionary *)delegate
{
    if (object == nil)
    {
        [delegate removeObjectForKey:self.propertyName];
    }
    else
    {
        [delegate setObject:object
                     forKey:self.propertyName];
    }
}

@end