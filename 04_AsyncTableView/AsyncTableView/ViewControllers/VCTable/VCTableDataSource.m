//
//  VCTableDataSource.m
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "VCTableDataSource.h"
#import "TableCell.h"
#import "VCTableCellData+TableOperation.h"
#import "TableOperationsManager.h"

@implementation VCTableDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (self.data == nil ? 0 : 1);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableCell class]) forIndexPath:indexPath];
    
    VCTableCellData *data = self.data[indexPath.row];
    TableOperation *operation = [data operation];
    [self.manager addOperationIfNeeded:operation indexPath:indexPath];
    [self.manager getDataForCellAtIndexPath:indexPath];
    
    return cell;
}
@end