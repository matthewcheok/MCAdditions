//
//  MCTableFormController.h
//  Saleswhale
//
//  Created by Matthew Cheok on 21/4/14.
//  Copyright (c) 2014 Getting Real. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCTableFormController : UITableViewController

@property (strong, nonatomic) NSArray *pickerIndexPaths;
@property (strong, nonatomic) NSIndexPath *selectedPickerIndexPath;

- (void)togglePickerAtIndexPath:(NSIndexPath *)indexPath;
- (void)collapsePicker;

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
