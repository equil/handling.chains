//
//  CAdaptedScalarNumberGetterTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 04.06.14.
//
//

#import <XCTest/XCTest.h>
#import "CAdaptedScalarNumberGetter.h"
#import "CAdaptedCommonSettersAndGettersTest.h"

@interface CAdaptedScalarNumberGetterTest : CAdaptedCommonSettersAndGettersTest

@property (nonatomic, readonly) char testChar;
@property (nonatomic, readonly) int testInt;
@property (nonatomic, readonly) short testShort;
@property (nonatomic, readonly) long testLong;
@property (nonatomic, readonly) long long testLongLong;
@property (nonatomic, readonly) unsigned char testUnsignedChar;
@property (nonatomic, readonly) unsigned int testUnsignedInt;
@property (nonatomic, readonly) unsigned short testUnsignedShort;
@property (nonatomic, readonly) unsigned long testUnsignedLong;
@property (nonatomic, readonly) unsigned long long testUnsignedLongLong;
@property (nonatomic, readonly) float testFloat;
@property (nonatomic, readonly) double testDouble;

@end

@implementation CAdaptedScalarNumberGetterTest

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
    [_backbone setObject:[NSNumber numberWithChar:'c']
                  forKey:@"testChar"];
    [_backbone setObject:[NSNumber numberWithInt:34]
                  forKey:@"testInt"];
    [_backbone setObject:[NSNumber numberWithShort:3]
                  forKey:@"testShort"];
    [_backbone setObject:[NSNumber numberWithLong:4212]
                  forKey:@"testLong"];
    [_backbone setObject:[NSNumber numberWithLongLong:23412]
                  forKey:@"testLongLong"];
    [_backbone setObject:[NSNumber numberWithUnsignedChar:'a']
                  forKey:@"testUnsignedChar"];
    [_backbone setObject:[NSNumber numberWithUnsignedInt:324]
                  forKey:@"testUnsignedInt"];
    [_backbone setObject:[NSNumber numberWithUnsignedShort:23]
                  forKey:@"testUnsignedShort"];
    [_backbone setObject:[NSNumber numberWithUnsignedLong:5234]
                  forKey:@"testUnsignedLong"];
    [_backbone setObject:[NSNumber numberWithUnsignedLongLong:231243]
                  forKey:@"testUnsignedLongLong"];
    [_backbone setObject:[NSNumber numberWithFloat:4.234]
                  forKey:@"testFloat"];
    [_backbone setObject:[NSNumber numberWithDouble:5.2352]
                  forKey:@"testDouble"];

    _accessors = @{
            @"testChar" : [[CAdaptedScalarNumberGetter alloc] initWithPropertyName:@"testChar"
                                                                                  type:@"c"],
            @"testInt" : [[CAdaptedScalarNumberGetter alloc] initWithPropertyName:@"testInt"
                                                                                 type:@"i"],
            @"testShort" : [[CAdaptedScalarNumberGetter alloc] initWithPropertyName:@"testShort"
                                                                                   type:@"s"],
            @"testLong" : [[CAdaptedScalarNumberGetter alloc] initWithPropertyName:@"testLong"
                                                                                  type:@"l"],
            @"testLongLong" : [[CAdaptedScalarNumberGetter alloc] initWithPropertyName:@"testLongLong"
                                                                                      type:@"q"],
            @"testUnsignedChar" : [[CAdaptedScalarNumberGetter alloc] initWithPropertyName:@"testUnsignedChar"
                                                                                          type:@"C"],
            @"testUnsignedInt" : [[CAdaptedScalarNumberGetter alloc] initWithPropertyName:@"testUnsignedInt"
                                                                                         type:@"I"],
            @"testUnsignedShort" : [[CAdaptedScalarNumberGetter alloc] initWithPropertyName:@"testUnsignedShort"
                                                                                           type:@"S"],
            @"testUnsignedLong" : [[CAdaptedScalarNumberGetter alloc] initWithPropertyName:@"testUnsignedLong"
                                                                                          type:@"L"],
            @"testUnsignedLongLong" : [[CAdaptedScalarNumberGetter alloc] initWithPropertyName:@"testUnsignedLongLong"
                                                                                              type:@"Q"],
            @"testFloat" : [[CAdaptedScalarNumberGetter alloc] initWithPropertyName:@"testFloat"
                                                                                   type:@"f"],
            @"testDouble" : [[CAdaptedScalarNumberGetter alloc] initWithPropertyName:@"testDouble"
                                                                                    type:@"d"]
    };
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Testing

- (void)testGetChar
{
    XCTAssertEqual([[_backbone objectForKey:@"testChar"] charValue], self.testChar, "Объект CAdaptedScalarNumberGetter неверно разворачивает свойство testChar");
}

- (void)testGetInt
{
    XCTAssertEqual([[_backbone objectForKey:@"testInt"] intValue], self.testInt, "Объект CAdaptedScalarNumberGetter неверно разворачивает свойство testInt");
}

- (void)testGetShort
{
    XCTAssertEqual([[_backbone objectForKey:@"testShort"] shortValue], self.testShort, "Объект CAdaptedScalarNumberGetter неверно разворачивает свойство testShort");
}

- (void)testGetLong
{
    XCTAssertEqual([[_backbone objectForKey:@"testLong"] longValue], self.testLong, "Объект CAdaptedScalarNumberGetter неверно разворачивает свойство testLong");
}

- (void)testGetLongLong
{
    XCTAssertEqual([[_backbone objectForKey:@"testLongLong"] longLongValue], self.testLongLong, "Объект CAdaptedScalarNumberGetter неверно разворачивает свойство testLongLong");
}

- (void)testGetUnsignedChar
{
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedChar"] unsignedCharValue], self.testUnsignedChar, "Объект CAdaptedScalarNumberGetter неверно разворачивает свойство testUnsignedChar");
}

- (void)testGetUnsignedInt
{
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedInt"] unsignedIntValue], self.testUnsignedInt, "Объект CAdaptedScalarNumberGetter неверно разворачивает свойство testUnsignedInt");
}

- (void)testGetUnsignedShort
{
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedShort"] unsignedShortValue], self.testUnsignedShort, "Объект CAdaptedScalarNumberGetter неверно разворачивает свойство ARHCCAdaptedScalarNumberGettertestUnsignedShort");
}

- (void)testGetUnsignedLong
{
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedLong"] unsignedLongValue], self.testUnsignedLong, "Объект CAdaptedScalarNumberGetter неверно разворачивает свойство testUnsignedLong");
}

- (void)testGetUnsignedLongLong
{
    XCTAssertEqual([[_backbone objectForKey:@"testUnsignedLongLong"] unsignedLongLongValue], self.testUnsignedLongLong, "Объект CAdaptedScalarNumberGetter неверно разворачивает свойство) testUnsignedLongLong");
}

- (void)testGetFloat
{
    XCTAssertEqual([[_backbone objectForKey:@"testFloat"] floatValue], self.testFloat, "Объект CAdaptedScalarNumberGetter неверно разворачивает свойство testFloat");
}

- (void)testGetDouble
{
    XCTAssertEqual([[_backbone objectForKey:@"testDouble"] doubleValue], self.testDouble, "Объект CAdaptedScalarNumberGetter неверно разворачивает свойство testDouble");
}

@end
