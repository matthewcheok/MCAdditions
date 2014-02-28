//
//  UIView+MCAdditions.m
//  GuitarScript
//
//  Created by Matthew Cheok on 5/12/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import "UIView+MCAdditions.h"

@implementation UIView (MCAdditions)

#pragma mark - Utility

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

#pragma mark - Animation

- (void)performAnimationWithStyle:(MCViewAnimationStyle)style duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion {
	switch (style) {
		case MCViewAnimationStylePop:
			[self performAnimationInPopStyleWithDuration:duration delay:delay completion:completion];
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

@end
