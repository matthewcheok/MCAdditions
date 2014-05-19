//
//  NSNumber+MCAdditions.h
//  Pods
//
//  Created by Matthew Cheok on 19/5/14.
//
//

#import <Foundation/Foundation.h>

@interface NSNumber (MCAdditions)

- (void)times:(void (^)(void))block;
- (void)timesWithIndex:(void (^)(NSUInteger index))block;
- (void)upto:(int)number do:(void (^)(NSInteger index))block;
- (void)downto:(int)number do:(void (^)(NSInteger index))block;

@end
