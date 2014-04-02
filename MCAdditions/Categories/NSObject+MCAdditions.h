//
//  NSObject+MCAdditions.h
//  Pods
//
//  Created by Matthew Cheok on 1/4/14.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (MCAdditions)

- (void)performBlock:(void (^)())block afterInterval:(NSTimeInterval)interval;

@end
