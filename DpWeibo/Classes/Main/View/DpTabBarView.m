//
//  DpTabBarView.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/11/30.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpTabBarView.h"
#import "DpTabBarButton.h"

@interface DpTabBarView()



//+按钮
@property (nonatomic, weak) UIButton *plusButton;

//选中的按钮
@property (nonatomic, weak) UIButton *selectedBtn;

@property (strong,nonatomic) NSMutableArray * buttons;

@end

@implementation DpTabBarView

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    // 遍历模型数组，创建对应tabBarButton
    for (UITabBarItem *item in _items) {
        
        //自定义按钮
        DpTabBarButton  *btn = [DpTabBarButton  buttonWithType:UIButtonTypeCustom];
        
        // 给按钮赋值模型，按钮的内容由模型对应决定
        btn.item = item;
        
        btn.tag = self.buttons.count;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (btn.tag == 0) { // 选中第0个
            [self btnClick:btn];
            
        }
        
        [self addSubview:btn];
        
        // 把按钮添加到按钮数组
        [self.buttons addObject:btn];
    }
}

// 点击tabBarButton调用
-(void)btnClick:(UIButton *)button
{
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    
    // 通知tabBarVc切换控制器，
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [self.delegate tabBar:self didClickButton:button.tag];
    }
}


-(UIButton *)plusButton
{
    if (!_plusButton) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        _plusButton = btn;
        //监听点击事件
        [btn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        // 默认按钮的尺寸跟背景图片一样大
        // sizeToFit:默认会根据按钮的背景图片或者image和文字计算出按钮的最合适的尺寸
        [btn sizeToFit];
        
        [self addSubview:_plusButton];
    }
    return _plusButton;
}

-(void)plusClick
{
    //model出控制器
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }

}

/*
 1、init初始化不会触发layoutSubviews
 2、addSubview会触发layoutSubviews
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 4、滚动一个UIScrollView会触发layoutSubviews
 5、旋转Screen会触发父UIView上的layoutSubviews事件
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 */
//调整子控件的frame
-(void)layoutSubviews
{
    [super subviews];
    CGFloat W= self.bounds.size.width;
    CGFloat H = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY =0;
    CGFloat btnW = self.bounds.size.width / (self.items.count+1);
    CGFloat btnH = self.bounds.size.height;
    
    int i = 0;
    for (UIView * tabBarButton in self.buttons) {
//        //判断是不是tabban
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"DpTabBarButton")]) {
            if (i == 2) {
                i = 3;
            }
            btnX = i * btnW;
            
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            
            i++;
        //}
    }
    
    self.plusButton.center = CGPointMake(W * 0.5, H*0.5);
    
}
@end
