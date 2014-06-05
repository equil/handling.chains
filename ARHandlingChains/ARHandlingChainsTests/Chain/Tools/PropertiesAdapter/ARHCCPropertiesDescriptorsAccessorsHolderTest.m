//
//  ARHCCPropertiesDescriptorsAccessorsHolderTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 01.06.14.
//
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "ARHCCPropertiesDescriptorsAccessorsHolder.h"
#import "ARHCITestPropertyDescriptor.h"
#import "ARHCCAdaptedCommonPresented.h"
#import "ARHCCAdaptedObjectStrongGetter.h"
#import "ARHCCAdaptedObjectWeakGetter.h"
#import "ARHCCAdaptedStructureGetter.h"
#import "ARHCCAdaptedScalarNumberGetter.h"
#import "ARHCCAdaptedClassGetter.h"
#import "ARHCCAdaptedSelectorGetter.h"
#import "ARHCCAdaptedObjectStrongSetter.h"
#import "ARHCCAdaptedObjectWeakSetter.h"
#import "ARHCCAdaptedStructureSetter.h"
#import "ARHCCAdaptedClassSetter.h"
#import "ARHCCAdaptedSelectorSetter.h"
#import "ARHCCAdaptedScalarNumberSetter.h"

@interface ARHCCPropertiesDescriptorsAccessorsHolderTest : XCTestCase
@end

@interface ARHCCPropertiesDescriptorsAccessorsHolder ()

+ (NSMutableSet *)extractPropertiesWithPresentedLikeAccessor:(Protocol *)protocol;

+ (NSMutableDictionary *)collectRegisteredPropertiesForRootProtocol:(Protocol *)descriptorProtocol;

+ (NSMutableDictionary *)createAccessorsOfPropertiesForRootProtocol:(Protocol *)descriptorProtocol;

@end

@implementation ARHCCPropertiesDescriptorsAccessorsHolderTest
{
    Protocol *_protocol;
}

- (void)setUp
{
    [super setUp];
    _protocol = @protocol(ARHCITestPropertyDescriptor);
}

- (void)tearDown
{
    _protocol = nil;
    [super tearDown];
}

- (void)testExtractPropertiesWithPresentedAccessorWithNil
{
    NSMutableSet *set = [ARHCCPropertiesDescriptorsAccessorsHolder extractPropertiesWithPresentedLikeAccessor:nil];
    XCTAssertNotNil(set, "Метод [ARHCCPropertiesDescriptorsAccessorsHolder extractPropertiesWithPresentedLikeAccessor:] не должен возвращать nil ни при каких обстоятельствах");
    XCTAssertEqual(set.count, 0, "Метод [ARHCCPropertiesDescriptorsAccessorsHolder extractPropertiesWithPresentedAccessor:nil] должен возвращать пустое множество");
}

- (void)testExtractPropertiesWithPresentedAccessor
{
    NSMutableSet *properties = [ARHCCPropertiesDescriptorsAccessorsHolder extractPropertiesWithPresentedLikeAccessor:_protocol];
    XCTAssertEqual(properties.count, 3, "В интерфейсе 3 presented-like свойства, но метод [ARHCCPropertiesDescriptorsAccessorsHolder extractPropertiesWithPresentedLikeAccessor:] возвращает %d", properties.count);

    for (id element in properties)
    {
        XCTAssertTrue([element isKindOfClass:[NSString class]], "Элементы множества, возвращаемого из [ARHCCPropertiesDescriptorsAccessorsHolder extractPropertiesWithPresentedLikeAccessor:] должны быть объекты типа NSString*. В множестве содержится элемент типа %@ ", NSStringFromClass ([element class]));
    }

    NSMutableSet *testSet = [[NSMutableSet alloc] initWithCapacity:2];
    [testSet addObject:@"strongObject"];
    [testSet addObject:@"retainObject"];
    [testSet addObject:@"unknown"];
    XCTAssertEqualObjects(properties, testSet, "Метод [ARHCCPropertiesDescriptorsAccessorsHolder extractPropertiesWithPresentedLikeAccessor:] с тестовым протоколом ARHCITestPropertyDescriptor возвращает неверное множество");
}

- (void)testCollectRegisteredPropertiesForRootProtocol
{
    NSMutableDictionary *result = [ARHCCPropertiesDescriptorsAccessorsHolder collectRegisteredPropertiesForRootProtocol:@protocol(ARHCITestSuperPropertyDescriptor)];
    NSDictionary *sample = @{
            @"strongObject" : @YES,
            @"retainObject" : @YES,
            @"copyObject" : @NO,
            @"weakObject" : @NO,
            @"assignObject" : @NO,
            @"readonlyObject" : @NO,
            @"assignUnsignedLong" : @NO,
            @"readonlyLong" : @NO,
            @"assignStructure" : @NO,
            @"readonlyStructure" : @NO,
            @"assignClass" : @NO,
            @"readonlyClass" : @NO,
            @"assignSelector" : @NO,
            @"readonlySelector" : @NO,
            @"assignUnsignedLongPP" : @NO,
            @"readonlyLongPresented" : @NO,
            @"unknownPresented" : @NO,
            @"extraWithPresented" : @YES,
            @"extraWithoutPresented" : @NO
    };
    XCTAssertEqualObjects(result, sample, "Метод [ARHCCPropertiesDescriptorsAccessorsHolder collectRegisteredPropertiesForRootProtocol:] возвращает неверную карту свойств для протокола ARHCITestPropertyDescriptor");
}

