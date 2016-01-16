//
//  DpCover.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/2.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpCover.h"

@implementation DpCover

////重写蒙版颜色
//-(void)setDimBackground:(BOOL)dimBackground
//{
//    _dimBackground = dimBackground;
//    if (_dimBackground) {
//        self.backgroundColor = [UIColor blackColor];
//        self.alpha = 0.5;
//    }else{
//        self.alpha = 1;
//        self.backgroundColor = [UIColor clearColor];
//    }
//
//}
//+(instancetype)show
//{
//    DpCover * cover = [[DpCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    cover.backgroundColor = [UIColor clearColor];
//    
//    [DpKeyWindow addSubview:cover];
//    return cover;
//}
//
////点击蒙版的时候调用
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    //移除蒙版
//    [self removeFromSuperview];
//    
//    //通知代理移除菜单
//    if ([self.delegate respondsToSelector:@selector(coverDidClick:)]) {
//        [self.delegate coverDidClick:self];
//    }
//}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //移除遮罩层
    [self removeFromSuperview];
    
    //通知代理移除菜单
    if ([self.delegate respondsToSelector:@selector(coverDidClick:)]) {
        [self.delegate coverDidClick:self];
    }

}
//重写蒙版颜色的setter方法
-(void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    
    if (_dimBackground) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
    }else{
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
    }
}

+(instancetype)show
{
    //设置蒙版大小=屏幕的大小
    DpCover * cover = [[DpCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    [DpKeyWindow addSubview:cover];//加入到uiwindow中
    return cover;
    
}
@end
