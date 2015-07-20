//
//  VCTableCellData+TableOperation.h
//  AsyncTableView
//
//  Created by Ian Keen on 19/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCTableCellData.h"

@class TableOperation;

@interface VCTableCellData (TableOperation)
-(TableOperation *)operation;
@end
