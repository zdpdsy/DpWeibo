//
//  DpPopView.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/2.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface DpPopView : UIImageView
///**
// *  显示弹出菜单
// */
//+ (instancetype)showInRect:(CGRect)rect;
//
///**
// *  隐藏弹出菜单
// */
//+ (void)hide;
//
//// 内容视图
//@property (nonatomic, weak) UIView *contentView;
//@end
@interface DpPopView : UIImageView
/**
 *  弹出菜单
 *
 *  @param rect <#rect description#>
 *
 *  @return <#return value description#>
 */
+(instancetype) showInRect:(CGRect)rect;

//隐藏菜单
+(void)hide;

//内容视图
@property (strong,nonatomic) UIView * contentView;
@end