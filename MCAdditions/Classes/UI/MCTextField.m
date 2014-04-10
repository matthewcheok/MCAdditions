//
//  MCTextField.m
//  Flyzilla
//
//  Created by Matthew Cheok on 9/4/14.
//  Copyright (c) 2014 Getting Real. All rights reserved.
//

#import "MCTextField.h"

@implementation MCTextField

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
	_placeholderTextColor = placeholderTextColor;

	if (!self.text && self.placeholder) {
		[self setNeedsDisplay];
	}
}

#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		[self _initialize];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self _initialize];
	}
	return self;
}

#pragma mark - UITextField

- (CGRect)textRectForBounds:(CGRect)bounds {
	return UIEdgeInsetsInsetRect([super textRectForBounds:bounds], _textEdgeInsets);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
	return [self textRectForBounds:bounds];
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
	CGRect rect = [super clearButtonRectForBounds:bounds];
	rect.origin.y = rect.origin.y + _clearButtonEdgeInsets.top;
	rect.origin.x = rect.origin.x + _clearButtonEdgeInsets.right;
	return rect;
}

- (void)drawPlaceholderInRect:(CGRect)rect {
	if (!_placeholderTextColor) {
		[super drawPlaceholderInRect:rect];
		return;
	}

	NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
	paragraphStyle.alignment = self.textAlignment;

    CGFloat offset = (CGRectGetHeight(rect) - [self.font lineHeight])/2;
    rect = CGRectInset(rect, 0, offset);
    
	[self.placeholder drawInRect:rect withAttributes:@{
	     NSFontAttributeName: self.font,
         NSForegroundColorAttributeName: self.placeholderTextColor,
	     NSParagraphStyleAttributeName: paragraphStyle
	 }];
}

#pragma mark - Private

- (void)_initialize {
	_textEdgeInsets = UIEdgeInsetsZero;
	_clearButtonEdgeInsets = UIEdgeInsetsZero;
}

@end
