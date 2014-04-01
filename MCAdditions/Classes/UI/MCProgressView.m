//
//  MCProgressView.m
//  MCAdditions
//
//  Created by Matthew Cheok on 7/2/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCProgressView.h"
#import "MCObserver.h"

@interface MCProgressView ()

@property (strong, nonatomic) CAShapeLayer *strokeLayer;
@property (strong, nonatomic) CAShapeLayer *fillLayer;

@property (strong, nonatomic) CADisplayLink *displayLink;
@property (strong, nonatomic) MCObserver *progressObserver;

@end

@implementation MCProgressView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		_strokeLayer = [CAShapeLayer layer];
		_strokeLayer.fillColor = nil;
		_strokeLayer.lineWidth = 1;
		_strokeLayer.actions = @{ @"strokeStart": [NSNull null], @"strokeEnd": [NSNull null] };
		[self.layer addSublayer:_strokeLayer];

		_fillLayer = [CAShapeLayer layer];
		_fillLayer.strokeColor = nil;
		[self.layer addSublayer:_fillLayer];

		_imageView = [[UIImageView alloc] init];
		[self addSubview:_imageView];

		[self updateTintColor];

		_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateProgress)];
		[_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
	}
	return self;
}

- (void)dealloc {
	[_displayLink invalidate];
}

- (void)layoutSubviews {
	CGRect bounds  = self.bounds;
	CGFloat width  = CGRectGetWidth(bounds);
	CGFloat height = CGRectGetHeight(bounds);
	CGFloat radius = floor(MIN(width, height) / 2.0);

	UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width / 2.0, height / 2.0) radius:radius startAngle:-M_PI / 2 endAngle:M_PI * 3 / 2 clockwise:YES];
	self.strokeLayer.path = path.CGPath;
	self.strokeLayer.strokeEnd = 0;

	self.imageView.frame = CGRectInset(bounds, 5, 5);
}

- (void)tintColorDidChange {
	[super tintColorDidChange];
	[self updateTintColor];
}

#pragma mark - Properties

- (void)setValue:(CGFloat)value {
	_value = MIN(MAX(value, 0), 1);
	[self updateTintColor];
}

- (void)setProgress:(NSProgress *)progress {
	self.progressObserver = nil;

	_progress = progress;

    __weak typeof(self) weakSelf = self;    
	self.progressObserver = [MCObserver observerWithObject:progress keyPath:@"fractionCompleted" activation:^(NSDictionary *change) {
        dispatch_async(dispatch_get_main_queue(), ^{
            typeof(self) strongSelf = weakSelf;
            strongSelf.value = strongSelf.progress.fractionCompleted;
        });
    }];
}

#pragma mark - Methods

- (void)updateTintColor {
	UIColor *color = self.tintColor;
	if (_value >= 1 && self.completedTintColor) {
		color = self.completedTintColor;
	}
	self.imageView.tintColor = color;
	self.strokeLayer.strokeColor = color.CGColor;
	self.fillLayer.fillColor = color.CGColor;
}

- (void)updateProgress {
	if (self.imageView.image) {
		self.fillLayer.path = nil;
		self.strokeLayer.strokeEnd = self.value;
	}
	else {
		CGRect bounds  = self.bounds;
		CGFloat width  = CGRectGetWidth(bounds);
		CGFloat height = CGRectGetHeight(bounds);
		CGFloat radius = MAX(floor(MIN(width, height) / 2.0) - 2, 0);

		CGFloat startAngle = -M_PI / 2;
		CGFloat endAngle = startAngle + self.value * 2 * M_PI;
		CGPoint center = CGPointMake(width / 2, height / 2);

		UIBezierPath *path = [UIBezierPath bezierPath];
		[path moveToPoint:center];
		[path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];

		self.fillLayer.path = path.CGPath;
		self.strokeLayer.strokeEnd = 1;
	}
}

@end
