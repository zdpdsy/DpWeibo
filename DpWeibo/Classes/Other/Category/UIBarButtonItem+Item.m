//
//  UIBarButtonItem+Item.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/2.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)
+(UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:controlEvents];
    [btn sizeToFit];//默认会根据按钮的背景图片或者image和文字计算出按钮的最合适的尺寸
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    
}
@end
