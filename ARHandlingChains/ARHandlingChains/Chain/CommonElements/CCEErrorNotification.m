//
// Created by Alexey Rogatkin on 21.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "CCEErrorNotification.h"

@implementation CCEErrorNotification

- (BOOL)canProcess
{
    return self.errorPresented;
}

- (void)process
{
    dispatch_async (dispatch_get_main_queue(), ^
    {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kJCFacadeErrorInJaCartaChainNotification
//                                                            object:self.error.chainClass
//                                                          userInfo:@{ @"error" : self.error }];
    });
}

@end