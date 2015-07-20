//
//  TableOperation.m
//  AsyncTableView
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "TableOperation.h"

@interface TableOperation ()
@property (nonatomic, copy) tableOperationResultBlock block;
@property (nonatomic, assign) BOOL isExecuting;
@property (nonatomic, copy) tableOperationSuccessBlock didSucceed;
@end

@implementation TableOperation
-(instancetype)initWithOperation:(tableOperationResultBlock)result {
    if (!(self = [super init])) { return nil; }
    self.block = result;
    return self;
}
-(void)execute {
    //Don't continue unless the user provided a block and we are not currently executing it
    if (self.block == nil || self.value != nil || self.isExecuting) { return; }
    self.isExecuting = YES;
    
    //execute the operation on a background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.block(^(id value) {
            /**
             *  Operation was successful, store the vale and notify listener
             */
            _value = value;
            if (self.didSucceed) { self.didSucceed(value); }
            self.isExecuting = NO;
            
        }, ^(NSError *error) {
            /*
             *  Errors are not handled,
             *  this will cause the operation to be retried
             */
            self.isExecuting = NO;
        });
    });
}
@end
