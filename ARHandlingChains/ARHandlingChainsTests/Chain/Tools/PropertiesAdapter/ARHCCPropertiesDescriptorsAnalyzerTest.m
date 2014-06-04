//
//  ARHCCPropertiesDescriptorsAnalyzerTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 01.06.14.
//
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "ARHCCPropertiesDescriptorsAnalyzer.h"
#import "ARHCCAdaptedPropertyAccessor.h"
#import "ARHCITestPropertyDescriptor.h"

@interface ARHCCPropertiesDescriptorsAnalyzerTest : XCTestCase
@end

@interface ARHCCPropertiesDescriptorsAnalyzer ()

+ (NSMutableSet *)extractPropertiesWithPresentedLikeAccessor:(Protocol *)protocol;

+ (NSMutableDictionary *)collectRegisteredPropertiesForRootProtocol:(Protocol *)descriptorProtocol;

@end

@implementation ARHCCPropertiesDescriptorsAnalyzerTest
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
    NSMutableSet *set = [ARHCCPropertiesDescriptorsAnalyzer extractPropertiesWithPresentedLikeAccessor:nil];
    XCTAssertNotNil(set, "Метод [ARHCCPropertiesDescriptorsAnalyzer extractPropertiesWithPresentedLikeAccessor:] не должен возвращать nil ни при каких обстоятельствах");
    XCTAssertEqual(set.count, 0, "Метод [ARHCCPropertiesDescriptorsAnalyzer extractPropertiesWithPresentedAccessor:nil] должен возвращать пустое множество");
}

- (void)testExtractPropertiesWithPresentedAccessor
{
    NSMutableSet *properties = [ARHCCPropertiesDescriptorsAnalyzer extractPropertiesWithPresentedLikeAccessor:_protocol];
    XCTAssertEqual(properties.count, 3, "В интерфейсе 3 presented-like свойства, но метод [ARHCCPropertiesDescriptorsAnalyzer extractPropertiesWithPresentedLikeAccessor:] возвращает %d", properties.count);

    for (id element in properties)
    {
        XCTAssertTrue([element isKindOfClass:[NSString class]], "Элементы множества, возвращаемого из [ARHCCPropertiesDescriptorsAnalyzer extractPropertiesWithPresentedLikeAccessor:] должны быть объекты типа NSString*. В множестве содержится элемент типа %@ ", NSStringFromClass ([element class]));
    }

    NSMutableSet *testSet = [[NSMutableSet alloc] initWithCapacity:2];
    [testSet addObject:@"strongObject"];
    [testSet addObject:@"retainObject"];
    [testSet addObject:@"unknown"];
    XCTAssertEqualObjects(properties, testSet, "Метод [ARHCCPropertiesDescriptorsAnalyzer extractPropertiesWithPresentedLikeAccessor:] с тестовым протоколом ARHCITestPropertyDescriptor возвращает неверное множество");
}

- (void)testCollectRegisteredPropertiesForRootProtocol
{
    NSMutableDictionary *result = [ARHCCPropertiesDescriptorsAnalyzer collectRegisteredPropertiesForRootProtocol:@protocol(ARHCITestSuperPropertyDescriptor)];
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
    XCTAssertEqualObjects(result, sample, "Метод [ARHCCPropertiesDescriptorsAnalyzer collectRegisteredPropertiesForRootProtocol:] возвращает неверную карту свойств для протокола ARHCITestPropertyDescriptor");
}

- (void)testDebug
{
    ARHCCPropertiesDescriptorsAnalyzer *analyzer = [[ARHCCPropertiesDescriptorsAnalyzer alloc] init];
}

@end
