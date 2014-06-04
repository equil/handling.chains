//
//  ARHCCPropertyInfoTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 02.06.14.
//
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "ARHCCPropertyInfo.h"
#import "ARHCITestPropertyDescriptor.h"

@interface ARHCCPropertyInfo ()

+ (NSMutableDictionary *)extractAttributes:(objc_property_t)property;
@end

@interface ARHCCPropertyInfoTest : XCTestCase

@end

@implementation ARHCCPropertyInfoTest
{
    Protocol *_protocol;
    ARHCCPropertyInfo *_readonlySelector;
    ARHCCPropertyInfo *_assignSelector;
    ARHCCPropertyInfo *_readonlyClass;
    ARHCCPropertyInfo *_assignClass;
    ARHCCPropertyInfo *_readonlyStructure;
    ARHCCPropertyInfo *_assignStructure;
    ARHCCPropertyInfo *_readonlyLong;
    ARHCCPropertyInfo *_assignUnsignedLong;
    ARHCCPropertyInfo *_readonlyObject;
    ARHCCPropertyInfo *_assignObject;
    ARHCCPropertyInfo *_weakObject;
    ARHCCPropertyInfo *_copyObject;
    ARHCCPropertyInfo *_retainObject;
    ARHCCPropertyInfo *_strongObject;
}

- (void)setUp
{
    [super setUp];
    _protocol = @protocol(ARHCITestPropertyDescriptor);

    _strongObject = [[ARHCCPropertyInfo alloc] initWithProperty:protocol_getProperty (_protocol, "strongObject", YES, YES)];
    _retainObject = [[ARHCCPropertyInfo alloc] initWithProperty:protocol_getProperty (_protocol, "retainObject", YES, YES)];
    _copyObject = [[ARHCCPropertyInfo alloc] initWithProperty:protocol_getProperty (_protocol, "copyObject", YES, YES)];
    _weakObject = [[ARHCCPropertyInfo alloc] initWithProperty:protocol_getProperty (_protocol, "weakObject", YES, YES)];
    _assignObject = [[ARHCCPropertyInfo alloc] initWithProperty:protocol_getProperty (_protocol, "assignObject", YES, YES)];
    _readonlyObject = [[ARHCCPropertyInfo alloc] initWithProperty:protocol_getProperty (_protocol, "readonlyObject", YES, YES)];
    _assignUnsignedLong = [[ARHCCPropertyInfo alloc] initWithProperty:protocol_getProperty (_protocol, "assignUnsignedLong", YES, YES)];
    _readonlyLong = [[ARHCCPropertyInfo alloc] initWithProperty:protocol_getProperty (_protocol, "readonlyLong", YES, YES)];
    _assignStructure = [[ARHCCPropertyInfo alloc] initWithProperty:protocol_getProperty (_protocol, "assignStructure", YES, YES)];
    _readonlyStructure = [[ARHCCPropertyInfo alloc] initWithProperty:protocol_getProperty (_protocol, "readonlyStructure", YES, YES)];
    _assignClass = [[ARHCCPropertyInfo alloc] initWithProperty:protocol_getProperty (_protocol, "assignClass", YES, YES)];
    _readonlyClass = [[ARHCCPropertyInfo alloc] initWithProperty:protocol_getProperty (_protocol, "readonlyClass", YES, YES)];
    _assignSelector = [[ARHCCPropertyInfo alloc] initWithProperty:protocol_getProperty (_protocol, "assignSelector", YES, YES)];
    _readonlySelector = [[ARHCCPropertyInfo alloc] initWithProperty:protocol_getProperty (_protocol, "readonlySelector", YES, YES)];
}

- (void)tearDown
{
    _protocol = nil;

    _strongObject = nil;
    _retainObject = nil;
    _copyObject = nil;
    _weakObject = nil;
    _assignObject = nil;
    _readonlyObject = nil;
    _assignUnsignedLong = nil;
    _readonlyLong = nil;
    _assignStructure = nil;
    _readonlyStructure = nil;
    _assignClass = nil;
    _readonlyClass = nil;
    _assignSelector = nil;
    _readonlySelector = nil;

    [super tearDown];
}

