//
//  CPropertiesDescriptorsAccessorsHolderTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 01.06.14.
//
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "CPropertiesDescriptorsAccessorsHolder.h"
#import "CITestPropertyDescriptor.h"
#import "CAdaptedCommonPresented.h"
#import "CAdaptedObjectStrongGetter.h"
#import "CAdaptedObjectWeakGetter.h"
#import "CAdaptedStructureGetter.h"
#import "CAdaptedScalarNumberGetter.h"
#import "CAdaptedClassGetter.h"
#import "CAdaptedSelectorGetter.h"
#import "CAdaptedObjectStrongSetter.h"
#import "CAdaptedObjectWeakSetter.h"
#import "CAdaptedStructureSetter.h"
#import "CAdaptedClassSetter.h"
#import "CAdaptedSelectorSetter.h"
#import "CAdaptedScalarNumberSetter.h"

@interface CPropertiesDescriptorsAccessorsHolderTest : XCTestCase
@end

@interface CPropertiesDescriptorsAccessorsHolder ()

+ (NSMutableSet *)extractPropertiesWithPresentedLikeAccessor:(Protocol *)protocol;

+ (NSMutableDictionary *)collectRegisteredPropertiesForRootProtocol:(Protocol *)descriptorProtocol;

+ (NSMutableDictionary *)createAccessorsOfPropertiesForRootProtocol:(Protocol *)descriptorProtocol;

@end

@implementation CPropertiesDescriptorsAccessorsHolderTest
{
    Protocol *_protocol;
}

- (void)setUp
{
    [super setUp];
    _protocol = @protocol(CITestPropertyDescriptor);
}

- (void)tearDown
{
    _protocol = nil;
    [super tearDown];
}

- (void)testExtractPropertiesWithPresentedAccessorWithNil
{
    NSMutableSet *set = [CPropertiesDescriptorsAccessorsHolder extractPropertiesWithPresentedLikeAccessor:nil];
    XCTAssertNotNil(set, "Метод [CPropertiesDescriptorsAccessorsHolder extractPropertiesWithPresentedLikeAccessor:] не должен возвращать nil ни при каких обстоятельствах");
    XCTAssertEqual(set.count, 0, "Метод [CPropertiesDescriptorsAccessorsHolder extractPropertiesWithPresentedAccessor:nil] должен возвращать пустое множество");
}

- (void)testExtractPropertiesWithPresentedAccessor
{
    NSMutableSet *properties = [CPropertiesDescriptorsAccessorsHolder extractPropertiesWithPresentedLikeAccessor:_protocol];
    XCTAssertEqual(properties.count, 3, "В интерфейсе 3 presented-like свойства, но метод [CPropertiesDescriptorsAccessorsHolder extractPropertiesWithPresentedLikeAccessor:] возвращает %d", properties.count);

    for (id element in properties)
    {
        XCTAssertTrue([element isKindOfClass:[NSString class]], "Элементы множества, возвращаемого из [CPropertiesDescriptorsAccessorsHolder extractPropertiesWithPresentedLikeAccessor:] должны быть объекты типа NSString*. В множестве содержится элемент типа %@ ", NSStringFromClass ([element class]));
    }

    NSMutableSet *testSet = [[NSMutableSet alloc] initWithCapacity:2];
    [testSet addObject:@"strongObject"];
    [testSet addObject:@"retainObject"];
    [testSet addObject:@"unknown"];
    XCTAssertEqualObjects(properties, testSet, "Метод [CPropertiesDescriptorsAccessorsHolder extractPropertiesWithPresentedLikeAccessor:] с тестовым протоколом CITestPropertyDescriptor возвращает неверное множество");
}

- (void)testCollectRegisteredPropertiesForRootProtocol
{
    NSMutableDictionary *result = [CPropertiesDescriptorsAccessorsHolder collectRegisteredPropertiesForRootProtocol:@protocol(CITestSuperPropertyDescriptor)];
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
    XCTAssertEqualObjects(result, sample, "Метод [CPropertiesDescriptorsAccessorsHolder collectRegisteredPropertiesForRootProtocol:] возвращает неверную карту свойств для протокола CITestPropertyDescriptor");
}

