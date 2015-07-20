//
//  VCTableCoordinator.h
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableOperationsManager;

@interface VCTableCoordinator : NSObject
-(void)reloadData:(NSArray *)data;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) TableOperationsManager *manager;
@end
