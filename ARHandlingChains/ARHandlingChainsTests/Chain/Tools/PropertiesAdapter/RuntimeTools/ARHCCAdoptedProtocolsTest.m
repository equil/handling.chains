//
//  ARHCCAdoptedProtocolsTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 04.06.14.
//
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "ARHCCChildProtocols.h"
#import "ARHCITestParentProtocol.h"
#import "ARHCITestChildOne.h"
#import "ARHCITestChildThree.h"
#import "ARHCITestChildTwo.h"

@interface ARHCCAdoptedProtocolsTest : XCTestCase

@end

@implementation ARHCCAdoptedProtocolsTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEnumeration
{

    ARHCCChildProtocols *protocols = [[ARHCCChildProtocols alloc] initWithProtocol:@protocol(ARHCITestParentProtocol)];

    NSMutableSet *names = [[NSMutableSet alloc] initWithCapacity:3];
    for (Protocol *protocol in protocols)
    {
        NSString *name = [NSString stringWithCString:protocol_getName (protocol)
                                            encoding:NSUTF8StringEncoding];
        [names addObject:name];
    }

    XCTAssertEqual(names.count, 3, "У тестового протокола ARHCITestParendProtocol должно быть три наследника");
    XCTAssertTrue([names containsObject:NSStringFromProtocol (@protocol(ARHCITestChildOne))], "Не найден протокол ARHCITestChildOne");
    XCTAssertTrue([names containsObject:NSStringFromProtocol (@protocol(ARHCITestChildTwo))], "Не найден протокол ARHCITestChildTwo");
    XCTAssertTrue([names containsObject:NSStringFromProtocol (@protocol(ARHCITestChildThree))], "Не найден протокол ARHCITestChildThree");
}

@end
