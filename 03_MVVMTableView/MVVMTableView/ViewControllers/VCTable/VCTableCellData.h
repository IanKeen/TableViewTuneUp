//
//  VCTableCellData.h
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCTableCellData : NSObject
-(instancetype)initWithJSON:(NSDictionary *)json;

@property (nonatomic, copy) NSNumber *albumId;
@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *thumbnailUrl;
@end
