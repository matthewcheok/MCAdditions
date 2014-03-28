//
//  MCKeyboardObserver.m
//  MCAdditions
//
//  Created by Matthew Cheok on 28/3/14.
//
//

#import "MCKeyboardObserver.h"
#import "UIView+MCAdditions.h"

@interface MCKeyboardObserver ()

@property (weak, nonatomic) UIView *view;
@property (copy, nonatomic) MCKeyboardObserverAnimationBlock animations;
@property (copy, nonatomic) MCKeyboardObserverCompletionBlock completion;

@end

@implementation MCKeyboardObserver

+ (instancetype)observerInView:(UIView *)view animations:(MCKeyboardObserverAnimationBlock)animations completion:(MCKeyboardObserverCompletionBlock)completion {
    return [[self alloc] initInView:view animations:animations completion:completion];
}

- (instancetype)initInView:(UIView *)view animations:(MCKeyboardObserverAnimationBlock)animations completion:(MCKeyboardObserverCompletionBlock)completion {
    self = [super init];
    if (self) {
        _view = view;
        _animations = [animations copy];
        _completion = [completion copy];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
	CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
	CGRect keyboardFrame = [self.view convertRect:frame fromView:[[UIApplication sharedApplication] delegate].window];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithKeyboardNotification:notification delay:0 options:0 animations:^{
	    typeof(self) strongSelf = weakSelf;
        strongSelf.animations(notification.name, keyboardFrame);
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification {
	CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
	CGRect keyboardFrame = [self.view convertRect:frame fromView:[[UIApplication sharedApplication] delegate].window];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithKeyboardNotification:notification delay:0 options:0 animations:^{
	    typeof(self) strongSelf = weakSelf;
        strongSelf.animations(notification.name, keyboardFrame);
    } completion:nil];
}

@end
