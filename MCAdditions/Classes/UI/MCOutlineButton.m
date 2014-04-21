//
//  MCOutlineButton.m
//  CustomControls
//
//  Created by Matthew Cheok on 4/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCOutlineButton.h"

@interface MCOutlineButton ()

@property (strong, nonatomic) CAShapeLayer *outlineLayer;
@property (strong, nonatomic) UIImageView *iconImageView;

@end

@implementation MCOutlineButton

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self setup];
	}
	return self;
}

- (void)awakeFromNib {
	[self setup];
}

- (void)setup {
    _outlineLayer = [CAShapeLayer layer];
    [self.layer insertSublayer:_outlineLayer atIndex:0];

    _secondaryColor = [UIColor blackColor];
    
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_iconImageView];
    
    [self tintColorDidChange];
    [self setImage:self.imageView.image forState:UIControlStateNormal];
}

#pragma mark - UIButton

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.iconImageView.image = image;
}

#pragma mark - UIControl

- (void)__update {
    if ([self isSelected] || [self isHighlighted]) {
        self.outlineLayer.fillColor = self.tintColor.CGColor;
        self.iconImageView.tintColor = self.secondaryColor;
    }
    else {
        self.outlineLayer.fillColor = nil;
        self.iconImageView.tintColor = nil;
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self __update];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self __update];
}

#pragma mark - UIView

- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    self.outlineLayer.strokeColor = self.tintColor.CGColor;
    [self __update];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat radius = floorf(MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))/2);
    self.outlineLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius].CGPath;
    
    self.iconImageView.frame = self.bounds;
    self.imageView.hidden = YES;
}

@end
