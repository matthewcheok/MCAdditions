//
//  UICollectionView+MCAdditions.h
//  Pods
//
//  Created by Matthew Cheok on 29/4/14.
//
//

#import <UIKit/UIKit.h>

@interface UICollectionView (MCAdditions)

- (id)sizingCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerSizingCellWithReuseIdentifier:(NSString *)identifier;

- (void)registerSizingCellWithNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerSizingCellWithClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

@end
