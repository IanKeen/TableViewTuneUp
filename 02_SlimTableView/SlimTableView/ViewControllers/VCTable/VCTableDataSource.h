//
//  VCTableDataSource.h
//  SlimTableView
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCTableDataSource : NSObject <UITableViewDataSource>
@property (nonatomic, strong) NSArray *data;
@end
