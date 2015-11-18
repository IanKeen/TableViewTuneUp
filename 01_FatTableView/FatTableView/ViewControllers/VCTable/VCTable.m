//
//  VCTable.m
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "VCTable.h"
#import "VCTableCellData.h"
#import "TableCell.h"

static NSString *kURL = @"http://jsonplaceholder.typicode.com/photos";

@interface VCTable () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refresh;
@property (nonatomic, strong) NSArray *data;
@end

@implementation VCTable
#pragma mark - Lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Fat Table View Example";
    
    [self registerCells];
    [self setupPullToRefresh];
    [self reloadData];
}

#pragma mark - Private
-(void)registerCells {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([TableCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([TableCell class])];
}

#pragma mark - Pull to refresh
-(void)setupPullToRefresh {
    self.refresh = [UIRefreshControl new];
    [self.refresh addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refresh];
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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *err = nil;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kURL]];
        if (data == nil) {
            err = [NSError errorWithDomain:NSStringFromClass([self class]) code:0
                                  userInfo:@{NSLocalizedDescriptionKey: @"No data returned by server"}];
			[self endRefreshing];
			return;
        }
        
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (err) {
                [self endRefreshing];
                
                [[[UIAlertView alloc]
                  initWithTitle:@"Oops.."
                  message:[NSString stringWithFormat:@"An Error Occured\n\n%@", err.localizedDescription]
                  delegate:nil
                  cancelButtonTitle:@"OK"
                  otherButtonTitles:nil]
                 show];
                
            } else {
                NSMutableArray *items = [NSMutableArray array];
                for (NSDictionary *jsonItem in json) {
                    VCTableCellData *item = [[VCTableCellData alloc] initWithJSON:jsonItem];
                    [items addObject:item];
                }
                
                [self endRefreshing];
                self.data = items;
                [self.tableView reloadData];
            }
        });
    });
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (self.data == nil ? 0 : 1);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    VCTableCellData *data = self.data[indexPath.row];
    [((TableCell *)cell) setup:data];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VCTableCellData *data = self.data[indexPath.row];
    [[[UIAlertView alloc]
      initWithTitle:self.title
      message:[NSString stringWithFormat:@"Selected ID: %@", data.id]
      delegate:nil
      cancelButtonTitle:@"OK"
      otherButtonTitles:nil]
     show];
}
@end
