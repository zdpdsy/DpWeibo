//
//  DpTabBarButton.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/1.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpTabBarButton.h"
#import "DpBadgeView.h"
#import "UIView+Frame.h"
#define ImageRidio 0.7
@interface DpTabBarButton ()

@property (weak,nonatomic) DpBadgeView * badgeView;

@end

@implementation DpTabBarButton

//懒加载badgeView
-(DpBadgeView *)badgeView
{
    if (!_badgeView) {
        DpBadgeView * btn  = [DpBadgeView buttonWithType:UIButtonTypeCustom];
        
        _badgeView = btn;
        [self addSubview:btn];
        
    }
    return _badgeView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 设置字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        //图片居中
        self.imageView.contentMode =UIViewContentModeCenter;
        
        //文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}
// 传递UITabBarItem给tabBarButton,给tabBarButton内容赋值
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    // KVO：时刻监听一个对象的属性有没有改变
    // 给谁添加观察者
    // Observer:按钮
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    
}

// 只要监听的属性一有新值，就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    [self setTitle:_item.title forState:UIControlStateNormal];
    
    [self setImage:_item.image forState:UIControlStateNormal];
    
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
    // 设置badgeValue
    self.badgeView.badgeValue = _item.badgeValue;
}

// 修改按钮内部子控件的frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //imageView
    CGFloat imageX =0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * ImageRidio;
    
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    //title
    CGFloat titleX = 0 ;
    CGFloat titleY = imageH-3;
    CGFloat titleW = imageW;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //badgeView
    self.badgeView.x= self.width - self.badgeView.width - 10;
    self.badgeView.y=0;
}
@end
