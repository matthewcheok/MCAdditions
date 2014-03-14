//
//  NSString+MCAdditions.m
//  Pods
//
//  Created by Matthew Cheok on 14/3/14.
//
//

#import "NSString+MCAdditions.h"
#import <NSRange+Conventional.h>

@implementation NSString (MCAdditions)

- (BOOL)isValidEmailAddress {
    NSRange range = NSRangeMake(0, [self length]);
    NSDataDetector *detector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:nil];
    NSTextCheckingResult *result = [[detector matchesInString:self options:0 range:range] firstObject];
    if (result && NSRangeEqualToRange(range, result.range)) {
        if([result.URL.absoluteString rangeOfString:@"mailto:"].location != NSNotFound) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isValidPhoneNumber {
    NSRange range = NSRangeMake(0, [self length]);
    NSDataDetector *detector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypePhoneNumber error:nil];
    NSTextCheckingResult *result = [[detector matchesInString:self options:0 range:range] firstObject];
    if (result && NSRangeEqualToRange(range, result.range)) {
        return YES;
    }
    return NO;
}

@end
