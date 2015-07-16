//
//  VCTableDelegate.m
//  SlimTableView
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "VCTableDelegate.h"
#import "TableCell.h"

@implementation VCTableDelegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    id data = self.data[indexPath.row];
    [((TableCell *)cell) setup:data];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedData = self.data[indexPath.row];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}
@end