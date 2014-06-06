//
//  CChildProtocolsTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 04.06.14.
//
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "CChildProtocols.h"
#import "ITestParentProtocol.h"
#import "ITestChildOne.h"
#import "ITestChildThree.h"
#import "ITestChildTwo.h"

@interface CChildProtocolsTest : XCTestCase

@end

@implementation CChildProtocolsTest

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

    CChildProtocols *protocols = [[CChildProtocols alloc] initWithProtocol:@protocol(ITestParentProtocol)];

    NSMutableSet *names = [[NSMutableSet alloc] initWithCapacity:3];
    for (Protocol *protocol in protocols)
    {
        NSString *name = [NSString stringWithCString:protocol_getName (protocol)
                                            encoding:NSUTF8StringEncoding];
        [names addObject:name];
    }

    XCTAssertEqual(names.count, 3, "У тестового протокола ARHCITestParendProtocol должно быть три наследника");
    XCTAssertTrue([names containsObject:NSStringFromProtocol (@protocol(ITestChildOne))], "Не найден протокол ITestChildOne");
    XCTAssertTrue([names containsObject:NSStringFromProtocol (@protocol(ITestChildTwo))], "Не найден протокол ITestChildTwo");
    XCTAssertTrue([names containsObject:NSStringFromProtocol (@protocol(ITestChildThree))], "Не найден протокол ITestChildThree");
}

@end
