//
//  DpTitleButton.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/2.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpTitleButton.h"
#import "UIView+Frame.h"
@implementation DpTitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置高亮图片
        [self setBackgroundImage:[UIImage imageNamed:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    }
    return self;
}

//修改子控件的frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.currentImage == nil) {
        return;
    }
    
    //self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}

// 重写setTitle方法，扩展计算尺寸功能
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    //默认会根据按钮的背景图片或者image和文字计算出按钮的最合适的尺寸
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end
