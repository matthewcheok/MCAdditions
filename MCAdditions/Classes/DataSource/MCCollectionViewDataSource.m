//
//  MCCollectionViewDataSource.m
//  Pods
//
//  Created by Matthew Cheok on 24/3/14.
//
//

#import "MCCollectionViewDataSource.h"

@interface MCCollectionViewDataSource ()

@property (copy, nonatomic) NSString *cellIdentifier;
@property (copy, nonatomic) MCCollectionViewConfigureCellBlock configureCellBlock;

@end

@implementation MCCollectionViewDataSource

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(MCCollectionViewConfigureCellBlock)configureCellBlock {
    self = [super init];
    if (self) {
        _items = items;
        _cellIdentifier = cellIdentifier;
        _configureCellBlock = [configureCellBlock copy];
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[indexPath.item];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}

@end
