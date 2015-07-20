//
//  VCTableDelegate.h
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableOperationsManager;

@interface VCTableDelegate : UIControl <UITableViewDelegate>
@property (nonatomic, strong) NSArray *data;
@property (readonly) id selectedData;
@property (nonatomic, strong) TableOperationsManager *manager;
@end