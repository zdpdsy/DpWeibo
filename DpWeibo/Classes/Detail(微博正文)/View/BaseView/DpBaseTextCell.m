//
//  DpBaseTextCell.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/26.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpBaseTextCell.h"
#import "DpBaseText.h"
#import "DpBaseTextCellFrame.h"
#import "DpUser.h"

#import "UIImageView+WebCache.h"
@interface DpBaseTextCell()

//头像
@property (weak,nonatomic) UIImageView * iconView;

//昵称
@property (weak,nonatomic) UILabel * nameView;

//vip
@property (weak,nonatomic) UIImageView * vipView;

//时间
@property (weak,nonatomic) UILabel * timeView;


//正文
@property (weak,nonatomic) UILabel * textView;


@end
@implementation DpBaseTextCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //添加子控件
        [self setUpAllChildView];
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
//设置每一行的样式
- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(int)count
{
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selBgView = (UIImageView *)self.selectedBackgroundView;
    NSString *bgName = @"statusdetail_comment_background_middle";
    NSString *selectedBgName = @"statusdetail_comment_background_middle_highlighted";
    
    if (indexPath.row == count - 1){ // 底部
        bgName = @"statusdetail_comment_background_bottom";
        selectedBgName = @"statusdetail_comment_background_bottom_highlighted";
    }
    
    bgView.image = [UIImage imageWithStretchableName:bgName];
    selBgView.image = [UIImage
                       imageWithStretchableName:selectedBgName];
}

+(instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier
{
    
    NSString * reuseId =reuseIdentifier;
    
    id cell =[tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    return cell;
}



-(void) setUpAllChildView
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
    
    //正文
    UILabel * textView = [[UILabel alloc] init];
    textView.font = DpTextFont;
    textView.numberOfLines = 0;//多行
    _textView = textView;
    [self addSubview:textView];
}

-(void)setCellFrame:(DpBaseTextCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    //设置子控件的frame
    [self setUpFrame];
    
    //设置子控件的值
    [self setUpData];
}
/**
 *  设置子控件的frame和自己的frame
 */
-(void) setUpFrame
{
    //头像
    _iconView.frame =_cellFrame.IconFrame;
    
    //昵称
    _nameView.frame =_cellFrame.NameFrame;
    
    //NSLog(@"%@",_statusF.status.user.vip);
    //vip
    if (_cellFrame.baseText.user.vip) {
        _vipView.hidden = NO;
        _vipView.frame = _cellFrame.VipFrame;
    }else{
        _vipView.hidden = YES;
    }
    
    //时间 需要每次重新计算。。因为时刻变动，而frame还是上一次的大小，会导致不够显示
    //时间
    //DpStatus * status = _statusF.status;
    
    CGFloat timeX = _nameView.frame.origin.x;
    
    CGFloat timeY = CGRectGetMaxY( _nameView.frame) + DpStatusCellMargin * 0.5;
    CGSize timeSize =[_cellFrame.baseText.created_at sizeWithFont:DpTimeFont];
    _timeView.frame = (CGRect){{timeX,timeY},timeSize};
    
    
    //正文
    _textView.frame =_cellFrame.TextFrame;
    
}

/**
 *  赋值
 */
-(void)setUpData
{
    DpBaseText * status = _cellFrame.baseText;
    
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
    
    //正文
    _textView.text = status.text;
    
    
}



@end
