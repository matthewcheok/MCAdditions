//
//  MCProgressView.h
//  MCAdditions
//
//  Created by Matthew Cheok on 7/2/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCProgressView : UIView

@property (strong, nonatomic, readonly) UIImageView *imageView;

@property (strong, nonatomic) NSProgress *progress;
@property (assign, nonatomic) CGFloat value;

@property (strong, nonatomic) UIColor *completedTintColor UI_APPEARANCE_SELECTOR;

@end
