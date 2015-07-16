//
//  VCTableCoordinator.m
//  SlimTableView
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "VCTableCoordinator.h"
#import "VCTableDataSource.h"
#import "VCTableDelegate.h"
#import "TableCell.h"

@interface VCTableCoordinator ()
@property (nonatomic, strong) IBOutlet VCTableDataSource *dataSource;
@property (nonatomic, strong) IBOutlet VCTableDelegate *delegate;
@end

@implementation VCTableCoordinator
#pragma mark - Lifecycle
-(void)awakeFromNib {
    [super awakeFromNib];
    
    [self registerCells];
}

#pragma mark - Public
-(void)reloadData:(NSArray *)data {
    self.dataSource.data = data;
    self.delegate.data = data;
    
    [self.tableView reloadData];
}

#pragma mark - Private
-(void)registerCells {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([TableCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([TableCell class])];
}
@end