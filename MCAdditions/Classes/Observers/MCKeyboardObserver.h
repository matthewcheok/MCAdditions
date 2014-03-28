//
//  MCKeyboardObserver.h
//  MCAdditions
//
//  Created by Matthew Cheok on 28/3/14.
//
//

#import <Foundation/Foundation.h>

typedef void (^MCKeyboardObserverShowAnimationBlock)(CGRect keyboardFrame);
typedef void (^MCKeyboardObserverHideAnimationBlock)(CGRect keyboardFrame);

@interface MCKeyboardObserver : NSObject

@property (weak, nonatomic, readonly) UIView *view;
@property (copy, nonatomic, readonly) MCKeyboardObserverShowAnimationBlock showAnimations;
@property (copy, nonatomic, readonly) MCKeyboardObserverHideAnimationBlock hideAnimations;

+ (instancetype)observerInView:(UIView *)view showAnimations:(MCKeyboardObserverShowAnimationBlock)showAnimations hideAnimations:(MCKeyboardObserverHideAnimationBlock)hideAnimations;

- (instancetype)initInView:(UIView *)view showAnimations:(MCKeyboardObserverShowAnimationBlock)showAnimations hideAnimations:(MCKeyboardObserverHideAnimationBlock)hideAnimations;

@end
