//
//  MCDelegator.h
//  GuitarScript
//
//  Created by Matthew Cheok on 6/12/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCDelegator : NSProxy

- (id)init;
- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;
- (NSUInteger)count;

@end