- (void)testAccessorsConstruction
{
    NSDictionary *sample = @{
            @"extraWithPresentedPresented" : NSStringFromClass([ARHCCAdaptedCommonPresented class]),
            @"strongObjectPresented" : NSStringFromClass([ARHCCAdaptedCommonPresented class]),
            @"retainObjectPresented" : NSStringFromClass([ARHCCAdaptedCommonPresented class]),

            @"extraWithoutPresented" : NSStringFromClass([ARHCCAdaptedObjectStrongGetter class]),
            @"extraWithPresented" : NSStringFromClass([ARHCCAdaptedObjectStrongGetter class]),
            @"getSO" : NSStringFromClass([ARHCCAdaptedObjectStrongGetter class]),
            @"retainObject" : NSStringFromClass([ARHCCAdaptedObjectStrongGetter class]),
            @"copyObject" : NSStringFromClass([ARHCCAdaptedObjectStrongGetter class]),
            @"readonlyObject" : NSStringFromClass([ARHCCAdaptedObjectStrongGetter class]),

            @"weakObject" : NSStringFromClass([ARHCCAdaptedObjectWeakGetter class]),
            @"assignObject" : NSStringFromClass([ARHCCAdaptedObjectWeakGetter class]),

            @"assignStructure" : NSStringFromClass([ARHCCAdaptedStructureGetter class]),
            @"readonlyStructure" : NSStringFromClass([ARHCCAdaptedStructureGetter class]),

            @"assignUnsignedLong" : NSStringFromClass([ARHCCAdaptedScalarNumberGetter class]),
            @"readonlyLong" : NSStringFromClass([ARHCCAdaptedScalarNumberGetter class]),
            @"assignUnsignedLongPP" : NSStringFromClass([ARHCCAdaptedScalarNumberGetter class]),
            @"readonlyLongPresented" : NSStringFromClass([ARHCCAdaptedScalarNumberGetter class]),
            @"unknownPresented" : NSStringFromClass([ARHCCAdaptedScalarNumberGetter class]),

            @"assignClass" : NSStringFromClass([ARHCCAdaptedClassGetter class]),
            @"readonlyClass" : NSStringFromClass([ARHCCAdaptedClassGetter class]),

            @"assignSelector" : NSStringFromClass([ARHCCAdaptedSelectorGetter class]),
            @"readonlySelector" : NSStringFromClass([ARHCCAdaptedSelectorGetter class]),

            @"setExtraWithoutPresented:" : NSStringFromClass([ARHCCAdaptedObjectStrongSetter class]),
            @"setExtraWithPresented:" : NSStringFromClass([ARHCCAdaptedObjectStrongSetter class]),
            @"setSO:" : NSStringFromClass([ARHCCAdaptedObjectStrongSetter class]),
            @"setRetainObject:" : NSStringFromClass([ARHCCAdaptedObjectStrongSetter class]),
            @"setCopyObject:" : NSStringFromClass([ARHCCAdaptedObjectStrongSetter class]),

            @"setAssignObject:" : NSStringFromClass([ARHCCAdaptedObjectWeakSetter class]),
            @"setWeakObject:" : NSStringFromClass([ARHCCAdaptedObjectWeakSetter class]),

            @"setAssignStructure:" : NSStringFromClass([ARHCCAdaptedStructureSetter class]),

            @"setAssignClass:" : NSStringFromClass([ARHCCAdaptedClassSetter class]),

            @"setAssignSelector:" : NSStringFromClass([ARHCCAdaptedSelectorSetter class]),

            @"setAssignUnsignedLong:" : NSStringFromClass([ARHCCAdaptedScalarNumberSetter class])
    };
    NSMutableDictionary *accessors = [ARHCCPropertiesDescriptorsAccessorsHolder createAccessorsOfPropertiesForRootProtocol:@protocol(ARHCIPropertiesDescriptor)];

    NSMutableDictionary *accessorsClassNames = [[NSMutableDictionary alloc] initWithCapacity:accessors.count];
    for (NSString *key in [accessors allKeys])
    {
        [accessorsClassNames setObject:NSStringFromClass ([[accessors objectForKey:key] class])
                                forKey:key];
    }

    XCTAssertEqualObjects(sample, accessorsClassNames, "Список свойств, сформированный Holder'ом на тестовом окружении имеет неверный состав");
}

@end