- (void)testAccessorsConstruction
{
    NSDictionary *sample = @{
            @"extraWithPresentedPresented" : NSStringFromClass([CAdaptedCommonPresented class]),
            @"strongObjectPresented" : NSStringFromClass([CAdaptedCommonPresented class]),
            @"retainObjectPresented" : NSStringFromClass([CAdaptedCommonPresented class]),

            @"extraWithoutPresented" : NSStringFromClass([CAdaptedObjectStrongGetter class]),
            @"extraWithPresented" : NSStringFromClass([CAdaptedObjectStrongGetter class]),
            @"getSO" : NSStringFromClass([CAdaptedObjectStrongGetter class]),
            @"retainObject" : NSStringFromClass([CAdaptedObjectStrongGetter class]),
            @"copyObject" : NSStringFromClass([CAdaptedObjectStrongGetter class]),
            @"readonlyObject" : NSStringFromClass([CAdaptedObjectStrongGetter class]),

            @"weakObject" : NSStringFromClass([CAdaptedObjectWeakGetter class]),
            @"assignObject" : NSStringFromClass([CAdaptedObjectWeakGetter class]),

            @"assignStructure" : NSStringFromClass([CAdaptedStructureGetter class]),
            @"readonlyStructure" : NSStringFromClass([CAdaptedStructureGetter class]),

            @"assignUnsignedLong" : NSStringFromClass([CAdaptedScalarNumberGetter class]),
            @"readonlyLong" : NSStringFromClass([CAdaptedScalarNumberGetter class]),
            @"assignUnsignedLongPP" : NSStringFromClass([CAdaptedScalarNumberGetter class]),
            @"readonlyLongPresented" : NSStringFromClass([CAdaptedScalarNumberGetter class]),
            @"unknownPresented" : NSStringFromClass([CAdaptedScalarNumberGetter class]),

            @"assignClass" : NSStringFromClass([CAdaptedClassGetter class]),
            @"readonlyClass" : NSStringFromClass([CAdaptedClassGetter class]),

            @"assignSelector" : NSStringFromClass([CAdaptedSelectorGetter class]),
            @"readonlySelector" : NSStringFromClass([CAdaptedSelectorGetter class]),

            @"setExtraWithoutPresented:" : NSStringFromClass([CAdaptedObjectStrongSetter class]),
            @"setExtraWithPresented:" : NSStringFromClass([CAdaptedObjectStrongSetter class]),
            @"setSO:" : NSStringFromClass([CAdaptedObjectStrongSetter class]),
            @"setRetainObject:" : NSStringFromClass([CAdaptedObjectStrongSetter class]),
            @"setCopyObject:" : NSStringFromClass([CAdaptedObjectStrongSetter class]),

            @"setAssignObject:" : NSStringFromClass([CAdaptedObjectWeakSetter class]),
            @"setWeakObject:" : NSStringFromClass([CAdaptedObjectWeakSetter class]),

            @"setAssignStructure:" : NSStringFromClass([CAdaptedStructureSetter class]),

            @"setAssignClass:" : NSStringFromClass([CAdaptedClassSetter class]),

            @"setAssignSelector:" : NSStringFromClass([CAdaptedSelectorSetter class]),

            @"setAssignUnsignedLong:" : NSStringFromClass([CAdaptedScalarNumberSetter class])
    };
    NSMutableDictionary *accessors = [CPropertiesDescriptorsAccessorsHolder createAccessorsOfPropertiesForRootProtocol:@protocol(ARHIPropertiesDescriptor)];

    NSMutableDictionary *accessorsClassNames = [[NSMutableDictionary alloc] initWithCapacity:accessors.count];
    for (NSString *key in [accessors allKeys])
    {
        [accessorsClassNames setObject:NSStringFromClass ([[accessors objectForKey:key] class])
                                forKey:key];
    }

    XCTAssertEqualObjects(sample, accessorsClassNames, "Список свойств, сформированный Holder'ом на тестовом окружении имеет неверный состав");
}

@end
