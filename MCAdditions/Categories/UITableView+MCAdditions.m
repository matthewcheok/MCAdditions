//
//  UITableView+MCAdditions.m
//  Flyzilla
//
//  Created by Matthew Cheok on 10/4/14.
//  Copyright (c) 2014 Getting Real. All rights reserved.
//

#import "UITableView+MCAdditions.h"
#import "UIView+MCAdditions.h"

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

- (void)makeActiveNextTextFieldAfterTextField:(UITextField *)textField {
    UITableViewCell *cell = (UITableViewCell *)[textField superviewOfKindOfClass:[UITableViewCell class]];
	if (cell) {
		NSIndexPath *indexPath = [self indexPathForCell:cell];
		indexPath = [self nextIndexPathAfterIndexPath:indexPath];
		if (indexPath) {
			UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
			UITextField *textField = [[cell subviewsOfKindOfClass:[UITextField class]] firstObject];
			[textField becomeFirstResponder];
		}
	}
}

@end
