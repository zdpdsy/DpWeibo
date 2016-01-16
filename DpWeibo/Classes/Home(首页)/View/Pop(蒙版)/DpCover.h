//
//  DpCover.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/2.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DpCover;
////定义一个协议
//@protocol DpCoverDelegate <NSObject>
//
//@optional
////点击蒙版的时候调用
//-(void) coverDidClick:(DpCover *) cover;

//定义一个协议
@protocol DpCoverDelegate <NSObject>

@optional
-(void) coverDidClick:(DpCover *)cover;

@end

@interface DpCover : UIView


///**
// *  显示蒙版
// *
// *  @return <#return value description#>
// */
//+(instancetype)show;
//
//// 设置浅灰色蒙板
//@property (nonatomic, assign) BOOL dimBackground;
//
////代理属性
//@property (strong,nonatomic) id<DpCoverDelegate> delegate;

+(instancetype)show;

//设置浅灰色蒙版
@property (assign, nonatomic) BOOL dimBackground;

@property (strong,nonatomic) id<DpCoverDelegate> delegate;

@end
