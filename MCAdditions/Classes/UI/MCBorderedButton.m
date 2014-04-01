//
//  MCBorderedButton.m
//  MCAdditions
//
//  Created by Matthew Cheok on 6/2/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCBorderedButton.h"

@interface MCBorderedButton ()

@property (strong, nonatomic) CAShapeLayer *borderLayer;

@end

@implementation MCBorderedButton

+ (void)load {
	[[self appearance] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)setup {
	_borderLayer = [CAShapeLayer layer];
	_borderLayer.lineWidth = 1;
	_borderLayer.strokeColor = [UIColor blackColor].CGColor;
	_borderLayer.fillColor = nil;
	_borderLayer.actions = @{ @"strokeColor": [NSNull null] };
	[self.layer addSublayer:_borderLayer];

	self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    _selectedTintColor = [UIColor blackColor];

	[self tintColorDidChange];
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self setup];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self setup];
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	_borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:3].CGPath;
}

#pragma mark - Methods

- (void)updateState {
	UIColor *color = [self isHighlighted] ? self.selectedTintColor : self.tintColor;
	self.borderLayer.strokeColor = color.CGColor;
}

- (void)tintColorDidChange {
	[super tintColorDidChange];
	[self updateState];

	[self setTitleColor:self.tintColor forState:UIControlStateNormal];
}

- (void)setHighlighted:(BOOL)highlighted {
	[super setHighlighted:highlighted];
	[self updateState];
}

#pragma mark - Properties

- (void)setSelectedTintColor:(UIColor *)selectedTintColor {
    _selectedTintColor = selectedTintColor;

    [self setTitleColor:selectedTintColor forState:UIControlStateHighlighted];
	[self setTitleColor:selectedTintColor forState:UIControlStateSelected];
}

@end
