//
//  DpBaseTextCellFrame.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/26.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpBaseTextCellFrame.h"
#import "DpBaseText.h"
#import "DpUser.h"


@implementation DpBaseTextCellFrame
-(void)setBaseText:(DpBaseText *)baseText
{
    _baseText = baseText;
    
    //头像frame
    CGFloat iconX = DpStatusCellMargin;
    CGFloat iconY = iconX;
    CGFloat iconW =34;
    CGFloat iconH = 34;
    _IconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //昵称frame
    CGFloat nameX = CGRectGetMaxY(_IconFrame)+DpStatusCellMargin;
    CGFloat nameY = iconY;
    
    CGSize nameSize = [_baseText.user.name sizeWithFont:DpNameFont]; //根据值自动算出最适合的size
    _NameFrame =  (CGRect){{nameX,nameY},nameSize};
    
    //vipframe
    if (_baseText.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_NameFrame)+DpStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _VipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);

    }

    //正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_IconFrame) + DpStatusCellMargin;
    CGFloat textW = DpSreenW - textX;
    
    //设置文字的宽度,高度自动
    CGSize textSize= [_baseText.text sizeWithFont:DpTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _TextFrame  = (CGRect){{textX,textY},textSize};
    
    //行高
    _cellHeight = CGRectGetMaxY(_TextFrame)+DpStatusCellMargin ;
}
@end
