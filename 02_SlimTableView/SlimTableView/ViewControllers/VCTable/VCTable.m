//
//  VCTable.m
//  AsyncTableView
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "VCTable.h"
#import "VCTableCellData.h"
#import "TableCell.h"
#import "MyAPI.h"
#import "VCTableCoordinator.h"
#import "VCTableDelegate.h"

static NSString *kURL = @"http://jsonplaceholder.typicode.com/photos";

@interface VCTable ()
@property (nonatomic, strong) UIRefreshControl *refresh;
@property (nonatomic, strong) MyAPI *api;
@property (nonatomic, strong) IBOutlet VCTableCoordinator *tableViewCoordinator;
@end

@implementation VCTable
#pragma mark - Lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Slim Table View Example";
    self.api = [MyAPI new];
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

#pragma mark - Data
-(void)reloadData {
    [self.refresh beginRefreshing];
    
    [self.api getPhotos:^(NSArray *json) {
        NSMutableArray *items = [NSMutableArray array];
        for (NSDictionary *jsonItem in json) {
            VCTableCellData *item = [[VCTableCellData alloc] initWithJSON:jsonItem];
            [items addObject:item];
        }
        
        [self endRefreshing];
        [self.tableViewCoordinator reloadData:items];
        
    } error:^(NSError *error) {
        [self endRefreshing];
        
        [[[UIAlertView alloc]
          initWithTitle:@"Oops.."
          message:[NSString stringWithFormat:@"An Error Occured\n\n%@", error.localizedDescription]
          delegate:nil
          cancelButtonTitle:@"OK"
          otherButtonTitles:nil]
         show];
    }];
}

-(IBAction)itemPressed:(VCTableDelegate *)sender {
    VCTableCellData *data = sender.selectedData;
    NSLog(@"Selected ID: %@", data.id);
}
@end
