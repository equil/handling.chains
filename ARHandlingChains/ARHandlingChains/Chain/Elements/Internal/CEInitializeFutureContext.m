//
// Created by Alexey Rogatkin on 16.06.14.
//

#import "CEInitializeFutureContext.h"

@implementation CEInitializeFutureContext

- (BOOL)canProcess
{
    return self.futureContextPresented;
}

- (void)process
{
    CFutureContext *context = self.futureContext;
    self.futureContext = nil;
    [context set:self.context];
}

@end