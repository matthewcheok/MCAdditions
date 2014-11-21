//
//  UIView+MCAdditions.h
//  GuitarScript
//
//  Created by Matthew Cheok on 5/12/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MCViewAnimationStyle) {
    MCViewAnimationStyleNone = 0,
    MCViewAnimationStylePop,
    MCViewAnimationStylePopInside,
    MCViewAnimationStyleMorph
};

typedef NS_ENUM(NSInteger, MCViewShakeDirection) {
    MCViewShakeDirectionHorizontal = 0,
    MCViewShakeDirectionVertical
};

@interface UIView (MCAdditions)

#pragma mark - Snapshot

- (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)updates;

#pragma mark - Utility

- (NSArray *)gestureRecognizersOfKindOfClass:(Class)class;
- (NSArray *)subviewsOfKindOfClass:(Class)class;
- (id)superviewOfKindOfClass:(Class)class;
- (UIViewController *)viewController;

#pragma mark - Animation

+ (void)animateWithKeyboardNotification:(NSNotification *)notification delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

- (void)performAnimationWithStyle:(MCViewAnimationStyle)style duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion;

- (void)performShakeAnimationWithDirection:(MCViewShakeDirection)direction numberOfTimes:(NSUInteger)times duration:(NSTimeInterval)duration delta:(CGFloat)delta completion:(void (^)(BOOL finished))completion;

- (void)performHorizontalShakeAnimationWithCompletion:(void (^)(BOOL finished))completion;

@end

@interface UIViewController (MCAdditions_UIView)

- (void)presentViewController:(UIViewController *)viewController inNavigationControllerWithTransitioningDelegate:(id<UIViewControllerTransitioningDelegate>)delegate animated:(BOOL)animated completion:(void (^)(void))completion;

@end
