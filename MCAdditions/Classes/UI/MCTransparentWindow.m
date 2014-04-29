//
//  MCTransparentWindow.m
//  Pods
//
//  Created by Matthew Cheok on 28/4/14.
//
//

#import "MCTransparentWindow.h"

@implementation MCTransparentWindow

+ (instancetype)windowWithLevel:(UIWindowLevel)level {
    MCTransparentWindow *window = [[self alloc] init];
    [window setupOrientation];
    [window setWindowLevel:level];
    [window setHidden:NO];
    
    return window;
}

#pragma mark - Methods

static CGAffineTransform TransformAccountingForOrientation(UIInterfaceOrientation orientation, CGRect bounds) {
    CGAffineTransform transform = CGAffineTransformIdentity;
	switch (orientation) {
		case UIInterfaceOrientationLandscapeLeft:
            transform = CGAffineTransformRotate(transform, -M_PI / 2);
            transform = CGAffineTransformTranslate(transform, -CGRectGetWidth(bounds)/2, CGRectGetHeight(bounds)/2);
			break;
            
		case UIInterfaceOrientationLandscapeRight:
            transform = CGAffineTransformRotate(transform, M_PI / 2);
            transform = CGAffineTransformTranslate(transform, CGRectGetWidth(bounds)/2, -CGRectGetHeight(bounds)/2);
			break;
            
		case UIInterfaceOrientationPortraitUpsideDown:
            transform = CGAffineTransformRotate(transform, M_PI);
            transform = CGAffineTransformTranslate(transform, -CGRectGetWidth(bounds)/2, -CGRectGetHeight(bounds)/2);
			break;
            
		default:
            transform = CGAffineTransformTranslate(transform, CGRectGetWidth(bounds)/2, CGRectGetHeight(bounds)/2);
			break;
	}
    
    return transform;
}

- (void)setupOrientation {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
	CGRect bounds = [[UIScreen mainScreen] bounds];
	if (UIInterfaceOrientationIsLandscape(orientation)) {
		bounds.size = CGSizeMake(CGRectGetHeight(bounds), CGRectGetWidth(bounds));
	}

    self.transform = TransformAccountingForOrientation(orientation, bounds);
    self.bounds = bounds;
}

#pragma mark - UIView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	UIView *view = [super hitTest:point withEvent:event];
	return view == self ? nil : view;
}

- (void)setHidden:(BOOL)hidden {
    [self setupOrientation];
    [super setHidden:hidden];
}

@end
