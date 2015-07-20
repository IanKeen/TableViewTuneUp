//
//  VCTableModel.h
//
//  Created by Ian Keen on 16/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyAPI;
@class VCTableCellData;

typedef void(^didReloadDataBlock)(NSArray *data);
typedef void(^didErrorBlock)(NSString *error);
typedef void(^didUpdateNavigationTitleBlock)(NSString *title);

@interface VCTableModel : NSObject
-(instancetype)initWithManager:(MyAPI *)api;

-(void)reloadData;
-(void)userSelectedCell:(VCTableCellData *)cellData;

@property (readonly) NSString *title;

@property (nonatomic, copy) didReloadDataBlock didReloadData;
@property (nonatomic, copy) didErrorBlock didError;
@property (nonatomic, copy) didUpdateNavigationTitleBlock didUpdateNavigationTitle;
@end