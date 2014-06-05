//
//  ARHCCMutableDictionaryPropertiesAdapterTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 06.06.14.
//
//

#import <XCTest/XCTest.h>
#import "ARHCITestPropertyDescriptor.h"
#import "ARHCCMutableDictionaryPropertiesAdapter.h"

@interface ARHCCMutableDictionaryPropertiesAdapterTest : XCTestCase

@end

@implementation ARHCCMutableDictionaryPropertiesAdapterTest
{
    NSMutableDictionary *_backbone;
    id<ARHCITestPropertyDescriptor> _properties;
}

- (void)setUp
{
    [super setUp];
    _backbone = [[NSMutableDictionary alloc] init];
    _properties = (id <ARHCITestPropertyDescriptor>) [[ARHCCMutableDictionaryPropertiesAdapter alloc] initWithDictionary:_backbone];
}

- (void)tearDown
{
    _backbone = nil;
    _properties = nil;
    [super tearDown];
}

- (void)testStrongObjectSetterGetterAndPresented
{
    NSString *str = @"тестовая строка";
    XCTAssertFalse(_properties.strongObjectPresented);
    _properties.strongObject = str;
    XCTAssertTrue(_properties.strongObjectPresented);
    XCTAssertEqualObjects(str, _properties.strongObject);
    _properties.strongObject = nil;
    XCTAssertFalse(_properties.strongObjectPresented);
}

@end
