//
//  TableCell.m
//
//  Created by Ian Keen on 14/07/2015.
//  Copyright (c) 2015 Mustard. All rights reserved.
//

#import "TableCell.h"
#import "VCTableCellData.h"

@interface TableCell ()
@property (nonatomic, weak) IBOutlet UILabel *cellTitle;
@property (nonatomic, weak) IBOutlet UIImageView *cellImage;
@end

@implementation TableCell
-(void)setup:(VCTableCellData *)data {
    self.cellTitle.text = [NSString stringWithFormat:@"Entry ID: %@", data.id];
    self.cellImage.image = nil;
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:data.url]];
    UIImage *image = [UIImage imageWithData:imageData];
    self.cellImage.image = image;
}
@end