- (void)testExtractNil
{
    NSMutableDictionary *attributes = [ARHCCPropertyInfo extractAttributes:nil];
    XCTAssertNotNil(attributes, "[ARHCCPropertyInfo extractAttributes:nil] не должен возвращать значение nil");
    XCTAssertEqual(attributes.count, 0, "Словарь, возвращаемый [ARHCCPropertyInfo extractAttributes:nil] должен быть пуст");
}

- (void)testInitInfoWithNilProperty
{
    ARHCCPropertyInfo *info = [[ARHCCPropertyInfo alloc] initWithProperty:nil];
    XCTAssertNil(info, "При инициализации nil-свойством объект информмации не должен создаваться");
}

- (void)testWeakOrAssign
{
    XCTAssertFalse(_strongObject.weakOrAssign, "Неверно определяется weak признак свойства на тестовом свойстве strongObject");
    XCTAssertFalse(_retainObject.weakOrAssign, "Неверно определяется weak признак свойства на тестовом свойстве retainObject");
    XCTAssertFalse(_copyObject.weakOrAssign, "Неверно определяется weak признак свойства на тестовом свойстве copyObject");
    XCTAssertTrue(_weakObject.weakOrAssign, "Неверно определяется weak признак свойства на тестовом свойстве weakObject");
    XCTAssertTrue(_assignObject.weakOrAssign, "Неверно определяется weak признак свойства на тестовом свойстве assignObject");
    XCTAssertFalse(_readonlyObject.weakOrAssign, "Неверно определяется weak признак свойства на тестовом свойстве readonlyObject");
    XCTAssertTrue(_assignUnsignedLong.weakOrAssign, "Неверно определяется weak признак свойства на тестовом свойстве assignUnsignedLong");
    XCTAssertTrue(_readonlyLong.weakOrAssign, "Неверно определяется weak признак свойства на тестовом свойстве readonlyLong");
    XCTAssertTrue(_assignStructure.weakOrAssign, "Неверно определяется weak признак свойства на тестовом свойстве assignStructure");
    XCTAssertTrue(_readonlyStructure.weakOrAssign, "Неверно определяется weak признак свойства на тестовом свойстве readonlyStructure");
    XCTAssertTrue(_assignClass.weakOrAssign, "Неверно определяется weak признак свойства на тестовом свойстве assignClass");
    XCTAssertTrue(_readonlyClass.weakOrAssign, "Неверно определяется weak признак свойства на тестовом свойстве readonlyClass");
    XCTAssertTrue(_assignSelector.weakOrAssign, "Неверно определяется weak признак свойства на тестовом свойстве assignSelector");
    XCTAssertTrue(_readonlySelector.weakOrAssign, "Неверно определяется weak признак свойства на тестовом свойстве readonlySelector");
}

