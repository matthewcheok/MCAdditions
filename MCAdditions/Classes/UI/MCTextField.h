//
//  MCTextField.h
//  Flyzilla
//
//  Created by Matthew Cheok on 9/4/14.
//  Copyright (c) 2014 Getting Real. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCTextField : UITextField

@property (strong, nonatomic) UIColor *placeholderTextColor;
@property (assign, nonatomic) UIEdgeInsets textEdgeInsets;
@property (assign, nonatomic) UIEdgeInsets clearButtonEdgeInsets;

@property (assign, nonatomic, getter = hasValidContent, readonly) BOOL validContent;

- (BOOL)checkValidityOfContentWithPrompt:(NSString *)prompt;
- (BOOL)checkValidityOfContentWithShake;

@end
