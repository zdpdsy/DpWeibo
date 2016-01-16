//
//  DpStatusToolBar.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/9.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DpStatus;
@protocol DpStatusToolBarDelegate <NSObject>

@optional
-(void)statusbarClick:(UIButton *)btn WithWeiboId:(NSString *)weiboId;

@end

@interface DpStatusToolBar : UIImageView

@property (strong,nonatomic) DpStatus * status;

@property (strong,nonatomic) id<DpStatusToolBarDelegate> delegate;

@end
