//
// Created by Alexey Rogatkin on 22.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "CECompleteNotification.h"
#import "ARHCHandlingChain.h"

@implementation CECompleteNotification
{
}

- (BOOL)canProcess
{
    return [super canProcess];
}

- (void)process
{
    dispatch_async (dispatch_get_main_queue(), ^
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kARHCHandlingChainCompleteNotification
                                                            object:self.chainClass];
    });
}

@end