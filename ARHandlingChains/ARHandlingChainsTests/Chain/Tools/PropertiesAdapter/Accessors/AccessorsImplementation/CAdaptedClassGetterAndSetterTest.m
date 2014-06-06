//
//  CAdaptedSelectorGetterAndSetterTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 05.06.14.
//
//

#import <XCTest/XCTest.h>
#import "CAdaptedCommonSettersAndGettersTest.h"
#import "CAdaptedClassSetter.h"
#import "CAdaptedClassGetter.h"

@interface CAdaptedClassGetterAndSetterTest : CAdaptedCommonSettersAndGettersTest

@property (nonatomic, assign) Class testClass;

@end

@implementation CAdaptedClassGetterAndSetterTest

@dynamic testClass;

- (void)setUp
{
    [super setUp];
    _backbone = [[NSMutableDictionary alloc] initWithCapacity:1];
    _accessors = @{
            @"testClass" : [[CAdaptedClassGetter alloc] initWithPropertyName:@"testClass"],
            @"setTestClass:" : [[CAdaptedClassSetter alloc] initWithPropertyName:@"testClass"],
    };
}

- (void)tearDown
{
    _backbone = nil;
    _accessors = nil;
    [super tearDown];
}

- (void)testSetClass
{
    Class testClass = NSClassFromString (@"CAdaptedClassGetterAndSetterTest");
    self.testClass = testClass;
    XCTAssertEqualObjects(@"CAdaptedClassGetterAndSetterTest", [_backbone objectForKey:@"testClass"], "Экземпляр объекта CAdaptedClassSetter неверно сохраняет значение");
}

- (void)testGetClass
{
    Class testClass = NSClassFromString (@"CAdaptedClassGetterAndSetterTest");
    [_backbone setObject:@"CAdaptedClassGetterAndSetterTest"
                  forKey:@"testClass"];
    Class savedClass = self.testClass;
    XCTAssertEqual(testClass, savedClass, "Экземпляр объекта CAdaptedClassGetter неверно извлекает значение");
}

- (void)testSetAndGetClass
{
    Class testClass = NSClassFromString (@"CAdaptedClassGetterAndSetterTest");
    self.testClass = testClass;
    Class savedClass = self.testClass;
    XCTAssertEqual(savedClass, testClass, " Классы не идентичны");
}

@end
