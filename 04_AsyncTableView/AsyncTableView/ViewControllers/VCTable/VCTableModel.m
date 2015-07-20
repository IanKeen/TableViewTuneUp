//
//  VCTableModel.m
//
//  Created by Ian Keen on 16/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "VCTableModel.h"
#import "VCTableCellData.h"
#import "MyAPI.h"

@interface VCTableModel ()
@property (nonatomic, strong) MyAPI *api;
@end

@implementation VCTableModel
#pragma mark - Lifecycle
-(instancetype)initWithManager:(MyAPI *)api {
    if (!(self = [super init])) { return nil; }
    self.api = api;
    return self;
}

#pragma mark - Public
-(NSString *)title {
    return @"Async Table View Example";
}
-(void)reloadData {
    [self sendNavigationTitle:self.title];
    
    [self.api getPhotos:^(NSArray *json) {
        NSMutableArray *items = [NSMutableArray array];
        for (NSDictionary *jsonItem in json) {
            VCTableCellData *item = [[VCTableCellData alloc] initWithJSON:jsonItem];
            [items addObject:item];
        }
        [self sendData:items];
        
    } error:^(NSError *error) {
        [self sendError:error];
    }];
}
-(void)userSelectedCell:(VCTableCellData *)cellData {
    [self sendNavigationTitle:cellData.title];
}

#pragma mark - Private
-(NSString *)userMessageForError:(NSError *)error {
    return [NSString stringWithFormat:@"An Error Occured\n\n%@", error.localizedDescription];
}
-(void)sendError:(NSError *)error {
    if (self.didError == nil) { return; }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.didError([self userMessageForError:error]);
    });
}
-(void)sendData:(NSArray *)data {
    if (self.didReloadData == nil) { return; }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.didReloadData(data);
    });
}
-(void)sendNavigationTitle:(NSString *)title {
    if (self.didUpdateNavigationTitle == nil) { return; }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.didUpdateNavigationTitle(title);
    });
}
@end
