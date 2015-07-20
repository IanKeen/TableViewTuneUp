//
//  TableOperationsManager.h
//  AsyncTableView
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableOperation;

typedef void(^didGetDataForCellBlock)(NSIndexPath *indexPath, id value);

@interface TableOperationsManager : NSObject
-(void)getDataForCellAtIndexPath:(NSIndexPath *)indexPath;
-(void)addOperationIfNeeded:(TableOperation *)operation indexPath:(NSIndexPath *)indexPath;
-(void)invalidate;
@property (nonatomic, copy) didGetDataForCellBlock didGetDataForCell;
@end
