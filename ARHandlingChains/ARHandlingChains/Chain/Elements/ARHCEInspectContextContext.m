//
// Created by Alexey Rogatkin on 21.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHCEInspectContextContext.h"

@implementation ARHCEInspectContextContext
{
}

- (BOOL)canProcess
{
    return !self.errorPresented && self.inspectorPresented;
}

- (void)process
{
    [(id<ARHIChainContextInspector>)self.inspector inspectContext:self.context];
}

@end