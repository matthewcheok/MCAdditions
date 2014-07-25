//
//  NSArray+MCAdditions.h
//  Saleswhale
//
//  Created by Matthew Cheok on 23/4/14.
//  Copyright (c) 2014 Getting Real. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MCAdditions)

- (instancetype)arrayByInsertingObject:(id)object atIndex:(NSUInteger)index;

- (instancetype)arrayByRemovingObjectAtIndex:(NSUInteger)index;
- (instancetype)arrayByRemovingObject:(id)object;

- (instancetype)arrayByReplacingObjectAtIndex:(NSUInteger)index withObject:(id)object;
- (instancetype)arrayByReplacingObject:(id)oldObject withObject:(id)object;;

@end
