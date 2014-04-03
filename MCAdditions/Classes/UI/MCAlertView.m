//
//  MCAlertView.m
//  MCAdditions
//
//  Created by Matthew Cheok on 22/5/13.
//  Copyright (c) 2013 Matthew Cheok. All rights reserved.
//

#import "MCAlertView.h"

#import "EXTScope.h"
#import "UIColor+MCAdditions.h"

#define ARC4RANDOM_MAX 0x100000000

static CGFloat const kMCAlertViewAlertWidth = 300;
static CGFloat const kMCAlertViewAlertPadding = 20;
static CGFloat const kMCAlertViewCornerRadius = 3;
static CGFloat const kMCAlertViewTitleFontSize = 20;
static CGFloat const kMCAlertViewMessageFontSize = 16;
static CGFloat const kMCAlertViewButtonFontSize = 16;
static CGFloat const kMCAlertViewButtonHeight = 30;
static CGFloat const kMCAlertViewAngleRange = 15;
static CGFloat const kMCAlertViewMotionOffset = 15;

@interface MCAlertView ()

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *messageLabel;

@property (strong, nonatomic) MCRoundedButton *cancelButton;
@property (strong, nonatomic) MCRoundedButton *actionButton;

@end

@implementation MCAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message actionButtonTitle:(NSString *)actionButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle completionHandler:(void (^)(BOOL cancelled))completion {
    self = [super initWithFrame:CGRectZero];
    if (self) {

        NSAssert(title || message, @"At least title or message is required.");
        NSAssert(actionButtonTitle || cancelButtonTitle, @"At least action button or cancel button is required.");

        UIColor *darkColor = [UIColor colorFromWebColorString:@"#222222"];
        UIColor *lightColor = [UIColor colorFromWebColorString:@"#F4F4F4"];
        
        
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = lightColor;
        _contentView.layer.cornerRadius = kMCAlertViewCornerRadius;
        [self addSubview:_contentView];

        if (title) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.font = [UIFont boldSystemFontOfSize:kMCAlertViewTitleFontSize];
            _titleLabel.text = title;
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            _titleLabel.textColor = darkColor;
            [_contentView addSubview:_titleLabel];
        }

        if (message) {
            _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            _messageLabel.backgroundColor = [UIColor clearColor];
            _messageLabel.font = [UIFont systemFontOfSize:kMCAlertViewMessageFontSize];
            _messageLabel.text = message;
            _messageLabel.textAlignment = NSTextAlignmentCenter;
            _messageLabel.textColor = darkColor;
            _messageLabel.numberOfLines = 0;
            [_contentView addSubview:_messageLabel];
        }

        if (actionButtonTitle) {
            _actionButton = [[MCRoundedButton alloc] initWithFrame:CGRectZero];
            _actionButton.tintColor = darkColor;
            _actionButton.selectedTitleColor = lightColor;
            _actionButton.titleLabel.font = [UIFont boldSystemFontOfSize:kMCAlertViewButtonFontSize];
            [_actionButton setTitle:actionButtonTitle forState:UIControlStateNormal];
            [_actionButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
            [_contentView addSubview:_actionButton];
        }

        if (cancelButtonTitle) {
            _cancelButton = [[MCRoundedButton alloc] initWithFrame:CGRectZero];
            _cancelButton.tintColor = darkColor;
            _cancelButton.selectedTitleColor = lightColor;
            _cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:kMCAlertViewButtonFontSize];
            [_cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            [_cancelButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
            [_contentView addSubview:_cancelButton];
        }

        _backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _backgroundView.backgroundColor = [UIColor blackColor];
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.3f;
        self.layer.shadowRadius = 10.f;
        self.layer.shadowOffset = CGSizeZero;
        self.completionHandler = completion;
        
        UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalEffect.minimumRelativeValue = @(-kMCAlertViewMotionOffset);
        horizontalEffect.maximumRelativeValue = @(kMCAlertViewMotionOffset);
        [self addMotionEffect:horizontalEffect];
        
        UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalEffect.minimumRelativeValue = @(-kMCAlertViewMotionOffset);
        verticalEffect.maximumRelativeValue = @(kMCAlertViewMotionOffset);
        [self addMotionEffect:verticalEffect];

        [self setNeedsLayout];
    }
    return self;
}

+ (id)alertViewWithTitle:(NSString *)title message:(NSString *)message actionButtonTitle:(NSString *)actionButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle completionHandler:(void (^)(BOOL cancelled))completion {
    return [[[self class] alloc] initWithTitle:title message:message actionButtonTitle:actionButtonTitle cancelButtonTitle:cancelButtonTitle completionHandler:completion];
}

- (void)sizeToFit {
    CGSize contentSize = CGSizeMake(kMCAlertViewAlertWidth, kMCAlertViewAlertPadding);
    CGFloat contentWidth = kMCAlertViewAlertWidth-2*kMCAlertViewAlertPadding;
    if (self.titleLabel) {
        CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(contentWidth, MAXFLOAT)];
        contentSize.height += titleSize.height + kMCAlertViewAlertPadding;
    }

    if (self.messageLabel) {
        CGSize messageSize = [self.messageLabel sizeThatFits:CGSizeMake(contentWidth, MAXFLOAT)];
        contentSize.height += messageSize.height + kMCAlertViewAlertPadding;
    }

    contentSize.height += kMCAlertViewButtonHeight + kMCAlertViewAlertPadding;
    self.frame = (CGRect) { .size = contentSize };
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGSize contentSize = CGSizeMake(kMCAlertViewAlertWidth, kMCAlertViewAlertPadding);
    CGFloat contentWidth = kMCAlertViewAlertWidth-2*kMCAlertViewAlertPadding;

    if (self.titleLabel) {
        CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(contentWidth, MAXFLOAT)];
        self.titleLabel.frame = CGRectMake(kMCAlertViewAlertPadding, contentSize.height, contentWidth, titleSize.height);
        contentSize.height += titleSize.height + kMCAlertViewAlertPadding;
    }

    if (self.messageLabel) {
        CGSize messageSize = [self.messageLabel sizeThatFits:CGSizeMake(contentWidth, MAXFLOAT)];
        self.messageLabel.frame = CGRectMake(kMCAlertViewAlertPadding, contentSize.height, contentWidth, messageSize.height);
        contentSize.height += messageSize.height + kMCAlertViewAlertPadding;
    }

    if (self.actionButton && !self.cancelButton) {
        self.actionButton.frame = CGRectMake(kMCAlertViewAlertPadding, contentSize.height, contentWidth, kMCAlertViewButtonHeight);
    }
    else if (self.cancelButton && !self.actionButton) {
        self.cancelButton.frame = CGRectMake(kMCAlertViewAlertPadding, contentSize.height, contentWidth, kMCAlertViewButtonHeight);
    }
    else if (self.cancelButton && self.actionButton) {
        CGFloat buttonWidth = (contentWidth - kMCAlertViewAlertPadding)/2;
        self.cancelButton.frame = CGRectMake(kMCAlertViewAlertPadding, contentSize.height, buttonWidth, kMCAlertViewButtonHeight);
        self.actionButton.frame = CGRectMake(2*kMCAlertViewAlertPadding+buttonWidth, contentSize.height, buttonWidth, kMCAlertViewButtonHeight);
    }
    contentSize.height += kMCAlertViewButtonHeight + kMCAlertViewAlertPadding;

    self.contentView.frame = (CGRect) { .size = contentSize };
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.frame cornerRadius:kMCAlertViewCornerRadius].CGPath;
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    CGRect bounds = window.bounds;

    self.backgroundView.alpha = 0;
    self.backgroundView.frame = bounds;
    [window addSubview:self.backgroundView];

    @weakify(self);
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        @strongify(self);
        self.backgroundView.alpha = 0.5f;
    } completion:nil];

    [self sizeToFit];
    [window addSubview:self];
    self.center = CGPointMake(floorf(CGRectGetWidth(bounds)/2.f),
                              -floorf(CGRectGetHeight(self.frame)/2.f));

    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationCurveEaseOut animations:^{
        @strongify(self);
        self.center = CGPointMake(floorf(CGRectGetWidth(bounds)/2.f),
                                  floorf(CGRectGetHeight(bounds)/2.f));
    } completion:^(BOOL finished) {
    }];
}

- (void)dismiss {
    @weakify(self);
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        @strongify(self);
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.backgroundView removeFromSuperview];
    }];
    CGRect bounds = self.superview.bounds;

    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationCurveEaseIn animations:^{
        @strongify(self);
        self.center = CGPointMake(floorf(CGRectGetWidth(bounds)/2.f),
                                        CGRectGetHeight(bounds)+floorf(CGRectGetHeight(self.frame)/2.f));
        CGFloat angle = floorf(((float)arc4random() / ARC4RANDOM_MAX) * kMCAlertViewAngleRange*2) - kMCAlertViewAngleRange;
        self.transform = CGAffineTransformMakeRotation(angle/180*M_PI);
    } completion:^(BOOL finished) {
        @strongify(self);
        [self removeFromSuperview];
    }];
}

- (void)buttonPress:(id)sender {
    [self dismiss];
    if (self.completionHandler) {
        self.completionHandler(sender == self.cancelButton);
    }
}

@end
