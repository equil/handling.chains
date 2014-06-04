//
// Created by Alexey Rogatkin on 21.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "CCEStoreDataFromContext.h"
#import "IChainContextInspector.h"

@implementation CCEStoreDataFromContext
{
}

- (BOOL)canProcess
{
    return !self.errorPresented && self.inspectorPresented;
}

- (void)process
{
    [(id<IChainContextInspector>)self.inspector.weakReference inspectContext:self.context];
}

@end