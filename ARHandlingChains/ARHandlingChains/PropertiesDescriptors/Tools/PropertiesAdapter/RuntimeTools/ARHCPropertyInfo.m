//
// Created by Alexey Rogatkin on 02.06.14.
//

#import "ARHCPropertyInfo.h"

@implementation ARHCPropertyInfo
{
    NSDictionary *_attributes;
    NSString *_name;
    NSString *_getter;
    NSString *_setter;
}

#pragma mark - Initialization

- (id)initWithProperty:(objc_property_t)property
{
    if (property == nil)
    {
        return nil;
    }
    self = [super init];
    if (self)
    {
        _attributes = [ARHCPropertyInfo extractAttributes:property];
        _name = [NSString stringWithCString:property_getName (property)
                                   encoding:NSUTF8StringEncoding];
    }
    return self;
}

+ (NSMutableDictionary *)extractAttributes:(objc_property_t)property
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    unsigned int count;
    objc_property_attribute_t *attributes = property_copyAttributeList (property, &count);
    if (count > 0)
    {
        for (int i = 0; i < count; i++)
        {
            [result setObject:[NSString stringWithCString:attributes[ i ].value
                                                 encoding:NSUTF8StringEncoding]
                       forKey:[NSString stringWithCString:attributes[ i ].name
                                                 encoding:NSUTF8StringEncoding]];
        }
    }
    return result;
}

#pragma mark - Public interface behavior

- (BOOL)weakOrAssign
{
    return ([_attributes objectForKey:@"C"] == nil && [_attributes objectForKey:@"&"] == nil && [_attributes objectForKey:@"R"] == nil)
            || [_attributes objectForKey:@"W"] != nil || self.typeOfType != ARHCCPropertyInfoObjectType;
}

- (BOOL)strongOrRetain
{
    return !self.weakOrAssign;
}

- (BOOL)readonly
{
    return [_attributes objectForKey:@"R"] != nil;
}

- (NSString *)getter
{
    if (_getter == nil)
    {
        _getter = [_attributes objectForKey:@"G"];
        if (_getter == nil)
        {
            _getter = self.name;
        }
    }
    return _getter;
}

- (NSString *)setter
{
    if (_setter == nil)
    {
        _setter = [_attributes objectForKey:@"S"];
        if (_setter == nil)
        {
            NSRange firstCharRange = { .location = 0, .length = 1 };
            NSString *firstCharacter = [[self.name substringWithRange:firstCharRange] uppercaseString];
            NSString *tail = [self.name substringFromIndex:1];
            _setter = [NSString stringWithFormat:@"set%@%@:",
                                                 firstCharacter,
                                                 tail];
        }
    }
    return _setter;
}

- (NSString *)type
{
    NSString *result = [_attributes objectForKey:@"T"];
    if ([result hasPrefix:@"@"]) {
        result = @"@";
    }
    return result;
}

- (NSString *)name
{
    return _name;
}

- (BOOL)copied
{
    return [_attributes objectForKey:@"C"] != nil;
}

- (BOOL)nonAtomic
{
    return [_attributes objectForKey:@"N"] != nil;
}

- (ARHCCPropertyInfoTypeOfType)typeOfType
{
    if ([self.type hasPrefix:@"c"] || [self.type hasPrefix:@"i"] || [self.type hasPrefix:@"s"]
            || [self.type hasPrefix:@"l"] || [self.type hasPrefix:@"q"] || [self.type hasPrefix:@"C"]
            || [self.type hasPrefix:@"I"] || [self.type hasPrefix:@"S"] || [self.type hasPrefix:@"L"]
            || [self.type hasPrefix:@"Q"] || [self.type hasPrefix:@"f"] || [self.type hasPrefix:@"d"])
    {
        return ARHCCPropertyInfoScalarNumberType;
    }
    if ([self.type hasPrefix:@"@"])
    {
        return ARHCCPropertyInfoObjectType;
    }
    if ([self.type hasPrefix:@":"])
    {
        return ARHCCPropertyInfoSelectorType;
    }
    if ([self.type hasPrefix:@"#"])
    {
        return ARHCCPropertyInfoClassType;
    }
    if ([self.type hasPrefix:@"{"])
    {
        return ARHCCPropertyInfoStructureType;
    }

    return ARHCCPropertyInfoUnsupportedType;
}

@end