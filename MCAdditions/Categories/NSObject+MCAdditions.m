//
//  NSObject+MCAdditions.m
//  Pods
//
//  Created by Matthew Cheok on 1/4/14.
//
//

#import "NSObject+MCAdditions.h"

@implementation NSObject (MCAdditions)

- (void)performBlock:(void (^)())block afterInterval:(NSTimeInterval)interval {
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        block();
    });
}

@end
