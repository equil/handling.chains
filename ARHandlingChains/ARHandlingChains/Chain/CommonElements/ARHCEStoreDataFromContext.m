//
// Created by Alexey Rogatkin on 21.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHCEStoreDataFromContext.h"
#import "ARHIChainContextInspector.h"

@implementation ARHCEStoreDataFromContext
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