//
//  DpRetweetedDock.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/24.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpRetweetedDock.h"
#import "UIImage+image.h"
#import "NSString+string.h"
#import "DpStatus.h"
@interface DpRetweetedDock ()

//转发按钮
@property (weak,nonatomic) UIButton * repostBtn;

//评论按钮
@property (weak,nonatomic) UIButton * commentBtn;

//赞按钮
@property (weak,nonatomic) UIButton * attitueBtn;

@end

@implementation DpRetweetedDock

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加三个按钮
        [self setUpAllChildView];
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    frame.size.width = 220;
    frame.size.height = 35;
    //frame.origin.x = DpSreenW - frame.size.width;
    
    [super setFrame:frame];
}

-(void)setUpAllChildView
{
    //1.添加3个按钮
    _repostBtn = [self addButton:@"转发" icon:@"timeline_icon_retweet.png" backgroundImageName:@"timeline_card_leftbottom.png" index:0];
    _commentBtn = [self addButton:@"评论" icon:@"timeline_icon_comment.png" backgroundImageName:@"timeline_card_middlebottom.png" index:1];
    _attitueBtn = [self addButton:@"赞" icon:@"timeline_icon_unlike.png" backgroundImageName:@"timeline_card_rightbottom.png" index:2];

}
-(UIButton *)addButton:(NSString *)title icon:(NSString *)icon backgroundImageName:(NSString *)background index:(int)index
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置体表
    [btn setTitle:title forState:UIControlStateNormal];
    
    //设置icon
    
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    
    //设置图标
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    
    //设置普通背景
    [btn setBackgroundImage:[UIImage resizedImage:background] forState:UIControlStateNormal];
    
    //设置高亮背景
    [btn setBackgroundImage:[UIImage resizedImage:[background fileAppend:@"_highlighted"]] forState:UIControlStateHighlighted];
    
    //设置文字颜色
    [btn setTitleColor:DpColor(188, 188, 188) forState:UIControlStateNormal];
    //设置字体大小
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    //设置按钮frame
    CGFloat w = self.frame.size.width / 3;
    btn.frame = CGRectMake(index * w, 0, w, DpStatusDockHeight);
    
    //文字左边会空出10的距离，调节按钮文字与图片的间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, DpTitleLeftEdgeInsets, 0, 0);
    
    [self addSubview:btn];
    
    if (index) { //index!=0，添加分割线图片
        UIImage *image = [UIImage imageNamed:@"timeline_card_bottom_line.png"];
        UIImageView *divider = [[UIImageView alloc]initWithImage:image];
        divider.center = CGPointMake(btn.frame.origin.x, DpStatusDockHeight * 0.5);
        [self addSubview:divider];
    }
    
    return btn;
}

-(void)setStatus:(DpStatus *)status
{
    _status = status;
    //1.转发微博 的转发
    [self setButton:_repostBtn title:@"0" count:status.retweeted_status.reposts_count];
    
    //2.转发微博的评论
    [self setButton:_commentBtn title:@"0" count:status.retweeted_status.comments_count];
    
    //3.转发微博的赞
    [self setButton:_attitueBtn title:@"0" count:status.retweeted_status.attitudes_count];

}

#pragma mark 设置按钮文字
-(void)setButton:(UIButton *)btn title:(NSString *)title count:(NSInteger)count
{
    if (count >= 10000) {  //上万
        CGFloat final = count / 10000.0;
        title = [NSString stringWithFormat:@"%.1f万", final];
        //替换".0"为空串
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [btn setTitle:title forState:UIControlStateNormal];
        
    }else if(count > 0){ //一万以内
        title = [NSString stringWithFormat:@"%ld", count];
        [btn setTitle:title forState:UIControlStateNormal];
    }else{ //没有
        [btn setTitle:title forState:UIControlStateNormal];
    }
}


@end
