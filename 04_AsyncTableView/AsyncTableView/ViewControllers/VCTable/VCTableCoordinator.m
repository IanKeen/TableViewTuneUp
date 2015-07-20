//
//  VCTableCoordinator.m
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "VCTableCoordinator.h"
#import "VCTableDataSource.h"
#import "VCTableDelegate.h"
#import "TableCell.h"
#import "TableOperationsManager.h"

@interface VCTableCoordinator ()
@property (nonatomic, strong) IBOutlet VCTableDataSource *dataSource;
@property (nonatomic, strong) IBOutlet VCTableDelegate *delegate;
@end

@implementation VCTableCoordinator
#pragma mark - Lifecycle
-(void)awakeFromNib {
    [super awakeFromNib];
    self.manager = [TableOperationsManager new];
    [self registerCells];
}

#pragma mark - Public
-(void)reloadData:(NSArray *)data {
    [self bindToTableOperationsManager];
    [self.manager invalidate];
    
    self.dataSource.data = data;
    self.delegate.data = data;
    
    [self.tableView reloadData];
}

#pragma mark - Private
-(void)registerCells {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([TableCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([TableCell class])];
}

#pragma mark - TableOperationsManager
-(void)bindToTableOperationsManager {
    self.dataSource.manager = self.manager;
    self.delegate.manager = self.manager;
    self.manager.didGetDataForCell = [self tableOperationsManagerDidGetDataForCell];
}
-(didGetDataForCellBlock)tableOperationsManagerDidGetDataForCell {
    return ^(NSIndexPath *indexPath, UIImage *image) {
        TableCell *cell = (TableCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        if (cell) { [cell updateImage:image]; }
    };
}
@end