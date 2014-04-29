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
    self.sectionInset = UIEdgeInsetsMake(kLayoutSectionInset, kLayoutSectionInset, kLayoutSectionInset, kLayoutSectionInset);
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

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *currentItemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    CGRect frame = currentItemAttributes.frame;

    if (indexPath.item > 0) {
        UICollectionViewLayoutAttributes *previousItemAttributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section]];
        if (CGRectGetMinX(currentItemAttributes.frame) > CGRectGetMinX(previousItemAttributes.frame)) {
            frame.origin.x = CGRectGetMaxX(previousItemAttributes.frame) + self.minimumInteritemSpacing;
            currentItemAttributes.frame = frame;
            return currentItemAttributes;
        }
    }

    frame.origin.x = self.sectionInset.left;
    currentItemAttributes.frame = frame;
    return currentItemAttributes;
}

@end
