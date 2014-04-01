//
//  MCNavigationBar.m
//  MCAdditions
//
//  Created by Matthew Cheok on 10/10/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import "MCNavigationBar.h"

@interface MCNavigationBar ()

@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation MCNavigationBar

static CGFloat const kDefaultColorLayerOpacity = 0.5f;
static CGFloat const kSpaceToCoverStatusBars = 20.0f;

- (void)setBarTintColor:(UIColor *)barTintColor {
    [super setBarTintColor:barTintColor];
    if (self.colorLayer == nil) {
        self.colorLayer = [CALayer layer];
        self.colorLayer.opacity = kDefaultColorLayerOpacity;
        [self.layer addSublayer:self.colorLayer];
    }
    self.colorLayer.backgroundColor = barTintColor.CGColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.colorLayer != nil) {
        self.colorLayer.frame = CGRectMake(0, 0 - kSpaceToCoverStatusBars, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + kSpaceToCoverStatusBars);

        [self.layer insertSublayer:self.colorLayer atIndex:1];
    }
}

@end

