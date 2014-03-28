//
//  MCObserver.h
//  MCAdditionss
//
//  Created by Matthew Cheok on 17/1/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MCObserverActivationBlock)(NSDictionary *change);

@interface MCObserver : NSObject

@property (weak, nonatomic, readonly) id object;
@property (copy, nonatomic, readonly) NSString *keyPath;
@property (copy, nonatomic, readonly) MCObserverActivationBlock activation;

+ (instancetype)observerWithObject:(id)object keyPath:(NSString *)keyPath activation:(MCObserverActivationBlock)activation;
- (instancetype)initWithObject:(id)object keyPath:(NSString *)keyPath activation:(MCObserverActivationBlock)activation;

@end
