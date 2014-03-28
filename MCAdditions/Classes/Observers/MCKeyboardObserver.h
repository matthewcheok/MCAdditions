//
//  MCKeyboardObserver.h
//  MCAdditions
//
//  Created by Matthew Cheok on 28/3/14.
//
//

#import <Foundation/Foundation.h>

typedef void (^MCKeyboardObserverAnimationBlock)(NSString *notificationName, CGRect keyboardFrame);
typedef void (^MCKeyboardObserverCompletionBlock)(NSString *notificationName, BOOL finished);

@interface MCKeyboardObserver : NSObject

@property (weak, nonatomic, readonly) UIView *view;
@property (copy, nonatomic, readonly) MCKeyboardObserverAnimationBlock animations;
@property (copy, nonatomic, readonly) MCKeyboardObserverCompletionBlock completion;

+ (instancetype)observerInView:(UIView *)view animations:(MCKeyboardObserverAnimationBlock)animations completion:(MCKeyboardObserverCompletionBlock)completion;

- (instancetype)initInView:(UIView *)view animations:(MCKeyboardObserverAnimationBlock)animations completion:(MCKeyboardObserverCompletionBlock)completion;

@end
