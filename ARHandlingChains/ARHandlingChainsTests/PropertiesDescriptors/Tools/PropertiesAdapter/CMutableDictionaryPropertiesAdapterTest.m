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
#import "ARHCErrorHolder.h"

@interface CMutableDictionaryPropertiesAdapterTest : XCTestCase

@end

@implementation CMutableDictionaryPropertiesAdapterTest
{
    NSMutableDictionary *_backbone;
    NSObject <CITestPropertyDescriptor, NSCopying> *_properties;
}

- (void)setUp
{
    [super setUp];
    _backbone = [[NSMutableDictionary alloc] init];
    _properties = (NSObject <CITestPropertyDescriptor, NSCopying> *) [[ARHCMutableDictionaryPropertiesAdapter alloc] initWithDictionary:_backbone];
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

- (void)testCopyBehavior
{
    NSString *str = @"тестовая строка";
    _properties.strongObject = str;

    id <CITestPropertyDescriptor> copyOfProperties = [_properties copy];

    NSDictionary *state = ((ARHCMutableDictionaryPropertiesAdapter *)_properties).state;
    NSDictionary *copyOfState = ((ARHCMutableDictionaryPropertiesAdapter *)copyOfProperties).state;
    
    XCTAssertEqualObjects(state, copyOfState, "Скопированное состояние обертки не эквивалентно исходному");
    XCTAssertNotEqual(state, copyOfState, "Состояние обертки не копируется");
    XCTAssertNotEqual(_properties, copyOfProperties, "Обертка не копируется");
}

@end
