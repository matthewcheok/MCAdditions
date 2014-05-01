//
//  MCCollectionViewAlignedLeftLayout.m
//  MCAdditions
//
//  Created by Matthew Cheok on 31/3/14.
//  Copyright (c) 2014 Getting Real. All rights reserved.
//

#import "MCCollectionViewAlignedLeftLayout.h"

static CGFloat const kLayoutSectionInset = 20;

@implementation MCCollectionViewAlignedLeftLayout

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(kLayoutSectionInset, kLayoutSectionInset, kLayoutSectionInset, kLayoutSectionInset);
}

#pragma mark - Properties

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    if (scrollDirection != UICollectionViewScrollDirectionVertical) {
        [NSException raise:NSInternalInconsistencyException format:@"Only vertical scroll direction is supported."];
    }
    [super setScrollDirection:scrollDirection];
}

#pragma mark - UICollectionViewFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray* attributesToReturn = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes* attributes in attributesToReturn) {
        if (nil == attributes.representedElementKind) {
            NSIndexPath* indexPath = attributes.indexPath;
            attributes.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
        }
    }
    return attributesToReturn;
}

- (id<UICollectionViewDelegateFlowLayout>)delegate {
    return (id)self.collectionView.delegate;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *currentItemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    CGRect frame = currentItemAttributes.frame;

    if (indexPath.item > 0) {
        UICollectionViewLayoutAttributes *previousItemAttributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section]];
        if (CGRectGetMinX(currentItemAttributes.frame) > CGRectGetMinX(previousItemAttributes.frame)) {
            
            CGFloat minimumInteritemSpacing = self.minimumInteritemSpacing;
            if ([self.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
                minimumInteritemSpacing = [self.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:indexPath.section];
            }
            
            frame.origin.x = CGRectGetMaxX(previousItemAttributes.frame) + minimumInteritemSpacing;
            currentItemAttributes.frame = frame;
            return currentItemAttributes;
        }
    }

    if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        UIEdgeInsets inset = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.section];
        frame.origin.x = inset.left;
    }
    else {
        frame.origin.x = self.sectionInset.left;
    }
    currentItemAttributes.frame = frame;
    return currentItemAttributes;
}

@end
