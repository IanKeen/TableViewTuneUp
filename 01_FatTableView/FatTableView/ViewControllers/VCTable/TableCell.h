//
//  TableCell.h
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VCTableCellData;

@interface TableCell : UITableViewCell
-(void)setup:(VCTableCellData *)data;
@end
