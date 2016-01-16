//
//  DpTabBarView.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/11/30.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
//定义一个协议
@class DpTabBarView;

@protocol DpTabBarDelegate <NSObject>

@optional
- (void)tabBar:(DpTabBarView *)tabBar didClickButton:(NSInteger)index;

/**
 *  点击+号按钮的时候调用
 *
 *  @param tabbar <#tabbar description#>
 */
-(void)tabBarDidClickPlusButton:(DpTabBarView *) tabbar;

@end


@interface DpTabBarView : UIView

// items:保存每一个按钮对应tabBarItem模型
@property (nonatomic, strong) NSArray * items;

//定义代理属性
@property (weak,nonatomic) id<DpTabBarDelegate> delegate;

@end



