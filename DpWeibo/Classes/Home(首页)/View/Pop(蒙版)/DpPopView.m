//
//  DpPopView.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/2.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpPopView.h"

@implementation DpPopView
//// 显示弹出菜单
//+ (instancetype)showInRect:(CGRect)rect
//{
//    DpPopView *menu = [[DpPopView alloc] initWithFrame:rect];
//    menu.userInteractionEnabled = YES;
//    menu.image = [UIImage imageWithStretchableName:@"popover_background"];
//    
//    [DpKeyWindow addSubview:menu];
//    
//    return menu;
//}
//
//// 隐藏弹出菜单
//+ (void)hide
//{
//    for (UIView *popMenu in DpKeyWindow.subviews) {
//        if ([popMenu isKindOfClass:self]) {
//            [popMenu removeFromSuperview];
//        }
//    }
//}
//
//// 设置内容视图
//- (void)setContentView:(UIView *)contentView
//{
//    // 先移除之前内容视图
//    [_contentView removeFromSuperview];
//    
//    _contentView = contentView;
//    contentView.backgroundColor = [UIColor clearColor];
//    
//    [self addSubview:contentView];
//    
//    
//}
//
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    // 计算内容视图尺寸
//    CGFloat y = 90;
//    CGFloat margin = 5;
//    CGFloat x = margin;
//    CGFloat w = self.width - 2 * margin;
//    CGFloat h = self.height - y - margin;
//    
//    _contentView.frame = CGRectMake(x, y, w, h);
//    
//}

//设置内容视图
-(void)setContentView:(UIView *)contentView
{
    [_contentView removeFromSuperview];
    _contentView =contentView;
    contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:contentView];

}

+(instancetype)showInRect:(CGRect)rect
{
    DpPopView * popView = [[DpPopView alloc] initWithFrame:rect];
    popView.userInteractionEnabled = YES;//可点击
    popView.image = [UIImage imageWithStretchableName:@"popover_background"];
    [DpKeyWindow addSubview:popView];
    return popView;
    
}
+(void)hide
{
    for (UIView * popView in DpKeyWindow.subviews) {
        if ([popView isKindOfClass:self]) { //找到DpPopView 删除
            [popView removeFromSuperview];
        }
    }
}

//调整子控件的frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    // 计算内容视图尺寸
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;

    _contentView.frame = CGRectMake(x, y, w, h);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
