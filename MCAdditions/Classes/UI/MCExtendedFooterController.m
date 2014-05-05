//
//  MCExtendedFooterController.m
//  MCAdditions
//
//  Created by Matthew Cheok on 25/3/14.
//
//

#import "MCExtendedFooterController.h"

@interface MCExtendedFooterController ()

@end

@implementation MCExtendedFooterController

#pragma mark - Methods

- (void)updateFooterHeight {
	UIView *footerView = self.tableView.tableFooterView;
	CGRect frame = footerView.frame;

	frame.size.height = MAX(CGRectGetHeight(self.view.bounds) - CGRectGetMinY(footerView.frame), self.minimumFooterHeight);
	footerView.frame = frame;
	self.tableView.tableFooterView = footerView;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.minimumFooterHeight = 0;
	self.tableView.delaysContentTouches = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self performSelector:@selector(updateFooterHeight) withObject:nil afterDelay:0];
}

@end
