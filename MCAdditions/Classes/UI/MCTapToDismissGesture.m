//
//  MCTapToDismissKeyboardGesture.m
//  Saleswhale
//
//  Created by Matthew Cheok on 2/4/14.
//  Copyright (c) 2014 Getting Real. All rights reserved.
//

#import "MCTapToDismissGesture.h"

@interface MCTapToDismissGesture () <UIGestureRecognizerDelegate>

@end

@implementation MCTapToDismissGesture

+ (instancetype)gestureRecognizer {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super initWithTarget:self action:@selector(__dismiss)];
    if (self) {
        self.cancelsTouchesInView = NO;
        self.delaysTouchesBegan = NO;
        self.delaysTouchesEnded = NO;
        self.delegate = self;
    }
    return self;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint location = [touch locationInView:self.view];
    UIView *view = [self.view hitTest:location withEvent:nil];
    if ([view isKindOfClass:[UITextView class]] ||
        [view isKindOfClass:[UIControl class]]) {
        return NO;
    }

    return YES;
}

#pragma mark - Private

- (void)__dismiss {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

@end