- (void)testStrongOrRetain
{
    XCTAssertFalse(_weakObject.strongOrRetain, "Неверно определяется strong признак свойства на тестовом свойстве weakObject");
    XCTAssertFalse(_assignObject.strongOrRetain, "Неверно определяется strong признак свойства на тестовом свойстве assignObject");
    XCTAssertFalse(_assignUnsignedLong.strongOrRetain, "Неверно определяется strong признак свойства на тестовом свойстве assignUnsignedLong");
    XCTAssertFalse(_readonlyLong.strongOrRetain, "Неверно определяется strong признак свойства на тестовом свойстве readonlyLong");
    XCTAssertFalse(_assignStructure.strongOrRetain, "Неверно определяется strong признак свойства на тестовом свойстве assignStructure");
    XCTAssertFalse(_readonlyStructure.strongOrRetain, "Неверно определяется strong признак свойства на тестовом свойстве readonlyStructure");
    XCTAssertFalse(_assignClass.strongOrRetain, "Неверно определяется strong признак свойства на тестовом свойстве assignClass");
    XCTAssertFalse(_readonlyClass.strongOrRetain, "Неверно определяется strong признак свойства на тестовом свойстве readonlyClass");
    XCTAssertFalse(_assignSelector.strongOrRetain, "Неверно определяется strong признак свойства на тестовом свойстве assignSelector");
    XCTAssertFalse(_readonlySelector.strongOrRetain, "Неверно определяется strong признак свойства на тестовом свойстве readonlySelector");

    XCTAssertTrue(_strongObject.strongOrRetain, "Неверно определяется strong признак свойства на тестовом свойстве strongObject");
    XCTAssertTrue(_retainObject.strongOrRetain, "Неверно определяется strong признак свойства на тестовом свойстве retainObject");
    XCTAssertTrue(_copyObject.strongOrRetain, "Неверно определяется strong признак свойства на тестовом свойстве copyObject");
    XCTAssertTrue(_readonlyObject.strongOrRetain, "Неверно определяется strong признак свойства на тестовом свойстве readonlyObject");
}

- (void)testReadonly
{
    XCTAssertFalse(_strongObject.readonly, "Неверно определяется readonly признак свойства на тестовом свойстве strongObject");
    XCTAssertFalse(_retainObject.readonly, "Неверно определяется readonly признак свойства на тестовом свойстве retainObject");
    XCTAssertFalse(_copyObject.readonly, "Неверно определяется readonly признак свойства на тестовом свойстве copyObject");
    XCTAssertFalse(_weakObject.readonly, "Неверно определяется readonly признак свойства на тестовом свойстве weakObject");
    XCTAssertFalse(_assignObject.readonly, "Неверно определяется readonly признак свойства на тестовом свойстве assignObject");
    XCTAssertFalse(_assignUnsignedLong.readonly, "Неверно определяется readonly признак свойства на тестовом свойстве assignUnsignedLong");
    XCTAssertFalse(_assignStructure.readonly, "Неверно определяется readonly признак свойства на тестовом свойстве assignStructure");
    XCTAssertFalse(_assignClass.readonly, "Неверно определяется readonly признак свойства на тестовом свойстве assignClass");
    XCTAssertFalse(_assignSelector.readonly, "Неверно определяется readonly признак свойства на тестовом свойстве assignSelector");

    XCTAssertTrue(_readonlyObject.readonly, "Неверно определяется readonly признак свойства на тестовом свойстве readonlyObject");
    XCTAssertTrue(_readonlyLong.readonly, "Неверно определяется readonly признак свойства на тестовом свойстве readonlyLong");
    XCTAssertTrue(_readonlyStructure.readonly, "Неверно определяется readonly признак свойства на тестовом свойстве readonlyStructure");
    XCTAssertTrue(_readonlyClass.readonly, "Неверно определяется readonly признак свойства на тестовом свойстве readonlyClass");
    XCTAssertTrue(_readonlySelector.readonly, "Неверно определяется readonly признак свойства на тестовом свойстве readonlySelector");
}

