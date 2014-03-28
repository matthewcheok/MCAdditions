//
//  MCObserver.m
//  MCAdditions
//
//  Created by Matthew Cheok on 17/1/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCObserver.h"

@interface MCObserver ()

@property (weak, nonatomic) id object;
@property (copy, nonatomic) NSString *keyPath;
@property (copy, nonatomic) MCObserverActivationBlock activation;

@end

@implementation MCObserver

+ (instancetype)observerWithObject:(id)object keyPath:(NSString *)keyPath activation:(MCObserverActivationBlock)activation {
    return [[self alloc] initWithObject:object keyPath:keyPath activation:activation];
}

- (instancetype)initWithObject:(id)object keyPath:(NSString *)keyPath activation:(MCObserverActivationBlock)activation {
    self = [super init];
    if (self) {
        _object   = object;
        _keyPath  = keyPath;
        _activation = [activation copy];
        
        [_object addObserver:self forKeyPath:_keyPath options:0 context:(__bridge void *)(self)];
    }
    return self;
}

- (void)dealloc {
    [_object removeObserver:self forKeyPath:_keyPath context:(__bridge void *)(self)];
}

#pragma mark - Methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == (__bridge void *)(self) &&
        object == self.object &&
        [keyPath isEqualToString:self.keyPath]) {
        
        if (self.activation) {
            self.activation(change);
        }
    }
}



@end
