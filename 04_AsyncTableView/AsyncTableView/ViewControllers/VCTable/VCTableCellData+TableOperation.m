//
//  VCTableCellData+TableOperation.m
//  AsyncTableView
//
//  Created by Ian Keen on 19/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "VCTableCellData+TableOperation.h"
#import "TableOperation.h"

@implementation VCTableCellData (TableOperation)
-(TableOperation *)operation {
    return [[TableOperation alloc] initWithOperation:^(tableOperationSuccessBlock success, tableOperationFailureBlock failure) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.url]];
        if (data == nil) {
            failure([self errorWithDescription:@"No data returned"]);
            
        } else {
            UIImage *image = [UIImage imageWithData:data];
            if (image == nil) { failure([self errorWithDescription:@"Unable to construct image"]); }
            else { success(image); }
        }
    }];
}

-(NSError *)errorWithDescription:(NSString *)message {
    return [NSError errorWithDomain:NSStringFromClass([self class]) code:0
                           userInfo:@{NSLocalizedDescriptionKey: message}];
}
@end
