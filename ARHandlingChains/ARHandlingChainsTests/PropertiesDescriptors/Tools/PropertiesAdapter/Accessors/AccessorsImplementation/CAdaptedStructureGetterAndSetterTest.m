//
//  CAdaptedStructureGetterAndSetterTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 05.06.14.
//
//

#import <XCTest/XCTest.h>
#import "CAdaptedStructureGetter.h"
#import "CAdaptedStructureSetter.h"
#import "CAdaptedCommonSettersAndGettersTest.h"

typedef struct
{
    int a;
    unsigned long long b;
    const char *c;
} TestStruct;

@interface CAdaptedStructureGetterAndSetterTest : CAdaptedCommonSettersAndGettersTest

@property (nonatomic, assign) TestStruct myTestStruct;

@end

@implementation CAdaptedStructureGetterAndSetterTest

@dynamic myTestStruct;

- (void)setUp
{
    [super setUp];
    _backbone = [[NSMutableDictionary alloc] initWithCapacity:1];

    _accessors = @{
            @"myTestStruct" : [[CAdaptedStructureGetter alloc] initWithPropertyName:@"myTestStruct"
                                                                                   type:[NSString stringWithCString:@encode(TestStruct)
                                                                                                           encoding:NSUTF8StringEncoding]],
            @"setMyTestStruct:" : [[CAdaptedStructureSetter alloc] initWithPropertyName:@"myTestStruct"
                                                                                   type:[NSString stringWithCString:@encode(TestStruct)
                                                                                                           encoding:NSUTF8StringEncoding]]
    };
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetAndSetStructure
{
    TestStruct testStruct = {.a = 3, .b = 23452153, .c = "hah"};

    self.myTestStruct = testStruct;
    TestStruct returnedStruct = self.myTestStruct;

    XCTAssertEqual(testStruct.a, returnedStruct.a, "Структуры не идентичны");
    XCTAssertEqual(testStruct.b, returnedStruct.b, "Структуры не идентичны");
    XCTAssertTrue(strcmp (testStruct.c, returnedStruct.c) == 0, "Структуры не идентичны");
}

- (void)testStructureExistsAfterReleasingBackbone
{
    TestStruct testStruct = {.a = 3, .b = 23452153, .c = "hah"};

    self.myTestStruct = testStruct;
    TestStruct returnedStruct = self.myTestStruct;

    [_backbone removeAllObjects];

    XCTAssertEqual(testStruct.a, returnedStruct.a, "Структуры не идентичны");
    XCTAssertEqual(testStruct.b, returnedStruct.b, "Структуры не идентичны");
    XCTAssertTrue(strcmp (testStruct.c, returnedStruct.c) == 0, "Структуры не идентичны");
}

@end
