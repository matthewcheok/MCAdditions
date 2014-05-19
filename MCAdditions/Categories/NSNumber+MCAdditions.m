//
//  NSNumber+MCAdditions.m
//  Pods
//
//  Created by Matthew Cheok on 19/5/14.
//
//

#import "NSNumber+MCAdditions.h"

@implementation NSNumber (MCAdditions)

- (void)times:(void (^)(void))block {
    for (int i = 0; i < self.integerValue; i++)
        block();
}

- (void)timesWithIndex:(void (^)(NSUInteger index))block {
    for (int i = 0; i < self.integerValue; i++)
        block(i);
}

- (void)upto:(int)number do:(void (^)(NSInteger index))block {
    for (NSInteger i = self.integerValue; i <= number; i++)
        block(i);
}

- (void)downto:(int)number do:(void (^)(NSInteger index))block {
    for (NSInteger i = self.integerValue; i >= number; i--)
        block(i);
}

@end
