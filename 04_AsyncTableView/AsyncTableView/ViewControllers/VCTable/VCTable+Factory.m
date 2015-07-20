//
//  VCTable+Factory.m
//
//  Created by Ian Keen on 16/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "VCTable+Factory.h"
#import "VCTableModel.h"
#import "MyAPI.h"

@implementation VCTable (Factory)
+(instancetype)factoryInstance {
    VCTableModel *model = [[VCTableModel alloc] initWithManager:[MyAPI new]];
    return [[VCTable alloc] initWithModel:model];
}
@end
