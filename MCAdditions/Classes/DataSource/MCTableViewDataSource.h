//
//  MCTableViewDataSource.h
//  Pods
//
//  Created by Matthew Cheok on 24/3/14.
//
//

#import <UIKit/UIKit.h>

typedef void (^MCTableViewConfigureCellBlock)(id cell, id item);

@interface MCTableViewDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSArray *items;

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(MCTableViewConfigureCellBlock)configureCellBlock;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
