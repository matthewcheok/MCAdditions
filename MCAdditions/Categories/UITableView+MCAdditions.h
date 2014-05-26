//
//  UITableView+MCAdditions.h
//  Flyzilla
//
//  Created by Matthew Cheok on 10/4/14.
//  Copyright (c) 2014 Getting Real. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (MCAdditions)

- (void)makeActiveNextTextContainerAfterTextContainer:(id)textContainer;
- (void)reloadDataAnimated:(BOOL)animated;

#pragma mark - Sizing

- (id)sizingCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerSizingCellWithReuseIdentifier:(NSString *)identifier;

- (void)registerSizingCellWithNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerSizingCellWithClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

@end
