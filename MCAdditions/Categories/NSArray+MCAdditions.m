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
    if (index >= [self count]) {
        return self;
    }

    NSMutableArray *array = [self mutableCopy];
    [array removeObjectAtIndex:index];
    return [array copy];
}

- (instancetype)arrayByRemovingObject:(id)object {
    NSMutableArray *array = [self mutableCopy];
    [array removeObject:object];
    return [array copy];
}

- (instancetype)arrayByReplacingObjectAtIndex:(NSUInteger)index withObject:(id)object {
    NSMutableArray *array = [self mutableCopy];
    [array replaceObjectAtIndex:index withObject:object];
    return [array copy];
}

- (instancetype)arrayByReplacingObject:(id)oldObject withObject:(id)object {
    NSMutableArray *array = [self mutableCopy];
    NSUInteger index = [array indexOfObject:oldObject];
    if (index != NSNotFound) {
        [array replaceObjectAtIndex:index withObject:object];
    }
    return [array copy];
}

@end
