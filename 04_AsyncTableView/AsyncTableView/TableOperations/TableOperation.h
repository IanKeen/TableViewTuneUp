//
//  TableOperation.h
//  AsyncTableView
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^tableOperationSuccessBlock)(id value);
typedef void(^tableOperationFailureBlock)(NSError *error);
typedef void(^tableOperationResultBlock)(tableOperationSuccessBlock success, tableOperationFailureBlock failure);

@interface TableOperation : NSObject
-(instancetype)initWithOperation:(tableOperationResultBlock)result;
-(void)execute;
@property (readonly) id value;
@end
