//
//  NSString+MCAdditions.h
//  Pods
//
//  Created by Matthew Cheok on 14/3/14.
//
//

#import <Foundation/Foundation.h>

@interface NSString (MCAdditions)

#pragma mark - Convenience

- (BOOL)isNotEmpty;

#pragma mark - Validation

- (BOOL)isValidEmailAddress;
- (BOOL)isValidPhoneNumber;

@end
