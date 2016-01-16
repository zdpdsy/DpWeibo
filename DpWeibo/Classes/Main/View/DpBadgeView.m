//
//  DpBadgeView.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/1.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpBadgeView.h"
#import "UIView+Frame.h"
@implementation DpBadgeView

#define DpBadgeViewFont [UIFont systemFontOfSize:11]

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = NO;//不能交互
        //设置小圆点图片
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        //设置字体
        self.titleLabel.font = DpBadgeViewFont;
        
        [self sizeToFit];
    }
    return self;
}

//赋值的时候
-(void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    
    //判断是否隐藏
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
    CGSize size = [badgeValue sizeWithFont:DpBadgeViewFont];//生成文字size
    
    //NSLog(@"%f--%f",size.width,self.width);
    if (size.width > self.width) { // 文字的尺寸大于控件的宽度
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
}
@end
