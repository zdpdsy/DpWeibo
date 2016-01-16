//
//  DpRetweetView.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/9.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpRetweetView.h"
#import "DpStatus.h"
#import "DpPhotosView.h"
#import "DpBaseStatusFrame.h"
@interface DpRetweetView()
//昵称
@property (weak,nonatomic) UILabel * nameView;

//正文
@property (weak,nonatomic) UILabel * textView;

//配图
@property (weak,nonatomic) DpPhotosView * photosView;
@end

@implementation DpRetweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView
{
    //昵称
    UILabel * nameView = [[UILabel alloc] init];
    nameView.textColor = [UIColor blueColor];
    nameView.font = DpNameFont;
    _nameView = nameView;
    [self addSubview:nameView];
    
    //正文
    UILabel * textView = [[UILabel alloc] init];
   
    textView.font = DpTextFont;
    textView.numberOfLines = 0;//多行
     _textView =textView;
    [self addSubview:textView];
    
    //配图
    DpPhotosView * photosView = [[DpPhotosView alloc] init];
    //photosView.backgroundColor = [UIColor blueColor];
    _photosView = photosView;
    [self addSubview:photosView];
}

-(void)setStatusF:(DpBaseStatusFrame *)statusF
{
    _statusF = statusF;
    
    [self setUpFrame];
    
    [self setUpData];
}

-(void) setUpFrame
{
    _nameView.frame = _statusF.retweetNameFrame;
    _textView.frame = _statusF.retweetTextFrame;
    _photosView.frame = _statusF.retweetPhotosFrame;
}

-(void)setUpData
{
    DpStatus * status =_statusF.status;
    
    _nameView.text =status.retweetName;
    
    _textView.text = status.retweeted_status.text;
    
    _photosView.pic_urls = status.retweeted_status.pic_urls;
}
@end
