//
//  MCTableViewCell.m
//  CustomControls
//
//  Created by Matthew Cheok on 4/4/14.
//  Copyright (c) 2014 Matthew Cheok. All rights reserved.
//

#import "MCTableViewCell.h"
#import "UIView+MCAdditions.h"

@implementation MCTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
        [self __setup];
	}
	return self;
}

- (void)awakeFromNib {
	[self __setup];
}

- (void)__setup {
    self.backgroundView = [[UIView alloc] init];
    [self disableDelayContentTouches];
}

#pragma mark - Methods

- (void)disableDelayContentTouches {
	for (UIScrollView *scrollView in [self subviewsOfKindOfClass:[UIScrollView class]]) {
		scrollView.delaysContentTouches = NO;
	}
}

#pragma mark - UITableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    [self disableDelayContentTouches];
}

@end