- (void) testCopied
{
    XCTAssertFalse(_strongObject.copied, "Неверно определяется copy признак свойства на тестовом свойстве strongObject");
    XCTAssertFalse(_retainObject.copied, "Неверно определяется copy признак свойства на тестовом свойстве retainObject");
    XCTAssertFalse(_weakObject.copied, "Неверно определяется copy признак свойства на тестовом свойстве weakObject");
    XCTAssertFalse(_assignObject.copied, "Неверно определяется copy признак свойства на тестовом свойстве assignObject");
    XCTAssertFalse(_assignUnsignedLong.copied, "Неверно определяется copy признак свойства на тестовом свойстве assignUnsignedLong");
    XCTAssertFalse(_assignStructure.copied, "Неверно определяется copy признак свойства на тестовом свойстве assignStructure");
    XCTAssertFalse(_assignClass.copied, "Неверно определяется copy признак свойства на тестовом свойстве assignClass");
    XCTAssertFalse(_assignSelector.copied, "Неверно определяется copy признак свойства на тестовом свойстве assignSelector");
    XCTAssertFalse(_readonlyObject.copied, "Неверно определяется copy признак свойства на тестовом свойстве readonlyObject");
    XCTAssertFalse(_readonlyLong.copied, "Неверно определяется copy признак свойства на тестовом свойстве readonlyLong");
    XCTAssertFalse(_readonlyStructure.copied, "Неверно определяется copy признак свойства на тестовом свойстве readonlyStructure");
    XCTAssertFalse(_readonlyClass.copied, "Неверно определяется copy признак свойства на тестовом свойстве readonlyClass");
    XCTAssertFalse(_readonlySelector.copied, "Неверно определяется copy признак свойства на тестовом свойстве readonlySelector");

    XCTAssertTrue(_copyObject.copied, "Неверно определяется copy признак свойства на тестовом свойстве copyObject");
}

- (void) testNonAtomic
{
    XCTAssertFalse(_strongObject.nonAtomic, "Неверно определяется nonAtomic признак свойства на тестовом свойстве strongObject");
    XCTAssertFalse(_weakObject.nonAtomic, "Неверно определяется nonAtomic признак свойства на тестовом свойстве weakObject");
    XCTAssertFalse(_assignUnsignedLong.nonAtomic, "Неверно определяется nonAtomic признак свойства на тестовом свойстве assignUnsignedLong");
    XCTAssertFalse(_copyObject.nonAtomic, "Неверно определяется nonAtomic признак свойства на тестовом свойстве copyObject");

    XCTAssertTrue(_retainObject.nonAtomic, "Неверно определяется nonAtomic признак свойства на тестовом свойстве retainObject");
    XCTAssertTrue(_assignObject.nonAtomic, "Неверно определяется nonAtomic признак свойства на тестовом свойстве assignObject");
    XCTAssertTrue(_assignStructure.nonAtomic, "Неверно определяется nonAtomic признак свойства на тестовом свойстве assignStructure");
    XCTAssertTrue(_assignClass.nonAtomic, "Неверно определяется nonAtomic признак свойства на тестовом свойстве assignClass");
    XCTAssertTrue(_assignSelector.nonAtomic, "Неверно определяется nonAtomic признак свойства на тестовом свойстве assignSelector");
    XCTAssertTrue(_readonlyObject.nonAtomic, "Неверно определяется nonAtomic признак свойства на тестовом свойстве readonlyObject");
    XCTAssertTrue(_readonlyLong.nonAtomic, "Неверно определяется nonAtomic признак свойства на тестовом свойстве readonlyLong");
    XCTAssertTrue(_readonlyStructure.nonAtomic, "Неверно определяется nonAtomic признак свойства на тестовом свойстве readonlyStructure");
    XCTAssertTrue(_readonlyClass.nonAtomic, "Неверно определяется nonAtomic признак свойства на тестовом свойстве readonlyClass");
    XCTAssertTrue(_readonlySelector.nonAtomic, "Неверно определяется nonAtomic признак свойства на тестовом свойстве readonlySelector");
}

- (void) testName
{
    XCTAssertEqualObjects(_strongObject.name, @"strongObject", "Неверно определяется name на тестовом свойстве strongObject");
    XCTAssertEqualObjects(_weakObject.name, @"weakObject", "Неверно определяется name на тестовом свойстве weakObject");
    XCTAssertEqualObjects(_assignUnsignedLong.name, @"assignUnsignedLong", "Неверно определяется name на тестовом свойстве assignUnsignedLong");
}

