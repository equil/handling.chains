//
// Created by Alexey Rogatkin on 30.05.14.
//

#import "CPropertiesDescriptorsAccessorsHolder.h"
#import "ARHIPropertiesDescriptor.h"
#import "ARHCPropertyInfo.h"
#import "AbstractAccessorFactory.h"
#import "CChildProtocols.h"
#import "CPropertyInfosForProtocol.h"

@implementation CPropertiesDescriptorsAccessorsHolder
{
    NSMutableDictionary *_accessors;
}

@synthesize accessors = _accessors;

- (id)initPrivate
{
    self = [super init];
    if (self)
    {
        _accessors = [CPropertiesDescriptorsAccessorsHolder createAccessorsOfPropertiesForRootProtocol:@protocol(ARHIPropertiesDescriptor)];
    }
    return self;
}

+ (CPropertiesDescriptorsAccessorsHolder *)holder
{
    static CPropertiesDescriptorsAccessorsHolder *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^
    {
        sharedInstance = [[CPropertiesDescriptorsAccessorsHolder alloc] initPrivate];
    });

    return sharedInstance;
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

    CChildProtocols *protocols = [[CChildProtocols alloc] initWithProtocol:descriptorProtocol];
    for (Protocol *childProtocol in protocols)
    {
        [result addEntriesFromDictionary:[self createAccessorsOfPropertiesForRootProtocol:childProtocol
                                                                               properties:properties]];
    }

    CPropertyInfosForProtocol *propertyInfos = [[CPropertyInfosForProtocol alloc] initWithProtocol:descriptorProtocol];
    for (ARHCPropertyInfo *info in propertyInfos)
    {
        if ([properties objectForKey:info.name] != nil)
        {
            AbstractAccessorFactory *factory = [AbstractAccessorFactory newFactoryFor:info
                                                                needPresentedAccessor:[[properties objectForKey:info.name] boolValue]];
            if (factory == nil)
            {
                NSLog (@"Warning: Can't create accessors for property \"%@\" of \"%@\" protocol. Type of property is not supported.", info.name, NSStringFromProtocol (descriptorProtocol));
            }
            else
            {
                id <IAdaptedPropertyAccessor> accessor = factory.createGetterAccessor;
                if (accessor != nil)
                {
                    [result setObject:accessor
                               forKey:accessor.accessorName];
                }

                accessor = factory.createSetterAccessor;
                if (accessor != nil)
                {
                    [result setObject:accessor
                               forKey:accessor.accessorName];
                }

                accessor = factory.createPresentedAccessor;
                if (accessor != nil)
                {
                    [result setObject:accessor
                               forKey:accessor.accessorName];
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
    CChildProtocols *childProtocols = [[CChildProtocols alloc] initWithProtocol:descriptorProtocol];
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

    CChildProtocols *adoptedProtocols = [[CChildProtocols alloc] initWithProtocol:descriptorProtocol];
    for (Protocol *protocol in adoptedProtocols)
    {
        [result unionSet:[self collectPropertyNamesWithPresentedAccessorsRecursivelyForProtocol:protocol]];
    }

    [result unionSet:[CPropertiesDescriptorsAccessorsHolder extractPropertiesWithPresentedLikeAccessor:descriptorProtocol]];

    return result;
}

+ (NSMutableSet *)extractProperties:(Protocol *)protocol
{
    NSMutableSet *result = [[NSMutableSet alloc] init];

    CPropertyInfosForProtocol *properties = [[CPropertyInfosForProtocol alloc] initWithProtocol:protocol];
    for (ARHCPropertyInfo *propertyInfo in properties)
    {
        if (![CPropertiesDescriptorsAccessorsHolder isPresentedLikeAccessor:propertyInfo])
        {
            [result addObject:propertyInfo.name];
        }
    }

    return result;
}

+ (NSMutableSet *)extractPropertiesWithPresentedLikeAccessor:(Protocol *)protocol
{
    NSMutableSet *result = [[NSMutableSet alloc] init];

    CPropertyInfosForProtocol *properties = [[CPropertyInfosForProtocol alloc] initWithProtocol:protocol];
    for (ARHCPropertyInfo *propertyInfo in properties)
    {
        if ([CPropertiesDescriptorsAccessorsHolder isPresentedLikeAccessor:propertyInfo])
        {
            [result addObject:[propertyInfo.name substringToIndex:propertyInfo.name.length - 9]];
        }
    }

    return result;
}

+ (BOOL)isPresentedLikeAccessor:(ARHCPropertyInfo *)propertyInfo
{
    return [propertyInfo.name hasSuffix:@"Presented"] && [propertyInfo.type isEqualToString:@"c"]
            && propertyInfo.readonly;
}

@end