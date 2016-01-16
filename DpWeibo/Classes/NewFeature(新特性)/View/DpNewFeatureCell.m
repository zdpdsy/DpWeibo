//
//  DpNewFeatureCell.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/2.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpNewFeatureCell.h"
#import "DpTabBarController.h"
@interface DpNewFeatureCell()
@property (weak,nonatomic) UIImageView  * imageView;
@property (weak,nonatomic) UIButton  * shareButton;
@property (weak,nonatomic) UIButton * startButton;
@end


@implementation DpNewFeatureCell

-(UIButton *)shareButton
{
    if (!_shareButton) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn sizeToFit];
        
        [self.contentView addSubview:btn];
        
        _shareButton = btn;
    }
    return _shareButton;
}

-(UIButton *)startButton
{
    if (!_startButton) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startBtn sizeToFit];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startBtn];
        _startButton = startBtn;
    }
    return _startButton;
}
-(void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView * imageV = [[UIImageView alloc] init];
        
        _imageView = imageV;
        [self.contentView addSubview:imageV];
    }
    return _imageView;
}
//调整子控件的frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    // 分享按钮
    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.8);
    
    
    // 开始按钮
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.9);
}
// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;
{
    if (indexPath.row == count -1) {//最后一页显示分享和开始按钮
        self.startButton.hidden = NO;
        self.shareButton.hidden = NO;
    }else{
        self.startButton.hidden = YES;
        self.shareButton.hidden = YES;
    }
}
-(void)start
{
    // 进入tabBarVc
    DpTabBarController *tabBarVc = [[DpTabBarController alloc] init];
    
    // 切换根控制器:可以直接把之前的根控制器清空
    DpKeyWindow.rootViewController = tabBarVc;

}
@end
