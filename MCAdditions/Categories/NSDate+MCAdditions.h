//
//  NSDate+MCAdditions.h
//  Pods
//
//  Created by Matthew Cheok on 18/3/14.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (MCAdditions)

+ (NSDate *)dateFromString:(NSString *)string;
- (NSString *)stringFromDate;

@end
