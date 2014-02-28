//
//  NSURL+MCAdditions.m
//  GuitarScript
//
//  Created by Matthew Cheok on 11/12/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import "NSURL+MCAdditions.h"

@implementation NSURL (MCAdditions)

- (BOOL)isEqualToFileURL:(NSURL *)fileURL {
	NSAssert([self isFileURL], @"receiver must be a fileURL");
	NSAssert([fileURL isFileURL], @"target must be a fileURL");
    
	if ([self isEqual:fileURL]) {
		return YES;
	} else {
		NSError *error = nil;
		id resourceIdentifier1 = nil;
		id resourceIdentifier2 = nil;
        
		if (![self getResourceValue:&resourceIdentifier1 forKey:NSURLFileResourceIdentifierKey error:&error]) {
			@throw [NSException exceptionWithName:@"ResouceUnavailableException" reason:error.localizedDescription userInfo:nil];
		}
        
		if (![fileURL getResourceValue:&resourceIdentifier2 forKey:NSURLFileResourceIdentifierKey error:&error]) {
			@throw [NSException exceptionWithName:@"ResouceUnavailableException" reason:error.localizedDescription userInfo:nil];
		}
        
		return [resourceIdentifier1 isEqual:resourceIdentifier2];
	}
}

@end
