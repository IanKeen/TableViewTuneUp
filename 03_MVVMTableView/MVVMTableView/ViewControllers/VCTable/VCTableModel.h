//
//  VCTableModel.h
//
//  Created by Ian Keen on 16/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyAPI;
@class VCTableCellData;

typedef void(^didReloadData)(NSArray *data);
typedef void(^didError)(NSString *error);
typedef void(^didUpdateNavigationTitle)(NSString *title);

@interface VCTableModel : NSObject
-(instancetype)initWithManager:(MyAPI *)api;

-(void)reloadData;
-(void)userSelectedCell:(VCTableCellData *)cellData;

@property (readonly) NSString *title;

@property (nonatomic, copy) didReloadData didReloadData;
@property (nonatomic, copy) didError didError;
@property (nonatomic, copy) didUpdateNavigationTitle didUpdateNavigationTitle;
@end