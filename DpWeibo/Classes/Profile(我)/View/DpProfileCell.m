//
//  DpProfileCell.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/14.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpProfileCell.h"

@implementation DpProfileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 5;
   // NSLog(@"sub.x = %ld",self.detailTextLabel.x);
}
@end
