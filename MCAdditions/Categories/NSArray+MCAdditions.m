//
//  NSArray+MCAdditions.m
//  Saleswhale
//
//  Created by Matthew Cheok on 23/4/14.
//  Copyright (c) 2014 Getting Real. All rights reserved.
//

#import "NSArray+MCAdditions.h"

@implementation NSArray (MCAdditions)

- (instancetype)arrayByInsertingObject:(id)object atIndex:(NSUInteger)index {
    NSMutableArray *array = [self mutableCopy];
    [array insertObject:object atIndex:index];
    return [array copy];
}

- (instancetype)arrayByRemovingObjectAtIndex:(NSUInteger)index {
    NSMutableArray *array = [self mutableCopy];
    [array removeObjectAtIndex:index];
    return [array copy];
}

@end
