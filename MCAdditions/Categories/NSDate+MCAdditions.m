//
//  NSDate+MCAdditions.m
//  Pods
//
//  Created by Matthew Cheok on 18/3/14.
//
//

#import "NSDate+MCAdditions.h"
#import <ISO8601DateFormatter.h>

@implementation NSDate (MCAdditions)

static ISO8601DateFormatter *_formatter = nil;

+ (void)load {
    static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
        _formatter = [[ISO8601DateFormatter alloc] init];
        _formatter.includeTime = YES;
    });
}

+ (NSDate *)dateFromString:(NSString *)string {
    return [_formatter dateFromString:string];
}

- (NSString *)stringFromDate {
    return [_formatter stringFromDate:self];
}

@end
