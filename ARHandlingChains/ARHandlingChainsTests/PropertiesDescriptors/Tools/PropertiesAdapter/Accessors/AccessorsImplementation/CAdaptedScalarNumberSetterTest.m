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
                                                                              type:[NSString stringWithUTF8String:@encode(char)]],
            @"setTestInt:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testInt"
                                                                             type:[NSString stringWithUTF8String:@encode(int)]],
            @"setTestShort:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testShort"
                                                                               type:[NSString stringWithUTF8String:@encode(short)]],
            @"setTestLong:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testLong"
                                                                              type:[NSString stringWithUTF8String:@encode(long)]],
            @"setTestLongLong:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testLongLong"
                                                                                  type:[NSString stringWithUTF8String:@encode(long long)]],
            @"setTestUnsignedChar:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testUnsignedChar"
                                                                                      type:[NSString stringWithUTF8String:@encode(char)]],
            @"setTestUnsignedInt:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testUnsignedInt"
                                                                                     type:[NSString stringWithUTF8String:@encode(unsigned int)]],
            @"setTestUnsignedShort:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testUnsignedShort"
                                                                                       type:[NSString stringWithUTF8String:@encode(unsigned short)]],
            @"setTestUnsignedLong:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testUnsignedLong"
                                                                                      type:[NSString stringWithUTF8String:@encode(unsigned long)]],
            @"setTestUnsignedLongLong:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testUnsignedLongLong"
                                                                                          type:[NSString stringWithUTF8String:@encode(unsigned long long)]],
            @"setTestFloat:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testFloat"
                                                                               type:[NSString stringWithUTF8String:@encode(float)]],
            @"setTestDouble:" : [[CAdaptedScalarNumberSetter alloc] initWithPropertyName:@"testDouble"
                                                                                type:[NSString stringWithUTF8String:@encode(double)]]
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
    XCTAssertEqual([[_backbone objectForKey:@"testChar"] charValue], testValue, "Объект CAdaptedScalarNumberSetter неверно заворачивает свойство testChar");
}

- (void)testSetInt
{
    int testValue = 7;
    self.testInt = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testInt"] intValue], testValue, "Объект CAdaptedScalarNumberSetter неверно заворачивает свойство testInt");
}

- (void)testSetShort
{
    short testValue = 7;
    self.testShort = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testShort"] shortValue], testValue, "Объект CAdaptedScalarNumberSetter неверно заворачивает свойство testShort");
}

- (void)testSetLong
{
    long testValue = 7;
    self.testLong = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testLong"] longValue], testValue, "Объект CAdaptedScalarNumberSetter неверно заворачивает свойство testLong");
}

- (void)testSetLongLong
{
    long long testValue = 7;
    self.testLongLong = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testLongLong"] longLongValue], testValue, "Объект CAdaptedScalarNumberSetter неверно заворачивает свойство testLongLong");
}

- (void)testSetUnsignedChar
{
    unsigned char testValue = 7;
    self.testUnsignedChar = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedChar"] unsignedCharValue], testValue, "Объект CAdaptedScalarNumberSetter неверно заворачивает свойство testUnsignedChar");
}

- (void)testSetUnsignedInt
{
    unsigned int testValue = 7;
    self.testUnsignedInt = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedInt"] unsignedIntValue], testValue, "Объект CAdaptedScalarNumberSetter неверно заворачивает свойство testUnsignedInt");
}

- (void)testSetUnsignedShort
{
    unsigned short testValue = 7;
    self.testUnsignedShort = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedShort"] unsignedShortValue], testValue, "Объект CAdaptedScalarNumberSetter неверно заворачивает свойство ARHCCAdaptedScalarNumberSettertestUnsignedShort");
}

- (void)testSetUnsignedLong
{
    unsigned long testValue = 7;
    self.testUnsignedLong = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedLong"] unsignedLongValue], testValue, "Объект CAdaptedScalarNumberSetter неверно заворачивает свойство testUnsignedLong");
}

- (void)testSetUnsignedLongLong
{
    unsigned long long testValue = 7;
    self.testUnsignedLongLong = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedLongLong"] unsignedLongLongValue], testValue, "Объект CAdaptedScalarNumberSetter неверно заворачивает свойствос testUnsignedLongLong");
}

- (void)testSetFloat
{
    float testValue = 7;
    self.testFloat = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testFloat"] floatValue], testValue, "Объект CAdaptedScalarNumberSetter неверно заворачивает свойство testFloat");
}

- (void)testSetDouble
{
    double testValue = 7;
    self.testDouble = testValue;
    XCTAssertEqual([[_backbone objectForKey:@"testDouble"] doubleValue], testValue, "Объект CAdaptedScalarNumberSetter неверно заворачивает свойство testDouble");
}


@end
