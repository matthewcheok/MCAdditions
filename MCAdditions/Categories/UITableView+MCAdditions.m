//
//  UITableView+MCAdditions.m
//  Flyzilla
//
//  Created by Matthew Cheok on 10/4/14.
//  Copyright (c) 2014 Getting Real. All rights reserved.
//

#import "UITableView+MCAdditions.h"
#import "UIView+MCAdditions.h"

#import <objc/runtime.h>

@interface UITableView (MCAdditions_Private)

@property (nonatomic, strong, readonly) NSMutableDictionary *sizingCells;

@end

@implementation UITableView (MCAdditions_Private)

@dynamic sizingCells;

- (NSMutableDictionary *)sizingCells {
	NSMutableDictionary *cells = objc_getAssociatedObject(self, @selector(sizingCells));
	if (!cells) {
		cells = [NSMutableDictionary dictionary];
		objc_setAssociatedObject(self, @selector(sizingCells), cells, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return cells;
}

@end

@implementation UITableView (MCAdditions)

- (NSIndexPath *)nextIndexPathAfterIndexPath:(NSIndexPath *)indexPath {
	if ([self.dataSource tableView:self numberOfRowsInSection:indexPath.section] > indexPath.row + 1) {
		return [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
	}
	else if ([self.dataSource numberOfSectionsInTableView:self] > indexPath.section + 1 && [self.dataSource tableView:self numberOfRowsInSection:indexPath.section + 1] > 0) {
		return [NSIndexPath indexPathForRow:0 inSection:indexPath.section + 1];
	}
	return nil;
}

- (void)makeActiveNextTextContainerAfterTextContainer:(id)textContainer {
	UITableViewCell *cell = (UITableViewCell *)[textContainer superviewOfKindOfClass:[UITableViewCell class]];
	if (cell) {
		NSIndexPath *indexPath = [self indexPathForCell:cell];
		indexPath = [self nextIndexPathAfterIndexPath:indexPath];
		if (indexPath) {
			UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
			id textContainer = [[cell subviewsOfKindOfClass:[UITextField class]] firstObject];
			if (!textContainer) {
				textContainer = [[cell subviewsOfKindOfClass:[UITextView class]] firstObject];
			}
			[textContainer becomeFirstResponder];
            [self scrollRectToVisible:cell.frame animated:YES];
		}
	}
}

- (void)reloadDataAnimated:(BOOL)animated {
	[self reloadData];

	if (animated) {
		CATransition *animation = [CATransition animation];
		[animation setType:kCATransitionFade];
		[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		[animation setFillMode:kCAFillModeBoth];
		[animation setDuration:.3];
		[[self layer] addAnimation:animation forKey:@"UITableViewReloadDataAnimationKey"];
	}
}

#pragma mark - Sizing

- (id)sizingCellWithReuseIdentifier:(NSString *)identifier {
	return self.sizingCells[identifier];
}

- (void)registerSizingCellWithNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier {
	self.sizingCells[identifier] = [[nib instantiateWithOwner:self options:kNilOptions] firstObject];
}

- (void)registerSizingCellWithClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
	self.sizingCells[identifier] = [[cellClass alloc] init];
}

- (void)registerSizingCellWithReuseIdentifier:(NSString *)identifier {
	UICollectionViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
	self.sizingCells[identifier] = cell;
}

@end
