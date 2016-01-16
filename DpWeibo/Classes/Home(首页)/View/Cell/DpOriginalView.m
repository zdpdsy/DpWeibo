//
//  DpOriginalView.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/9.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpOriginalView.h"
#import "DpBaseStatusFrame.h"
#import "DpPhotosView.h"
#import "DpStatus.h"
#import "UIImageView+WebCache.h"

@interface DpOriginalView()

//头像
@property (weak,nonatomic) UIImageView * iconView;

//昵称
@property (weak,nonatomic) UILabel * nameView;

//vip
@property (weak,nonatomic) UIImageView * vipView;

//时间
@property (weak,nonatomic) UILabel * timeView;

//来源
@property (weak,nonatomic) UILabel * sourceView;

//正文
@property (weak,nonatomic) UILabel * textView;

//配图
@property (weak,nonatomic) DpPhotosView * photosView;

@end


@implementation DpOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView
{
    //头像
    UIImageView * iconView = [[UIImageView alloc] init];
    _iconView = iconView;
    [self addSubview:iconView];
    
    //昵称
    UILabel * nameView = [[UILabel alloc] init];
    nameView.font = DpNameFont;
    _nameView = nameView;
    [self addSubview:nameView];
    
    //vip
    UIImageView * vipView = [[UIImageView alloc] init];
    _vipView = vipView;
    [self addSubview:vipView];
    
    
    //时间
    UILabel * timeView = [[UILabel alloc] init];
    timeView.font = DpTimeFont;
    timeView.textColor = [UIColor orangeColor];
    _timeView = timeView;
    [self addSubview:timeView];
    
    //来源
    
    UILabel * sourceView  = [[UILabel alloc] init];
    sourceView.font = DpSourceFont;
    sourceView.textColor =[UIColor lightGrayColor];
    _sourceView = sourceView;

    [self addSubview:sourceView];
    
    //正文
    UILabel * textView = [[UILabel alloc] init];
    textView.font = DpTextFont;
    textView.numberOfLines = 0;//多行
    _textView = textView;
    [self addSubview:textView];
    
    //配图
    DpPhotosView * photosView = [[DpPhotosView alloc] init];
   // photosView.backgroundColor = [UIColor redColor];
    _photosView = photosView;
    [self addSubview:photosView];
    
    
}

-(void)setStatusF:(DpBaseStatusFrame *)statusF
{
    _statusF = statusF;
    
    
    [self setUpFrame];
    
    [self setUpData];
}

/**
 *  设置子控件的frame和自己的frame
 */
-(void) setUpFrame
{
    //头像
    _iconView.frame = _statusF.originalIconFrame;
    
    //昵称
    _nameView.frame =_statusF.originalNameFrame;
    
    //NSLog(@"%@",_statusF.status.user.vip);
    //vip
    if (_statusF.status.user.vip) {
        _vipView.hidden = NO;
        _vipView.frame = _statusF.originalVipFrame;
    }else{
        _vipView.hidden = YES;
    }
    
    //时间 需要每次重新计算。。因为时刻变动，而frame还是上一次的大小，会导致不够显示
    //时间
     DpStatus * status = _statusF.status;
    
    CGFloat timeX = _nameView.frame.origin.x;
    
    CGFloat timeY = CGRectGetMaxY( _nameView.frame) + DpStatusCellMargin * 0.5;
    CGSize timeSize =[status.created_at sizeWithFont:DpTimeFont];
     _timeView.frame = (CGRect){{timeX,timeY},timeSize};
    

    
    //来源 也要每次重新计算 依赖于时间的frame
    CGFloat sourceX = CGRectGetMaxX( _timeView.frame ) + DpStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:DpSourceFont];
    _sourceView.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    
    //正文
    _textView.frame = _statusF.originalTextFrame;
    
    
    //配图
    _photosView.frame = _statusF.originalPhotosFrame;
}

/**
 *  赋值
 */
-(void)setUpData
{
    DpStatus * status = _statusF.status;
    
    //头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 昵称
    if (status.user.vip) {
        _nameView.textColor = [UIColor redColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    _nameView.text = status.user.name;
    
    //vip
    NSString * imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    
    _vipView.image = [UIImage imageNamed:imageName];
    
    
    
    _timeView.text = status.created_at;
    
    
    //来源
    _sourceView.text = status.source;
    
    
    //正文
    _textView.text = status.text;
    
    _photosView.pic_urls = status.pic_urls;
    
}

@end
