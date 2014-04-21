//
//  SWButton.m
//  Saleswhale
//
//  Created by Matthew Cheok on 2/4/14.
//  Copyright (c) 2014 Getting Real. All rights reserved.
//

#import "MCButton.h"

static CGFloat const kExtendedThreshold = 20;

@implementation MCButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(CGRectInset(self.bounds, -kExtendedThreshold, -kExtendedThreshold), point)) {
        return YES;
    }
    return [super pointInside:point withEvent:event];
}

@end