- (void) testGetter
{
    XCTAssertEqualObjects(_strongObject.getter, @"getSO", "Неверно определяется getter на тестовом свойстве strongObject");
    XCTAssertEqualObjects(_assignSelector.getter, @"assignSelector", "Неверно определяется getter на тестовом свойстве assignSelector");
    XCTAssertEqualObjects(_readonlyLong.getter, @"readonlyLong", "Неверно определяется getter на тестовом свойстве readonlyLong");
}

- (void) testSetter
{
    XCTAssertEqualObjects(_strongObject.setter, @"setSO:", "Неверно определяется setter на тестовом свойстве strongObject");
    XCTAssertEqualObjects(_assignSelector.setter, @"setAssignSelector:", "Неверно определяется setter на тестовом свойстве assignSelector");
    XCTAssertEqualObjects(_readonlyLong.setter, @"setReadonlyLong:", "Неверно определяется setter на тестовом свойстве readonlyLong");
}

- (void) testType
{
    NSString *readonlySelectorType = [NSString stringWithCString:@encode(SEL)
                                                        encoding:NSUTF8StringEncoding];
    NSString *assignSelectorType = [NSString stringWithCString:@encode(SEL)
                                                      encoding:NSUTF8StringEncoding];
    NSString *readonlyClassType = [NSString stringWithCString:@encode(Class)
                                                     encoding:NSUTF8StringEncoding];
    NSString *assignClassType = [NSString stringWithCString:@encode(Class)
                                                   encoding:NSUTF8StringEncoding];
    NSString *readonlyStructureType = [NSString stringWithCString:@encode(TestStruct)
                                                         encoding:NSUTF8StringEncoding];
    NSString *assignStructureType = [NSString stringWithCString:@encode(TestStruct)
                                                       encoding:NSUTF8StringEncoding];
    NSString *readonlyLongType = [NSString stringWithCString:@encode(long)
                                                    encoding:NSUTF8StringEncoding];
    NSString *assignUnsignedLongType = [NSString stringWithCString:@encode(unsigned long)
                                                          encoding:NSUTF8StringEncoding];
    NSString *readonlyObjectType = [NSString stringWithCString:@encode(NSObject *)
                                                      encoding:NSUTF8StringEncoding];
    NSString *assignObjectType = [NSString stringWithCString:@encode(NSObject *)
                                                    encoding:NSUTF8StringEncoding];
    NSString *weakObjectType = [NSString stringWithCString:@encode(NSObject *)
                                                  encoding:NSUTF8StringEncoding];
    NSString *copyObjectType = [NSString stringWithCString:@encode(NSObject *)
                                                  encoding:NSUTF8StringEncoding];
    NSString *retainObjectType = [NSString stringWithCString:@encode(NSObject *)
                                                    encoding:NSUTF8StringEncoding];
    NSString *strongObjectType = [NSString stringWithCString:@encode(NSObject *)
                                                    encoding:NSUTF8StringEncoding];

    XCTAssertEqualObjects(_strongObject.type, strongObjectType,  "Неверно определяется type признак свойства на тестовом свойстве strongObject");
    XCTAssertEqualObjects(_weakObject.type, weakObjectType, "Неверно определяется type признак свойства на тестовом свойстве weakObject");
    XCTAssertEqualObjects(_assignUnsignedLong.type, assignUnsignedLongType, "Неверно определяется type признак свойства на тестовом свойстве assignUnsignedLong");
    XCTAssertEqualObjects(_copyObject.type, copyObjectType, "Неверно определяется type признак свойства на тестовом свойстве copyObject");
    XCTAssertEqualObjects(_retainObject.type, retainObjectType, "Неверно определяется type признак свойства на тестовом свойстве retainObject");
    XCTAssertEqualObjects(_assignObject.type, assignObjectType, "Неверно определяется type признак свойства на тестовом свойстве assignObject");
    XCTAssertEqualObjects(_assignStructure.type, assignStructureType, "Неверно определяется type признак свойства на тестовом свойстве assignStructure");
    XCTAssertEqualObjects(_assignClass.type, assignClassType, "Неверно определяется type признак свойства на тестовом свойстве assignClass");
    XCTAssertEqualObjects(_assignSelector.type, assignSelectorType, "Неверно определяется type признак свойства на тестовом свойстве assignSelector");
    XCTAssertEqualObjects(_readonlyObject.type, readonlyObjectType, "Неверно определяется type признак свойства на тестовом свойстве readonlyObject");
    XCTAssertEqualObjects(_readonlyLong.type, readonlyLongType, "Неверно определяется type признак свойства на тестовом свойстве readonlyLong");
    XCTAssertEqualObjects(_readonlyStructure.type, readonlyStructureType, "Неверно определяется type признак свойства на тестовом свойстве readonlyStructure");
    XCTAssertEqualObjects(_readonlyClass.type, readonlyClassType, "Неверно определяется type признак свойства на тестовом свойстве readonlyClass");
    XCTAssertEqualObjects(_readonlySelector.type, readonlySelectorType, "Неверно определяется type признак свойства на тестовом свойстве readonlySelector");

}

