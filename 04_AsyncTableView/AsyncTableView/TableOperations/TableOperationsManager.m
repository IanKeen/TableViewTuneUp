//
//  TableOperationsManager.m
//  AsyncTableView
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "TableOperationsManager.h"
#import "TableOperation.h"

@interface TableOperationsManager ()
@property (nonatomic, strong) NSMutableDictionary *operations;
@end

@interface TableOperation (Private)
@property (nonatomic, copy) tableOperationSuccessBlock didSucceed;
@end

@implementation TableOperationsManager
#pragma mark - Lifecycle
-(instancetype)init {
    if (!(self = [super init])) { return nil; }
    self.operations = [NSMutableDictionary dictionary];
    return self;
}
#pragma mark - Public
-(void)getDataForCellAtIndexPath:(NSIndexPath *)indexPath {
    TableOperation *operation = self.operations[indexPath];
    if (operation == nil) {
        NSLog(@"No Operation has been added for %@", indexPath);
        return;
    }
        
    if (operation.value != nil) {
        //This operation has already completed so we just push its value through
        [self deliverValue:operation.value indexPath:indexPath];
        
    } else {
        //This operation has not completed yet, attempt to execute it
        [operation execute];
    }
}
-(void)addOperationIfNeeded:(TableOperation *)operation indexPath:(NSIndexPath *)indexPath {
    if (self.operations[indexPath] != nil) { return; } //only 1 operation per indexPath
    
    /**
     *  Add the operation, setup a completion handler then we execute it
     */
    self.operations[indexPath] = operation;
    operation.didSucceed = ^(id value) {
        [self deliverValue:value indexPath:indexPath];
    };
    [operation execute];
}
-(void)invalidate {
    [self.operations removeAllObjects];
}

#pragma mark - Private
-(void)deliverValue:(id)value indexPath:(NSIndexPath *)indexPath {
    if (self.didGetDataForCell == nil) { return; }
    
    //operations are executed on background threads
    //so we ensure they are always delivered on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        self.didGetDataForCell(indexPath, value);
    });
}
@end
