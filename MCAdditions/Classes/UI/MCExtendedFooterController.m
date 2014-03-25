//
//  MCExtendedFooterController.m
//  Pods
//
//  Created by Matthew Cheok on 25/3/14.
//
//

#import "MCExtendedFooterController.h"

@interface MCExtendedFooterController ()

@end

@implementation MCExtendedFooterController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.minimumFooterHeight = 100;
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    UIView *footerView = self.tableView.tableFooterView;
    CGRect frame = footerView.frame;
    
    frame.size.height = MAX(CGRectGetHeight(self.view.bounds) - CGRectGetMinY(footerView.frame) - self.topLayoutGuide.length, self.minimumFooterHeight);
    footerView.frame = frame;
    self.tableView.tableFooterView = footerView;
}

@end