- (void) testTypeOfType
{
    XCTAssertEqual(_strongObject.typeOfType, ARHCCPropertyInfoObjectType,  "Неверно определяется typeOfType признак свойства на тестовом свойстве strongObject");
    XCTAssertEqual(_weakObject.typeOfType, ARHCCPropertyInfoObjectType, "Неверно определяется typeOfType признак свойства на тестовом свойстве weakObject");
    XCTAssertEqual(_copyObject.typeOfType, ARHCCPropertyInfoObjectType, "Неверно определяется typeOfType признак свойства на тестовом свойстве copyObject");
    XCTAssertEqual(_retainObject.typeOfType, ARHCCPropertyInfoObjectType, "Неверно определяется typeOfType признак свойства на тестовом свойстве retainObject");
    XCTAssertEqual(_assignObject.typeOfType, ARHCCPropertyInfoObjectType, "Неверно определяется typeOfType признак свойства на тестовом свойстве assignObject");
    XCTAssertEqual(_readonlyObject.typeOfType, ARHCCPropertyInfoObjectType, "Неверно определяется typeOfType признак свойства на тестовом свойстве readonlyObject");

    XCTAssertEqual(_assignStructure.typeOfType, ARHCCPropertyInfoStructureType, "Неверно определяется typeOfType признак свойства на тестовом свойстве assignStructure");
    XCTAssertEqual(_readonlyStructure.typeOfType, ARHCCPropertyInfoStructureType, "Неверно определяется typeOfType признак свойства на тестовом свойстве readonlyStructure");

    XCTAssertEqual(_readonlyLong.typeOfType, ARHCCPropertyInfoScalarNumberType, "Неверно определяется typeOfType признак свойства на тестовом свойстве readonlyLong");
    XCTAssertEqual(_assignUnsignedLong.typeOfType, ARHCCPropertyInfoScalarNumberType, "Неверно определяется typeOfType признак свойства на тестовом свойстве assignUnsignedLong");

    XCTAssertEqual(_assignClass.typeOfType, ARHCCPropertyInfoClassType, "Неверно определяется typeOfType признак свойства на тестовом свойстве assignClass");
    XCTAssertEqual(_readonlyClass.typeOfType, ARHCCPropertyInfoClassType, "Неверно определяется typeOfType признак свойства на тестовом свойстве readonlyClass");

    XCTAssertEqual(_assignSelector.typeOfType, ARHCCPropertyInfoSelectorType, "Неверно определяется typeOfType признак свойства на тестовом свойстве assignSelector");
    XCTAssertEqual(_readonlySelector.typeOfType, ARHCCPropertyInfoSelectorType, "Неверно определяется typeOfType признак свойства на тестовом свойстве readonlySelector");
}

@end
