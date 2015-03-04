//
// Created by Alexey Rogatkin on 21.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import "CEErrorNotification.h"
#import "ARHCCommonHandlingChain.h"
#import "IChainElementPrivate.h"

@interface ARHAbstractChainElement()<IChainElementPrivate>
@end

@implementation CEErrorNotification

- (BOOL)canProcess
{
    return self.errorPresented;
}

- (void)process
{
//    dispatch_sync (dispatch_get_main_queue(), ^
//    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kARHCHandlingChainErrorNotification
                                                            object:self.chain
                                                          userInfo:@{ @"error" : self.error }];
//    });
}

@end