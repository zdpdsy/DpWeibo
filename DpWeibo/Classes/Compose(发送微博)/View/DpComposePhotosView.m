//
//  DpComposePhotosView.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/13.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpComposePhotosView.h"

@implementation DpComposePhotosView

-(void)setImage:(UIImage *)image
{
    _image = image;
    
    UIImageView * imageV = [[UIImageView alloc] init];
    imageV.image = image;
    [self addSubview:imageV];
}

//设置子控件的frame 每添加一个子控件的时候也会调用，特殊如果在viewDidLoad添加子控件，就不会调用layoutSubviews
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    //总列数
    int cols = 3;

    CGFloat x =0;
    CGFloat y =0;
    CGFloat row= 0;
    CGFloat col = 0;
    
    CGFloat margin = 10;
    
    CGFloat wh = (self.width - (cols-1)*margin)/cols;
    
    for (int i =0; i<self.subviews.count; i++) {
        col = i%cols;
        row = i/cols;
        
        x = col*(wh+margin);
        y = row*(wh+margin);
        
        UIImageView * imageV = self.subviews[i];
        imageV.frame = CGRectMake(x, y, wh, wh);
    }
    
}
@end
