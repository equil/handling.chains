//
// Created by Alexey Rogatkin on 30.05.14.
//

#import "ARHCCPropertiesDescriptorsAnalyzer.h"
#import "ARHCIPropertiesDescriptor.h"
#import "ARHCCAdaptedPropertyAccessor.h"
#import "ARHCCPropertyInfo.h"
#import "ARHCAccessorAbstractFactory.h"
#import "ARHCCChildProtocols.h"
#import "ARHCCPropertyInfosForProtocol.h"
#import <objc/runtime.h>

@implementation ARHCCPropertiesDescriptorsAnalyzer
{
    NSMutableDictionary *_accessors;
}

@synthesize accessors = _accessors;

- (id)init
{
    self = [super init];
    if (self)
    {
        _accessors = [ARHCCPropertiesDescriptorsAnalyzer createAccessorsOfPropertiesForRootProtocol:@protocol(ARHCIPropertiesDescriptor)];
        NSLog (@"Accessors: %@", _accessors);
    }
    return self;
}

+ (NSMutableDictionary *)createAccessorsOfPropertiesForRootProtocol:(Protocol *)descriptorProtocol
{
    NSDictionary *registeredProperties = [self collectRegisteredPropertiesForRootProtocol:descriptorProtocol];
    return [self createAccessorsOfPropertiesForRootProtocol:descriptorProtocol
                                                 properties:registeredProperties];
}

+ (NSMutableDictionary *)createAccessorsOfPropertiesForRootProtocol:(Protocol *)descriptorProtocol
                                                         properties:(NSDictionary *)properties
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];

    ARHCCChildProtocols *protocols = [[ARHCCChildProtocols alloc] initWithProtocol:descriptorProtocol];
    for (Protocol *childProtocol in protocols)
    {
        [result addEntriesFromDictionary:[self createAccessorsOfPropertiesForRootProtocol:childProtocol
                                                                               properties:properties]];
    }

    ARHCCPropertyInfosForProtocol *propertyInfos = [[ARHCCPropertyInfosForProtocol alloc] initWithProtocol:descriptorProtocol];
    for (ARHCCPropertyInfo *info in propertyInfos)
    {
        if ([properties objectForKey:info.name] != nil)
        {
            ARHCAccessorAbstractFactory *factory = [ARHCAccessorAbstractFactory newFactoryFor:info
                                                                        needPresentedAccessor:[[properties objectForKey:info.name] boolValue]];
            if (factory == nil)
            {
                NSLog (@"Warning: Can't create accessors for property \"%@\" of \"%@\" protocol. Type of property is not supported.", info.name, NSStringFromProtocol (descriptorProtocol));
            }
            else
            {
                id <ARHCIAdaptedPropertyAccessor> object = factory.createGetterAccessor;
                if (object != nil)
                {
                    [result setObject:object
                               forKey:object.accessorName];
                }

                object = factory.createSetterAccessor;
                if (object != nil)
                {
                    [result setObject:object
                               forKey:object.accessorName];
                }

                object = factory.createPresentedAccessor;
                if (object != nil)
                {
                    [result setObject:object
                               forKey:object.accessorName];
                }
            }
        }
    }

    return result;
}

+ (NSMutableDictionary *)collectRegisteredPropertiesForRootProtocol:(Protocol *)descriptorProtocol
{
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];

    NSMutableSet *propertiesWithPresented = [self collectPropertyNamesWithPresentedAccessorsRecursivelyForProtocol:descriptorProtocol];
    NSMutableSet *properties = [self collectPropertiesNamesRecursivelyForProtocol:descriptorProtocol];

    NSMutableSet *propertiesWPresented = [[NSMutableSet alloc] initWithSet:propertiesWithPresented];
    [propertiesWPresented minusSet:properties];
    for (NSString *property in propertiesWPresented)
    {
        [properties addObject:[NSString stringWithFormat:@"%@Presented",
                                                         property]];
    }
    [propertiesWithPresented minusSet:propertiesWPresented];

    for (NSString *property in properties)
    {
        result[ property ] = @([propertiesWithPresented containsObject:property]);
    }

    return result;
}

+ (NSMutableSet *)collectPropertiesNamesRecursivelyForProtocol:(Protocol *)descriptorProtocol
{
    NSMutableSet *result = [[NSMutableSet alloc] init];
    ARHCCChildProtocols *childProtocols = [[ARHCCChildProtocols alloc] initWithProtocol:descriptorProtocol];
    for (Protocol *protocol in childProtocols)
    {
        [result unionSet:[self collectPropertiesNamesRecursivelyForProtocol:protocol]];
    }

    [result unionSet:[self extractProperties:descriptorProtocol]];
    return result;
}

+ (NSMutableSet *)collectPropertyNamesWithPresentedAccessorsRecursivelyForProtocol:(Protocol *)descriptorProtocol
{
    NSMutableSet *result = [[NSMutableSet alloc] init];

    ARHCCChildProtocols *adoptedProtocols = [[ARHCCChildProtocols alloc] initWithProtocol:descriptorProtocol];
    for (Protocol *protocol in adoptedProtocols)
    {
        [result unionSet:[self collectPropertyNamesWithPresentedAccessorsRecursivelyForProtocol:protocol]];
    }

    [result unionSet:[ARHCCPropertiesDescriptorsAnalyzer extractPropertiesWithPresentedLikeAccessor:descriptorProtocol]];

    return result;
}

+ (NSMutableSet *)extractProperties:(Protocol *)protocol
{
    NSMutableSet *result = [[NSMutableSet alloc] init];

    ARHCCPropertyInfosForProtocol *properties = [[ARHCCPropertyInfosForProtocol alloc] initWithProtocol:protocol];
    for (ARHCCPropertyInfo *propertyInfo in properties)
    {
        if (![ARHCCPropertiesDescriptorsAnalyzer isPresentedLikeAccessor:propertyInfo])
        {
            [result addObject:propertyInfo.name];
        }
    }

    return result;
}

+ (NSMutableSet *)extractPropertiesWithPresentedLikeAccessor:(Protocol *)protocol
{
    NSMutableSet *result = [[NSMutableSet alloc] init];

    ARHCCPropertyInfosForProtocol *properties = [[ARHCCPropertyInfosForProtocol alloc] initWithProtocol:protocol];
    for (ARHCCPropertyInfo *propertyInfo in properties)
    {
        if ([ARHCCPropertiesDescriptorsAnalyzer isPresentedLikeAccessor:propertyInfo])
        {
            [result addObject:[propertyInfo.name substringToIndex:propertyInfo.name.length - 9]];
        }
    }

    return result;
}

+ (BOOL)isPresentedLikeAccessor:(ARHCCPropertyInfo *)propertyInfo
{
    return [propertyInfo.name hasSuffix:@"Presented"] && [propertyInfo.type isEqualToString:@"c"]
            && propertyInfo.readonly;
}

@end