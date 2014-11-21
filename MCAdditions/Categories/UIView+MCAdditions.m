//
//  UIView+MCAdditions.m
//  GuitarScript
//
//  Created by Matthew Cheok on 5/12/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import "UIView+MCAdditions.h"
#import "NSObject+MCAdditions.h"

@implementation UIView (MCAdditions)

#pragma mark - Snapshot

- (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)updates {
	UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
	[self drawViewHierarchyInRect:self.bounds afterScreenUpdates:updates];

	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return image;
}

#pragma mark - Utility

- (NSArray *)gestureRecognizersOfKindOfClass:(Class)class {
	NSMutableArray *recognizers = [NSMutableArray array];
	for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
		if ([recognizer isKindOfClass:class]) {
			[recognizers addObject:recognizer];
		}
	}

	for (UIView *view in self.subviews) {
		for (UIGestureRecognizer *recognizer in view.gestureRecognizers) {
			if ([recognizer isKindOfClass:class]) {
				[recognizers addObject:recognizer];
			}
		}

		// traverse further down subviews
		NSArray *recognizersOfSubviews = [view gestureRecognizersOfKindOfClass:class];
		[recognizers addObjectsFromArray:recognizersOfSubviews];
	}

	return recognizers;
}

- (NSArray *)subviewsOfKindOfClass:(Class)class {
	NSMutableArray *subviews = [NSMutableArray array];
	for (UIView *view in self.subviews) {
		if ([view isKindOfClass:class]) {
			[subviews addObject:view];
		}

		// traverse further down subviews
		NSArray *subviewsOfView = [view subviewsOfKindOfClass:class];
		[subviews addObjectsFromArray:subviewsOfView];
	}

	return subviews;
}

- (id)superviewOfKindOfClass:(Class)class {
	UIView *superview = [self superview];
	while (![superview isKindOfClass:class] && [superview superview] != nil)
		superview = [superview superview];
	if ([superview isKindOfClass:class]) {
		return superview;
	}
	return nil;
}

- (UIViewController *)viewController {
    id responder = self;
    while (responder != nil && ![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
    }
    
    return responder;
}

#pragma mark - Animation

+ (void)animateWithKeyboardNotification:(NSNotification *)notification delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion {
	NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16;

	[UIView animateWithDuration:duration delay:0 options:options | option animations:animations completion:completion];
}

- (void)performAnimationWithStyle:(MCViewAnimationStyle)style duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion {
	switch (style) {
		case MCViewAnimationStylePop:
			[self performAnimationInPopStyleWithDuration:duration delay:delay completion:completion];
			break;
            
        case MCViewAnimationStylePopInside:
            [self performAnimationInPopInsideStyleWithDuration:duration delay:delay completion:completion];
            break;

		case MCViewAnimationStyleMorph:
			[self performAnimationInMorphStyleWithDuration:duration delay:delay completion:completion];
			break;

		default:
			break;
	}
}

- (void)performAnimationInPopStyleWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion {
	self.transform = CGAffineTransformIdentity;
	[UIView animateKeyframesWithDuration:duration delay:delay options:0 animations: ^{
	    [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
	        self.transform = CGAffineTransformMakeScale(1.2, 1.2);
		}];
	    [UIView addKeyframeWithRelativeStartTime:1 / 3.0 relativeDuration:1 / 3.0 animations: ^{
	        self.transform = CGAffineTransformMakeScale(0.9, 0.9);
		}];
	    [UIView addKeyframeWithRelativeStartTime:2 / 3.0 relativeDuration:1 / 3.0 animations: ^{
	        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
		}];
	} completion: ^(BOOL finished) {
	    if (completion) {
	        completion(finished);
		}
	}];
}

- (void)performAnimationInPopInsideStyleWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion {
    self.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:duration delay:delay options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 / 2.0 relativeDuration:1 / 2.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:1 / 2.0 relativeDuration:1 / 2.0 animations: ^{
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion: ^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)performAnimationInMorphStyleWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion {
	self.transform = CGAffineTransformIdentity;
	[UIView animateKeyframesWithDuration:duration delay:delay options:0 animations: ^{
	    [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 4.0 animations: ^{
	        self.transform = CGAffineTransformMakeScale(1.0, 1.2);
		}];
	    [UIView addKeyframeWithRelativeStartTime:1 / 4.0 relativeDuration:1 / 4.0 animations: ^{
	        self.transform = CGAffineTransformMakeScale(1.2, 0.9);
		}];
	    [UIView addKeyframeWithRelativeStartTime:2 / 4.0 relativeDuration:1 / 4.0 animations: ^{
	        self.transform = CGAffineTransformMakeScale(0.9, 0.9);
		}];
	    [UIView addKeyframeWithRelativeStartTime:3 / 4.0 relativeDuration:1 / 4.0 animations: ^{
	        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
		}];
	} completion: ^(BOOL finished) {
	    if (completion) {
	        completion(finished);
		}
	}];
}

- (void)performShakeAnimationWithDirection:(MCViewShakeDirection)direction numberOfTimes:(NSUInteger)times duration:(NSTimeInterval)duration delta:(CGFloat)delta completion:(void (^)(BOOL finished))completion {
	__weak typeof(self) weakSelf = self;

	[UIView animateWithDuration:duration delay:0 options:0 animations: ^{
	    typeof(self) strongSelf = weakSelf;
	    strongSelf.transform = (direction == MCViewShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta, 0) : CGAffineTransformMakeTranslation(0, delta);
	} completion: ^(BOOL finished) {
	    if (times <= 1) {
	        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations: ^{
	            typeof(self) strongSelf = weakSelf;
	            strongSelf.transform = CGAffineTransformIdentity;
			} completion: ^(BOOL finished) {
	            if (completion) {
	                completion(finished);
				}
			}];
		}
	    else {
	        typeof(self) strongSelf = weakSelf;
	        [strongSelf performShakeAnimationWithDirection:direction numberOfTimes:times - 1 duration:duration delta:-delta completion:completion];
		}
	}];
}

- (void)performHorizontalShakeAnimationWithCompletion:(void (^)(BOOL finished))completion {
	[self performShakeAnimationWithDirection:MCViewShakeDirectionHorizontal numberOfTimes:10 duration:0.04 delta:5 completion:completion];
}

@end

@implementation UIViewController (MCAdditions_UIView)

- (void)presentViewController:(UIViewController *)viewController inNavigationControllerWithTransitioningDelegate:(id <UIViewControllerTransitioningDelegate> )delegate animated:(BOOL)animated completion:(void (^)(void))completion {
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
	navController.transitioningDelegate = delegate;

	__weak typeof(self) weakSelf = self;
	[self performBlock: ^{
	    typeof(self) strongSelf = weakSelf;
	    [strongSelf presentViewController:navController animated:animated completion:completion];
	} afterInterval:0];
}

@end
