//
//  VCTableCoordinator.h
//  SlimTableView
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCTableCoordinator : NSObject
-(void)reloadData:(NSArray *)data;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@end