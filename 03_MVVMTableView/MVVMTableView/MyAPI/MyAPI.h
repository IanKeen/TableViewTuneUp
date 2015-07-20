//
//  MyAPI.h
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^myAPIDidError)(NSError *error);
typedef void(^myAPIDidGetPhotos)(NSArray *json);

@interface MyAPI : NSObject
-(void)getPhotos:(myAPIDidGetPhotos)complete error:(myAPIDidError)error;
@end