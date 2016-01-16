//
//  DpOptionStatusToolBar.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/27.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpOptionStatusToolBar.h"

@implementation DpOptionStatusToolBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self  =  [super initWithFrame:frame]) {
        //添加所有子控件
        [self SetUpAllChildView];
    }
    return self;
}

-(void)SetUpAllChildView
{

    //提及@
    [self setUpBtnWithImage:[UIImage imageNamed:@"compose_mentionbutton_background"]
                  highImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    //热门话题
    [self setUpBtnWithImage:[UIImage imageNamed:@"compose_trendbutton_background"] highImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"]
                     target:self action:@selector(btnClick:)];
    
    //表情
    [self setUpBtnWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background"]
                  highImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] target:self action:@selector(btnClick:)];
    
    //键盘
    [self setUpBtnWithImage:[UIImage imageNamed:@"compose_keyboardbutton_background"]
                  highImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] target:self action:@selector(btnClick:)];
}

-(void) setUpBtnWithImage:(UIImage *) image highImage:(UIImage *) highImage target:(id)target action:(SEL)action

{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    btn.tag = self.subviews.count;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
}
-(void)btnClick:(UIButton *) btn
{
    //点击工具条的时候
}

//设置子控件的frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    int k=0;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width/count;
    CGFloat h = self.height;
    for (UIButton * btn in self.subviews) {
        x = k*w;
        btn.frame =  CGRectMake(x, y, w, h);
        k++;
    }
}
@end
