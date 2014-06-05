//
//  ARHCCAdaptedSelectorGetterAndSetterTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 05.06.14.
//
//

#import <XCTest/XCTest.h>
#import "ARHCCAdaptedCommonSettersAndGettersTest.h"
#import "ARHCCAdaptedClassSetter.h"
#import "ARHCCAdaptedClassGetter.h"

@interface ARHCCAdaptedClassGetterAndSetterTest : ARHCCAdaptedCommonSettersAndGettersTest

@property (nonatomic, assign) Class testClass;

@end

@implementation ARHCCAdaptedClassGetterAndSetterTest

@dynamic testClass;

- (void)setUp
{
    [super setUp];
    _backbone = [[NSMutableDictionary alloc] initWithCapacity:1];
    _accessors = @{
            @"testClass" : [[ARHCCAdaptedClassGetter alloc] initWithPropertyName:@"testClass"],
            @"setTestClass:" : [[ARHCCAdaptedClassSetter alloc] initWithPropertyName:@"testClass"],
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
    Class testClass = NSClassFromString (@"ARHCCAdaptedClassGetterAndSetterTest");
    self.testClass = testClass;
    XCTAssertEqualObjects(@"ARHCCAdaptedClassGetterAndSetterTest", [_backbone objectForKey:@"testClass"], "Экземпляр объекта ARHCCAdaptedClassSetter неверно сохраняет значение");
}

- (void)testGetClass
{
    Class testClass = NSClassFromString (@"ARHCCAdaptedClassGetterAndSetterTest");
    [_backbone setObject:@"ARHCCAdaptedClassGetterAndSetterTest"
                  forKey:@"testClass"];
    Class savedClass = self.testClass;
    XCTAssertEqual(testClass, savedClass, "Экземпляр объекта ARHCCAdaptedClassGetter неверно извлекает значение");
}

- (void)testSetAndGetClass
{
    Class testClass = NSClassFromString (@"ARHCCAdaptedClassGetterAndSetterTest");
    self.testClass = testClass;
    Class savedClass = self.testClass;
    XCTAssertEqual(savedClass, testClass, " Классы не идентичны");
}

@end
