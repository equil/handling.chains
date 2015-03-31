//
//  ARHCEnumerableWeakReferencesCollectionTest.m
//  ARHandlingChains
//
//  Created by Alexey Rogatkin on 18.06.14.
//
//

#import <XCTest/XCTest.h>
#import "ARHCEnumerableWeakReferencesCollection.h"

@interface ARHCEnumerableWeakReferencesCollectionTest : XCTestCase

@end

@implementation ARHCEnumerableWeakReferencesCollectionTest
{
    ARHCEnumerableWeakReferencesCollection *_collection1;
    ARHCEnumerableWeakReferencesCollection *_collection2;
}

- (void)setUp
{
    [super setUp];
    _collection1 = [[ARHCEnumerableWeakReferencesCollection alloc] init];
    _collection2 = [[ARHCEnumerableWeakReferencesCollection alloc] init];
}

- (void)tearDown
{
    _collection1 = nil;
    _collection2 = nil;
    [super tearDown];
}
/*
- (void)testCommonUses
{
    NSArray *templateArray = [self quickSort:
            @[
                    [[NSString alloc] initWithFormat:@"%u",
                                                     arc4random ()],
                    [[NSString alloc] initWithFormat:@"%u",
                                                     arc4random ()],
                    [[NSString alloc] initWithFormat:@"%u",
                                                     arc4random ()],
                    [[NSString alloc] initWithFormat:@"%u",
                                                     arc4random ()],
                    [[NSString alloc] initWithFormat:@"%u",
                                                     arc4random ()],
                    [[NSString alloc] initWithFormat:@"%u",
                                                     arc4random ()],
                    [[NSString alloc] initWithFormat:@"%u",
                                                     arc4random ()],
                    [[NSString alloc] initWithFormat:@"%u",
                                                     arc4random ()],
                    [[NSString alloc] initWithFormat:@"%u",
                                                     arc4random ()],
                    [[NSString alloc] initWithFormat:@"%u",
                                                     arc4random ()],
                    [[NSString alloc] initWithFormat:@"%u",
                                                     arc4random ()],
                    [[NSString alloc] initWithFormat:@"%u",
                                                     arc4random ()]
            ]];
    for (NSString *object in templateArray)
    {
        [_collection1 addObject:object];
        [_collection2 addObject:object];
    }

    NSMutableArray *callbackTestArray = [[NSMutableArray alloc] init];
    NSMutableArray *arpArrayStrong = [[NSMutableArray alloc] init];
    @autoreleasepool
    {
        NSArray *arpArray = @[
                [[NSString alloc] initWithFormat:@"%u",
                                                 arc4random ()],
                [[NSString alloc] initWithFormat:@"%u",
                                                 arc4random ()],
                [[NSString alloc] initWithFormat:@"%u",
                                                 arc4random ()],
                [[NSString alloc] initWithFormat:@"%u",
                                                 arc4random ()],
                [[NSString alloc] initWithFormat:@"%u",
                                                 arc4random ()],
                [[NSString alloc] initWithFormat:@"%u",
                                                 arc4random ()],
                [[NSString alloc] initWithFormat:@"%u",
                                                 arc4random ()],
                [[NSString alloc] initWithFormat:@"%u",
                                                 arc4random ()],
                [[NSString alloc] initWithFormat:@"%u",
                                                 arc4random ()],
                [[NSString alloc] initWithFormat:@"%u",
                                                 arc4random ()],
                [[NSString alloc] initWithFormat:@"%u",
                                                 arc4random ()],
                [[NSString alloc] initWithFormat:@"%u",
                                                 arc4random ()]
        ];
        for (NSString *object in arpArray)
        {
            NSString *str = [[NSString alloc] initWithFormat:@"%@",
                                                             object];
            [_collection1 addObject:object];
            [_collection1 onDeallocElement:object
                                        do:^
                                        {
                                            [callbackTestArray addObject:str];
                                        }];
            [_collection2 addObject:object];
            [arpArrayStrong addObject:[[NSString alloc] initWithFormat:@"%@", object]];
        }
    }

    NSMutableArray *array1 = [[NSMutableArray alloc] initWithCapacity:templateArray.count];
    NSMutableArray *array2 = [[NSMutableArray alloc] initWithCapacity:templateArray.count];

    for (NSObject *element in _collection1)
    {
        [array1 addObject:element];
    }
    for (NSObject *element in _collection2)
    {
        [array2 addObject:element];
    }

    XCTAssertEqualObjects(templateArray, [self quickSort:array1], "Неверное поведение у объекта типа ARHCEnumerableWeakReferencesCollection");
    XCTAssertEqualObjects(templateArray, [self quickSort:array2], "Неверное поведение у объекта типа ARHCEnumerableWeakReferencesCollection");
    XCTAssertEqualObjects([self quickSort:callbackTestArray], [self quickSort:arpArrayStrong], "Неверное поведение у объекта типа ARHCEnumerableWeakReferencesCollection");
}

- (NSArray *)quickSort:(NSArray *)unsortedArray
{
    NSInteger numberOfElements = [unsortedArray count];
    if (numberOfElements <= 1)
    {
        return unsortedArray;
    }

    NSNumber *pivotValue = [unsortedArray objectAtIndex:numberOfElements / 2];

    NSMutableArray *lessArray = [[NSMutableArray alloc] initWithCapacity:numberOfElements];
    NSMutableArray *moreArray = [[NSMutableArray alloc] initWithCapacity:numberOfElements];

    for (NSNumber *value in unsortedArray)
    {
        if ([value floatValue] < [pivotValue floatValue])
        {
            [lessArray addObject:value];
        }
        else if ([value floatValue] > [pivotValue floatValue])
        {
            [moreArray addObject:value];
        }
    }

    NSMutableArray *sortedArray = [[NSMutableArray alloc] initWithCapacity:numberOfElements];
    [sortedArray addObjectsFromArray:[self quickSort:lessArray]];
    [sortedArray addObject:pivotValue];
    [sortedArray addObjectsFromArray:[self quickSort:moreArray]];

    return [sortedArray copy];
}

*/
@end
