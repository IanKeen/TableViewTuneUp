//
//  MyAPI.m
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "MyAPI.h"

static NSString *kURL = @"http://jsonplaceholder.typicode.com/photos";

@implementation MyAPI
-(void)getPhotos:(myAPIDidGetPhotos)complete error:(myAPIDidError)error {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *err = nil;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kURL]];
        if (data == nil) {
            err = [NSError errorWithDomain:NSStringFromClass([self class]) code:0
                                  userInfo:@{NSLocalizedDescriptionKey: @"No data returned by server"}];
        }
        
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (err && error) {
                error(err);
            } else {
                complete(json);
            }
        });
    });
}
@end