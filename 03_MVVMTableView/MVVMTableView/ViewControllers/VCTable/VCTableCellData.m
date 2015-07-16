//
//  VCTableCellData.m
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "VCTableCellData.h"

@implementation VCTableCellData
-(instancetype)initWithJSON:(NSDictionary *)json {
    if (!(self = [super init])) { return nil; }
    self.albumId        = json[@"album"];
    self.id             = json[@"id"];
    self.title          = json[@"title"];
    self.url            = json[@"url"];
    self.thumbnailUrl   = json[@"thumbnailUrl"];
    return self;
}
@end
