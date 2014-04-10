//
//  MCTextField.h
//  Flyzilla
//
//  Created by Matthew Cheok on 9/4/14.
//  Copyright (c) 2014 Getting Real. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCTextField : UITextField

@property (nonatomic, strong) UIColor *placeholderTextColor;
@property (nonatomic, assign) UIEdgeInsets textEdgeInsets;
@property (nonatomic, assign) UIEdgeInsets clearButtonEdgeInsets;

@end
