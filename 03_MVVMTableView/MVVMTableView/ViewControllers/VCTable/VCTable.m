//
//  VCTable.m
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "VCTable.h"
#import "VCTableCellData.h"
#import "VCTableCoordinator.h"
#import "VCTableDelegate.h"
#import "VCTableModel.h"

@interface VCTable ()
@property (nonatomic, strong) UIRefreshControl *refresh;
@property (nonatomic, strong) VCTableModel *model;
@property (nonatomic, strong) IBOutlet VCTableCoordinator *tableViewCoordinator;
@end

@implementation VCTable
#pragma mark - Lifecycle
-(instancetype)initWithModel:(VCTableModel *)model {
    if (!(self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil])) { return nil; }
    self.model = model;
    return self;
}
-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.title;
    
    [self bindToModel];
    [self setupPullToRefresh];
    [self reloadData];
}

#pragma mark - Pull to refresh
-(void)setupPullToRefresh {
    self.refresh = [UIRefreshControl new];
    [self.refresh addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    [self.tableViewCoordinator.tableView addSubview:self.refresh];
}
-(void)endRefreshing {
    //bug fix for the 'first run blues' when using UIRefreshControl
    //
    //when using UIRefreshControl (only programmatically?) after it finishes the first time
    //it seems to get into a weird state, calling it in this way keeps it working as expected
    //
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.refresh beginRefreshing];
        [self.refresh endRefreshing];
    });
}

#pragma mark - Model
-(void)bindToModel {
    self.model.didError = [self modelDidError];
    self.model.didReloadData = [self modelDidReloadData];
    self.model.didUpdateNavigationTitle = [self modelDidUpdateNavigationTitle];
}
-(didError)modelDidError {
    return ^(NSString *error) {
        [self endRefreshing];
        
        [[[UIAlertView alloc]
          initWithTitle:@"Oops.."
          message:error
          delegate:nil
          cancelButtonTitle:@"OK"
          otherButtonTitles:nil]
         show];
    };
}
-(didReloadData)modelDidReloadData {
    return ^(NSArray *data) {
        [self endRefreshing];
        [self.tableViewCoordinator reloadData:data];
    };
}
-(didUpdateNavigationTitle)modelDidUpdateNavigationTitle {
    return ^(NSString *title) {
        self.title = title;
    };
}

#pragma mark - Data
-(void)reloadData {
    [self.refresh beginRefreshing];
    [self.model reloadData];
}
-(IBAction)itemPressed:(VCTableDelegate *)sender {
    VCTableCellData *data = sender.selectedData;
    [self.model userSelectedCell:data];
    NSLog(@"Selected ID: %@", data.id);
}
@end
