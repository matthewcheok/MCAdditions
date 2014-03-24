//
//  MCTableViewDataSource.m
//  Pods
//
//  Created by Matthew Cheok on 24/3/14.
//
//

#import "MCTableViewDataSource.h"

@interface MCTableViewDataSource ()

@property (copy, nonatomic) NSString *cellIdentifier;
@property (copy, nonatomic) MCTableViewConfigureCellBlock configureCellBlock;

@end

@implementation MCTableViewDataSource

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(MCTableViewConfigureCellBlock)configureCellBlock {
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}

@end
