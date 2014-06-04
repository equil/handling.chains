//
// Created by Alexey Rogatkin on 21.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARHCCMutableDictionaryPropertiesAdapter.h"

@protocol IChainContextInspector <NSObject>

- (void)inspectContext: (ARHCCMutableDictionaryPropertiesAdapter *) adapter;

@end