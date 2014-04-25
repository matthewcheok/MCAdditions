//
//  MCExtendedFooterController.h
//  MCAdditions
//
//  Created by Matthew Cheok on 25/3/14.
//
//

#import <UIKit/UIKit.h>

@interface MCExtendedFooterController : UITableViewController

@property (assign, nonatomic) CGFloat minimumFooterHeight;

- (void)updateFooterHeight;

@end
