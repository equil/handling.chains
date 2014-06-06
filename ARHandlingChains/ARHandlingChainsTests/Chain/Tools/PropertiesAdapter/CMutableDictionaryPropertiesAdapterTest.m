//
//  CMutableDictionaryPropertiesAdapterTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 06.06.14.
//
//

#import <XCTest/XCTest.h>
#import "CITestPropertyDescriptor.h"
#import "ARHCMutableDictionaryPropertiesAdapter.h"

@interface CMutableDictionaryPropertiesAdapterTest : XCTestCase

@end

@implementation CMutableDictionaryPropertiesAdapterTest
{
    NSMutableDictionary *_backbone;
    id <CITestPropertyDescriptor> _properties;
}

- (void)setUp
{
    [super setUp];
    _backbone = [[NSMutableDictionary alloc] init];
    _properties = (id <CITestPropertyDescriptor>) [[ARHCMutableDictionaryPropertiesAdapter alloc] initWithDictionary:_backbone];
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
