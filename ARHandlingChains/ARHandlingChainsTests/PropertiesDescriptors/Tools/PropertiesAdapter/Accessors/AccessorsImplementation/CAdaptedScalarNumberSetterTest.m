//
//  CAdaptedScalarNumberSetterTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 04.06.14.
//
//

#import <XCTest/XCTest.h>
#import "CAdaptedScalarNumberSetter.h"
#import "CAdaptedCommonSettersAndGettersTest.h"

@interface CAdaptedScalarNumberSetterTest : CAdaptedCommonSettersAndGettersTest

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

@implementation CAdaptedScalarNumberSetterTest

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
            @"setTestChar:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testChar"
                                                                                      type:@"c"],
            @"setTestInt:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testInt"
                                                                                     type:@"i"],
            @"setTestShort:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testShort"
                                                                                       type:@"s"],
            @"setTestLong:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testLong"
                                                                                      type:@"l"],
            @"setTestLongLong:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testLongLong"
                                                                                          type:@"q"],
            @"setTestUnsignedChar:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testUnsignedChar"
                                                                                              type:@"C"],
            @"setTestUnsignedInt:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testUnsignedInt"
                                                                                             type:@"I"],
            @"setTestUnsignedShort:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testUnsignedShort"
                                                                                               type:@"S"],
            @"setTestUnsignedLong:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testUnsignedLong"
                                                                                              type:@"L"],
            @"setTestUnsignedLongLong:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testUnsignedLongLong"
                                                                                                  type:@"Q"],
            @"setTestFloat:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testFloat"
                                                                                       type:@"f"],
            @"setTestDouble:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testDouble"
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
    XCTAssertEqual([[_backbone objectForKey:@"testChar"] charValue], testValue, "Объект CAdaptedScalarNumberGetter неверно заворачивает свойство testChar");
}

- (void)testSetInt
{
    int testValue = 7;
    self.testInt = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testInt"] intValue], testValue, "Объект CAdaptedScalarNumberGetter неверно заворачивает свойство testInt");
}

- (void)testSetShort
{
    short testValue = 7;
    self.testShort = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testShort"] shortValue], testValue, "Объект CAdaptedScalarNumberGetter неверно заворачивает свойство testShort");
}

- (void)testSetLong
{
    long testValue = 7;
    self.testLong = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testLong"] longValue], testValue, "Объект CAdaptedScalarNumberGetter неверно заворачивает свойство testLong");
}

- (void)testSetLongLong
{
    long long testValue = 7;
    self.testLongLong = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testLongLong"] longLongValue], testValue, "Объект CAdaptedScalarNumberGetter неверно заворачивает свойство testLongLong");
}

- (void)testSetUnsignedChar
{
    unsigned char testValue = 7;
    self.testUnsignedChar = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedChar"] unsignedCharValue], testValue, "Объект CAdaptedScalarNumberGetter неверно заворачивает свойство testUnsignedChar");
}

- (void)testSetUnsignedInt
{
    unsigned int testValue = 7;
    self.testUnsignedInt = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedInt"] unsignedIntValue], testValue, "Объект CAdaptedScalarNumberGetter неверно заворачивает свойство testUnsignedInt");
}

- (void)testSetUnsignedShort
{
    unsigned short testValue = 7;
    self.testUnsignedShort = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedShort"] unsignedShortValue], testValue, "Объект CAdaptedScalarNumberGetter неверно заворачивает свойство ARHCCAdaptedScalarNumberGettertestUnsignedShort");
}

- (void)testSetUnsignedLong
{
    unsigned long testValue = 7;
    self.testUnsignedLong = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedLong"] unsignedLongValue], testValue, "Объект CAdaptedScalarNumberGetter неверно заворачивает свойство testUnsignedLong");
}

- (void)testSetUnsignedLongLong
{
    unsigned long long testValue = 7;
    self.testUnsignedLongLong = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedLongLong"] unsignedLongLongValue], testValue, "Объект CAdaptedScalarNumberGetter неверно заворачивает свойствос testUnsignedLongLong");
}

- (void)testSetFloat
{
    float testValue = 7;
    self.testFloat = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testFloat"] floatValue], testValue, "Объект CAdaptedScalarNumberGetter неверно заворачивает свойство testFloat");
}

- (void)testSetDouble
{
    double testValue = 7;
    self.testDouble = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testDouble"] doubleValue], testValue, "Объект CAdaptedScalarNumberGetter неверно заворачивает свойство testDouble");
}


@end
