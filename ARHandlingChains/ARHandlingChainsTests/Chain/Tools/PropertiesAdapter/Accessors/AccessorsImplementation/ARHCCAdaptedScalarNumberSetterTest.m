//
//  ARHCCAdaptedScalarNumberSetterTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 04.06.14.
//
//

#import <XCTest/XCTest.h>
#import "ARHCCAdaptedScalarNumberSetter.h"
#import "ARHCCAdaptedCommonSettersAndGettersTest.h"

@interface ARHCCAdaptedScalarNumberSetterTest : ARHCCAdaptedCommonSettersAndGettersTest

@property (nonatomic, assign) char testChar;
@property (nonatomic, assign) int testInt;
@property (nonatomic, assign) short testShort;
@property (nonatomic, assign) long testLong;
@property (nonatomic, assign) long long testLongLong;
@property (nonatomic, assign) unsigned char testUnsignedChar;
@property (nonatomic, assign) unsigned int testUnsignedInt;
@property (nonatomic, assign) unsigned short testUnsignedShort;
@property (nonatomic, assign) unsigned long testUnsignedLong;
@property (nonatomic, assign) unsigned long long testUnsignedLongLong;
@property (nonatomic, assign) float testFloat;
@property (nonatomic, assign) double testDouble;

@end

@implementation ARHCCAdaptedScalarNumberSetterTest

@dynamic testChar;
@dynamic testInt;
@dynamic testShort;
@dynamic testLong;
@dynamic testLongLong;
@dynamic testUnsignedChar;
@dynamic testUnsignedInt;
@dynamic testUnsignedShort;
@dynamic testUnsignedLong;
@dynamic testUnsignedLongLong;
@dynamic testFloat;
@dynamic testDouble;


- (void)setUp
{
    [super setUp];
    _backbone = [[NSMutableDictionary alloc] initWithCapacity:12];

    _accessors = @{
            @"setTestChar:" : [[ARHCCAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testChar"
                                                                                      type:@"c"],
            @"setTestInt:" : [[ARHCCAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testInt"
                                                                                     type:@"i"],
            @"setTestShort:" : [[ARHCCAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testShort"
                                                                                       type:@"s"],
            @"setTestLong:" : [[ARHCCAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testLong"
                                                                                      type:@"l"],
            @"setTestLongLong:" : [[ARHCCAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testLongLong"
                                                                                          type:@"q"],
            @"setTestUnsignedChar:" : [[ARHCCAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testUnsignedChar"
                                                                                              type:@"C"],
            @"setTestUnsignedInt:" : [[ARHCCAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testUnsignedInt"
                                                                                             type:@"I"],
            @"setTestUnsignedShort:" : [[ARHCCAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testUnsignedShort"
                                                                                               type:@"S"],
            @"setTestUnsignedLong:" : [[ARHCCAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testUnsignedLong"
                                                                                              type:@"L"],
            @"setTestUnsignedLongLong:" : [[ARHCCAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testUnsignedLongLong"
                                                                                                  type:@"Q"],
            @"setTestFloat:" : [[ARHCCAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testFloat"
                                                                                       type:@"f"],
            @"setTestDouble:" : [[ARHCCAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testDouble"
                                                                                        type:@"d"]
    };
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Testing

- (void)testSetChar
{
    char testValue = 7;
    self.testChar = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testChar"] charValue], testValue, "Объект ARHCCAdaptedScalarNumberGetter неверно заворачивает свойство testChar");
}

- (void)testSetInt
{
    int testValue = 7;
    self.testInt = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testInt"] intValue], testValue, "Объект ARHCCAdaptedScalarNumberGetter неверно заворачивает свойство testInt");
}

- (void)testSetShort
{
    short testValue = 7;
    self.testShort = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testShort"] shortValue], testValue, "Объект ARHCCAdaptedScalarNumberGetter неверно заворачивает свойство testShort");
}

- (void)testSetLong
{
    long testValue = 7;
    self.testLong = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testLong"] longValue], testValue, "Объект ARHCCAdaptedScalarNumberGetter неверно заворачивает свойство testLong");
}

- (void)testSetLongLong
{
    long long testValue = 7;
    self.testLongLong = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testLongLong"] longLongValue], testValue, "Объект ARHCCAdaptedScalarNumberGetter неверно заворачивает свойство testLongLong");
}

- (void)testSetUnsignedChar
{
    unsigned char testValue = 7;
    self.testUnsignedChar = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedChar"] unsignedCharValue], testValue, "Объект ARHCCAdaptedScalarNumberGetter неверно заворачивает свойство testUnsignedChar");
}

- (void)testSetUnsignedInt
{
    unsigned int testValue = 7;
    self.testUnsignedInt = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedInt"] unsignedIntValue], testValue, "Объект ARHCCAdaptedScalarNumberGetter неверно заворачивает свойство testUnsignedInt");
}

- (void)testSetUnsignedShort
{
    unsigned short testValue = 7;
    self.testUnsignedShort = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedShort"] unsignedShortValue], testValue, "Объект ARHCCAdaptedScalarNumberGetter неверно заворачивает свойство ARHCCAdaptedScalarNumberGettertestUnsignedShort");
}

- (void)testSetUnsignedLong
{
    unsigned long testValue = 7;
    self.testUnsignedLong = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedLong"] unsignedLongValue], testValue, "Объект ARHCCAdaptedScalarNumberGetter неверно заворачивает свойство testUnsignedLong");
}

- (void)testSetUnsignedLongLong
{
    unsigned long long testValue = 7;
    self.testUnsignedLongLong = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedLongLong"] unsignedLongLongValue], testValue, "Объект ARHCCAdaptedScalarNumberGetter неверно заворачивает свойствос testUnsignedLongLong");
}

- (void)testSetFloat
{
    float testValue = 7;
    self.testFloat = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testFloat"] floatValue], testValue, "Объект ARHCCAdaptedScalarNumberGetter неверно заворачивает свойство testFloat");
}

- (void)testSetDouble
{
    double testValue = 7;
    self.testDouble = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testDouble"] doubleValue], testValue, "Объект ARHCCAdaptedScalarNumberGetter неверно заворачивает свойство testDouble");
}


@end
