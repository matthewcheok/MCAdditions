//
//  UICollectionView+MCAdditions.m
//  Pods
//
//  Created by Matthew Cheok on 29/4/14.
//
//

#import "UICollectionView+MCAdditions.h"
#import <objc/runtime.h>

@interface UICollectionView (MCAdditions_Private)

@property (nonatomic, strong, readonly) NSMutableDictionary *sizingCells;

@end

@implementation UICollectionView (MCAdditions_Private)

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

@implementation UICollectionView (MCAdditions)

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
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    self.sizingCells[identifier] = cell;
}

@end
