//
//  DpStatusDetailCellFrame.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/24.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpStatusDetailCellFrame.h"
#import "DpStatus.h"
@implementation DpStatusDetailCellFrame

-(void)setStatus:(DpStatus *)status
{
    [super setStatus:status];
    
    if (status.retweeted_status) {
        
        CGFloat retX = self.retweetViewFrame.origin.x;
        CGFloat retY = self.retweetViewFrame.origin.y;
        CGFloat w = self.retweetViewFrame.size.width;
        CGFloat h = self.retweetViewFrame.size.height + DpStatusDockHeight;
        self.retweetViewFrame =  CGRectMake(retX, retY, w, h);
        self.cellHeight += DpStatusDockHeight;
    }
}
@end
