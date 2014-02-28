//
//  MCDelegator.m
//  GuitarScript
//
//  Created by Matthew Cheok on 6/12/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import "MCDelegator.h"

@implementation MCDelegator {
    NSHashTable *_delegates;
}

- (id)init {
    _delegates = [NSHashTable weakObjectsHashTable];
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    for (id delegate in _delegates) {
        NSMethodSignature *signature =
            [[delegate class] instanceMethodSignatureForSelector:sel];
        if (signature) {
            return signature;
        }
    }
    return [NSMethodSignature signatureWithObjCTypes:"@@"];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    for (id delegate in [_delegates allObjects]) {
        if ([delegate respondsToSelector:[invocation selector]]) {
            [invocation invokeWithTarget:delegate];
        }
    }
}

#pragma mark - Methods

- (void)addDelegate:(id)delegate {
    [_delegates addObject:delegate];
}

- (void)removeDelegate:(id)delegate {
    if ([_delegates containsObject:delegate]) {
        [_delegates removeObject:delegate];
    }
}

- (NSUInteger)count {
    return [_delegates count];
}

@end
