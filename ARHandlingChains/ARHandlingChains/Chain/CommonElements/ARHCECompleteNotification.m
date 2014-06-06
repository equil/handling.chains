//
// Created by Alexey Rogatkin on 22.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "ARHCECompleteNotification.h"

@implementation ARHCECompleteNotification
{
}

- (BOOL)canProcess
{
    return !self.errorPresented;
}

- (void)process
{
    dispatch_async (dispatch_get_main_queue(), ^
    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kJCFacadeJaCartaChainCompleteNotification
//                                                            object:self.chainClass];
    });
}

@end