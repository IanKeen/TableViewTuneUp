//
//  VCTableDataSource.m
//  SlimTableView
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "VCTableDataSource.h"
#import "TableCell.h"

@implementation VCTableDataSource
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
@end