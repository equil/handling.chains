//
// Created by Alexey Rogatkin on 22.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHCHandlingChain.h"
#import "ARHAbstractChainElement.h"

NSString *const kARHCHandlingChainCompleteNotification = @"ARHCCompleteNotification";
NSString *const kARHCHandlingChainErrorNotification = @"ARHCErrorNotification";

@implementation ARHCHandlingChain
{
}

#pragma mark - Initialization

- (id)initWithElementsNames:(NSArray *)elementsNames
{
    NSArray *elements = [self prepareElementsByNames:elementsNames];
    return [super initWithElements:elements];
}

- (id)initWithElementsClasses:(NSArray *)elementsClasses
{
    NSArray *elements = [self prepareElementsByClasses:elementsClasses];
    return [super initWithElements:elements];
}

#pragma mark - Public interface observing

- (void)registerCompleteObserver:(id)observer
                        selector:(SEL)selector
{
    [[NSNotificationCenter defaultCenter] addObserver:observer
                                             selector:selector
                                                 name:kARHCHandlingChainCompleteNotification
                                               object:[self class]];
}

- (void)registerErrorObserver:(id)observer
                     selector:(SEL)selector
{
    [[NSNotificationCenter defaultCenter] addObserver:observer
                                             selector:selector
                                                 name:kARHCHandlingChainErrorNotification
                                               object:[self class]];
}

- (void)removeCompleteObserver:(id)observer
{
    [[NSNotificationCenter defaultCenter] removeObserver:observer
                                                    name:kARHCHandlingChainCompleteNotification
                                                  object:[self class]];
}

- (void)removeErrorObserver:(id)observer
{
    [[NSNotificationCenter defaultCenter] removeObserver:observer
                                                    name:kARHCHandlingChainErrorNotification
                                                  object:[self class]];
}

#pragma mark - Util methods

- (NSArray *)prepareElementsByNames:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSString *className in array)
    {
        Class elementClass = NSClassFromString (className);
        if (elementClass == nil)
        {
            elementClass = NSClassFromString ([NSString stringWithFormat:@"CJCCE%@",
                                                                         className]);
        }
        ARHAbstractChainElement *element = [self instantiateElement:elementClass];
        if (element != nil)
        {
            NSLog(@"Element %@/CJCCE%@ added to chain", className, className);
            [result addObject:element];
        } else {
            NSLog(@"Can't instantiate element %@/CJCCE%@", className, className);
        }
    }
    return result;
}

- (NSArray *)prepareElementsByClasses:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (Class class in array)
    {
        ARHAbstractChainElement *element = [self instantiateElement:class];
        if (element != nil)
        {
            [result addObject:element];
        }
    }
    return result;
}

- (ARHAbstractChainElement *)instantiateElement:(Class)elementClass
{
    ARHAbstractChainElement *result = nil;
    if (elementClass != nil && [elementClass isSubclassOfClass:[ARHAbstractChainElement class]])
    {
        result = [[elementClass alloc] init];
        result.chainClass = [self class];
    }
    return result;
}

@end