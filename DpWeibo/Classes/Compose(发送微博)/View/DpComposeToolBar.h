//
//  DpComposeToolBar.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/13.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DpComposeToolBar;

//定义协议
@protocol DpComposeToolBarDelegate <NSObject>

@optional
-(void)composeToolBar:(DpComposeToolBar*) toolBar didClickBtn :(NSInteger)index;

@end

@interface DpComposeToolBar : UIView

//代理
@property (strong,nonatomic) id<DpComposeToolBarDelegate> delegate;

@end
