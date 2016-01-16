//
//  DpBaseStatusFrame.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/24.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpBaseStatusFrame.h"
#import "DpStatus.h"
#import "DpUser.h"

@implementation DpBaseStatusFrame
-(void)setStatus:(DpStatus *)status
{
    _status  = status;
    [self setUpOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    if (status.retweeted_status) {
        //计算转发微博frame
        [self setUpRetweetViewFrame];
        
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    
    //计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = DpSreenW;
    CGFloat toolBarH = 35;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    //计算高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
    
}

#pragma mark  - 计算原创微博frame
-(void)setUpOriginalViewFrame
{
    //头像
    CGFloat imageX = DpStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    //昵称
    
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + DpStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [_status.user.name sizeWithFont:DpNameFont]; //根据值自动算出最适合的size
    
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    //vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame)+DpStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    
    
    
    
    
    
    //正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + DpStatusCellMargin;
    CGFloat textW = DpSreenW - textX;
    
    //设置文字的宽度,高度自动
    CGSize textSize= [_status.text sizeWithFont:DpTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame  = (CGRect){{textX,textY},textSize};
    
    CGFloat originalH = CGRectGetMaxY(_originalTextFrame) + DpStatusCellMargin;
    
    //配图frame
    if (_status.pic_urls.count) {
        CGFloat photosX = imageX;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + DpStatusCellMargin;
        CGSize  photosSize = [self photosSizeWithCount:_status.pic_urls.count];
        _originalPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        originalH = CGRectGetMaxY(_originalPhotosFrame)+DpStatusCellMargin;
    }
    
    
    //原创微博
    CGFloat originalX = 0;
    CGFloat originalY = 10;
    CGFloat originalW = DpSreenW;
    
    
    _originalViewFrame = CGRectMake(originalX, originalY, originalW, originalH);
    
}
#pragma mark - 计算配图的size
- (CGSize)photosSizeWithCount:(int)count
{
    //总列数
    int cols = count == 4?2:3;
    // 获取总行数 = (总个数 - 1) / 总列数 + 1
    int rows = (count-1)/cols +1;
    
    CGFloat photowh = 70;
    CGFloat w = cols*photowh + (cols-1)*DpStatusCellMargin;
    CGFloat h = rows* photowh +(rows-1)*DpStatusCellMargin;
    
    return CGSizeMake(w, h);
}


#pragma mark - 计算转发微博frame
-(void)setUpRetweetViewFrame
{
    //昵称
    CGFloat nameX = DpStatusCellMargin;
    CGFloat nameY = nameX;
    //值 是转发微博的name
    CGSize nameSize = [_status.retweetName sizeWithFont:DpNameFont]; //根据值自动算出最适合的size
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    //正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + DpStatusCellMargin;
    CGFloat textW = DpSreenW - nameX;
    
    //设置文字的宽度,高度自动
    CGSize textSize= [_status.retweeted_status.text sizeWithFont:DpTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retweetTextFrame  = (CGRect){{textX,textY},textSize};
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame)+DpStatusCellMargin;
    
    
    //配图
    if (_status.retweeted_status.pic_urls.count) {
        CGFloat photosX = nameX;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame)+DpStatusCellMargin;
        CGSize  photosSize = [self photosSizeWithCount:_status.retweeted_status.pic_urls.count];
        
        _retweetPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        retweetH = CGRectGetMaxY(_retweetPhotosFrame)+DpStatusCellMargin;
    }
    
    //转发微博frame
    CGFloat retweetX =0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = DpSreenW;
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
}
@end
