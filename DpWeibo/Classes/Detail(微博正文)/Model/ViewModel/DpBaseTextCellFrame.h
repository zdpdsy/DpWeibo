//
//  DpBaseTextCellFrame.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/26.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DpBaseText;

@interface DpBaseTextCellFrame : NSObject

@property (strong,nonatomic) DpBaseText * baseText;

//头像frame
@property (assign, nonatomic) CGRect IconFrame;

//昵称 frame
@property (assign, nonatomic) CGRect NameFrame;

//vip frame
@property (assign, nonatomic) CGRect VipFrame;

//时间 frame
@property (assign, nonatomic) CGRect TimeFrame;

//正文 frame
@property (assign, nonatomic) CGRect TextFrame;

//行高
@property (assign, nonatomic) CGFloat cellHeight;

@end
