//
//  DpDetailHeader.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/25.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DpStatus;
@class DpDetailHeader;

typedef enum{
    DetailHeaderBtnTypeRePost,//转发
    DetailHeaderBtnTypeComment//评论
}DetailHeaderBtnType;

//定义代理方法
@protocol DetailHeaderDelegate <NSObject>

@optional
-(void)detailHeader:(DpDetailHeader *)header btnClick:(DetailHeaderBtnType)index;

@end

@interface DpDetailHeader : UIImageView

- (IBAction)btnClick:(UIButton *)sender;
@property (strong,nonatomic) DpStatus * status;

@property (nonatomic, assign, readonly)DetailHeaderBtnType currentType;

/**
 *  DetailHeaderDelegate的代理属性
 */
@property (weak,nonatomic) id<DetailHeaderDelegate> delegate;

+(instancetype) header;

@end
