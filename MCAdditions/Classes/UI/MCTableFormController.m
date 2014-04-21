//
//  MCTableFormController.m
//  Saleswhale
//
//  Created by Matthew Cheok on 21/4/14.
//  Copyright (c) 2014 Getting Real. All rights reserved.
//

#import "MCTableFormController.h"

@interface MCTableFormController ()
@end

@implementation MCTableFormController

#pragma mark - Properties

- (void)setPickerIndexPaths:(NSArray *)pickerIndexPaths {
	_pickerIndexPaths = pickerIndexPaths;
	[self collapsePicker];
}

- (void)setSelectedPickerIndexPath:(NSIndexPath *)selectedPickerIndexPath {
    _selectedPickerIndexPath = selectedPickerIndexPath;
    [self.tableView beginUpdates];
	[self.tableView endUpdates];
}

#pragma mark - Methods

- (void)togglePickerAtIndexPath:(NSIndexPath *)indexPath {
	if ([self.selectedPickerIndexPath isEqual:indexPath]) {
		self.selectedPickerIndexPath = nil;
	}
	else {
		self.selectedPickerIndexPath = indexPath;
	}

	if (self.selectedPickerIndexPath) {
		[self.tableView scrollToRowAtIndexPath:self.selectedPickerIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
	}
}

- (void)collapsePicker {
	self.selectedPickerIndexPath = nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([self.pickerIndexPaths containsObject:indexPath]) {
		if ([self.selectedPickerIndexPath isEqual:indexPath]) {
			return 216;
		}
		return 0;
	}
	return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSIndexPath *pickerIndexPath = nil;
	for (NSIndexPath *oneIndexPath in self.pickerIndexPaths) {
		if (indexPath.section == oneIndexPath.section &&
		    indexPath.row == oneIndexPath.row - 1) {
			pickerIndexPath = oneIndexPath;
			break;
		}
	}
    
	if (pickerIndexPath) {
		[self togglePickerAtIndexPath:pickerIndexPath];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
	else {
		[self collapsePicker];
	}
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.clipsToBounds = YES;
}

@end
