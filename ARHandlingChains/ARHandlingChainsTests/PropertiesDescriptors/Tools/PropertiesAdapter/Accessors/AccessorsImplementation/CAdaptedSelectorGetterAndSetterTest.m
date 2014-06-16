//
//  CAdaptedSelectorGetterAndSetterTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 05.06.14.
//
//

#import <XCTest/XCTest.h>
#import "CAdaptedCommonSettersAndGettersTest.h"
#import "CAdaptedSelectorGetter.h"
#import "CAdaptedSelectorSetter.h"

@interface CAdaptedSelectorGetterAndSetterTest : CAdaptedCommonSettersAndGettersTest

@property (nonatomic, assign) SEL testSelector;

@end

@implementation CAdaptedSelectorGetterAndSetterTest

@dynamic testSelector;

- (void)setUp
{
    [super setUp];
    _backbone = [[NSMutableDictionary alloc] initWithCapacity:1];
    _accessors = @{
            @"testSelector" : [[CAdaptedSelectorGetter alloc] initWithPropertyName:@"testSelector"],
            @"setTestSelector:" : [[CAdaptedSelectorSetter alloc] initWithPropertyName:@"testSelector"],
    };
}

- (void)tearDown
{
    _backbone = nil;
    _accessors = nil;
    [super tearDown];
}

- (void)testSetSelector
{
    SEL testSelector = NSSelectorFromString (@"my:test:selector:");
    self.testSelector = testSelector;
    XCTAssertEqualObjects(@"my:test:selector:", [_backbone objectForKey:@"testSelector"], "Экземпляр объекта CAdaptedSelectorSetter неверно сохраняет значение");
}

- (void)testGetSelector
{
    SEL testSelector = NSSelectorFromString (@"my:test:selector:");
    [_backbone setObject:@"my:test:selector:"
                  forKey:@"testSelector"];
    SEL savedSelector = self.testSelector;
    XCTAssertEqual(testSelector, savedSelector, "Экземпляр объекта CAdaptedSelectorGetter неверно извлекает значение");
}

- (void)testSetAndGetSelector
{
    SEL testSelector = NSSelectorFromString (@"my:test:selector:");
    self.testSelector = testSelector;
    SEL savedSelector = self.testSelector;
    XCTAssertEqual(savedSelector, testSelector, "Селекторы не идентичны");
}

@end
