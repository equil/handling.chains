//
// Created by Alexey Rogatkin on 21.05.14.
// Copyright (c) 2014 iDecide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARHCMutableDictionaryPropertiesAdapter.h"

@protocol ARHIChainContextInspector <NSObject>

- (void)inspectContext: (ARHCMutableDictionaryPropertiesAdapter *) adapter;

@end