//
//  MCCollectionViewDataSource.h
//  Pods
//
//  Created by Matthew Cheok on 24/3/14.
//
//

#import <UIKit/UIKit.h>

typedef void (^MCCollectionViewConfigureCellBlock)(id cell, id item);

@interface MCCollectionViewDataSource : NSObject <UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *items;

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(MCCollectionViewConfigureCellBlock)configureCellBlock;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
