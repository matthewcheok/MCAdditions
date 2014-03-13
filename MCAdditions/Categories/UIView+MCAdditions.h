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
    MCViewAnimationStyleMorph
};

@interface UIView (MCAdditions)

#pragma mark - Snapshot

- (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)updates;

#pragma mark - Utility

- (NSArray *)subviewsOfKindOfClass:(Class)class;
- (UIView *)superviewOfKindOfClass:(Class)class;

#pragma mark - Animation

- (void)performAnimationWithStyle:(MCViewAnimationStyle)style duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion;

@end
