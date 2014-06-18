//
// Created by Alexey Rogatkin on 21.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHCEInspectContextChainElement.h"

@implementation ARHCEInspectContextChainElement
{
}

- (BOOL)canProcess
{
    return [super canProcess] && self.inspectorPresented;
}

- (void)process
{
    [(id<ARHIChainContextInspector>)self.inspector inspectContext:self.context];
}

@end