#import "UIResponder+MCAdditions.h"

static __weak id __currentFirstResponder;

@implementation UIResponder (MCAdditions)

+ (id)currentFirstResponder {
    __currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(__findFirstResponder:) to:nil from:nil forEvent:nil];
    return __currentFirstResponder;
}

- (void)__findFirstResponder:(id)sender {
   __currentFirstResponder = self;
}

@end
