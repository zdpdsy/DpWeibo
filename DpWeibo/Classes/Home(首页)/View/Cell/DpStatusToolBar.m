//
//  DpStatusToolBar.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/9.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpStatusToolBar.h"
#import "DpAttitudeTool.h"
#import "DpStatus.h"
#import "DpAccountTool.h"


@interface DpStatusToolBar()
@property (nonatomic, strong) NSMutableArray *btns;

@property (nonatomic, strong) NSMutableArray *divideVs;

@property (weak,nonatomic) UIButton * retweetBtn;

@property (weak,nonatomic) UIButton * commentBtn;

@property (weak,nonatomic) UIButton * unlikeBtn;
@end


@implementation DpStatusToolBar

#pragma mark - 懒加载
- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)divideVs
{
    if (_divideVs == nil) {
        
        _divideVs = [NSMutableArray array];
    }
    
    return _divideVs;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
         self.image = [UIImage imageWithStretchableName:@"timeline_card_bottom_background"];
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView
{
    //转发
    UIButton * retweetBtn = [self setOneButtonWithTitle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    _retweetBtn = retweetBtn;

    
    //评论
    UIButton * commentBtn = [self setOneButtonWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    _commentBtn = commentBtn;

    
    //赞
    UIButton * unlikeBtn =[self setOneButtonWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    
    _unlikeBtn = unlikeBtn;
    
    //分割按钮
    
    for (int i = 0; i < 2; i++) {
        UIImageView *divideV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:divideV];
        [self.divideVs addObject:divideV];
    }
    
}

-(UIButton *)setOneButtonWithTitle:(NSString *)title image:(UIImage *)image
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //设置title
    [btn setTitle:title forState:UIControlStateNormal];
    //color
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    //设置title的边距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    //设置按钮图片
    [btn setImage:image forState:UIControlStateNormal];
    
    if ([title isEqualToString:@"赞"]) {
        [btn setImage:[UIImage imageNamed:@"timeline_icon_like"] forState:UIControlStateHighlighted];
    }
    [btn addTarget:self action:@selector(toolbarClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = self.btns.count;
    
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;
}


-(void)toolbarClick:(UIButton *)btn
{    
    if ([self.delegate respondsToSelector:@selector(statusbarClick:WithWeiboId:)]) {
        //NSLog(@"开始statustoolbardelegate");
        
        [self.delegate statusbarClick:btn WithWeiboId:_status.idstr];
    }
}

//设置子控件的frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置按钮的frame
    NSInteger count = self.btns.count;
    CGFloat x =0;
    CGFloat y =0;
    CGFloat h = self.height;
    CGFloat w = DpSreenW / count;
    for (int i =0; i<count; i++) {
        x = i*w;
        UIButton * btn = self.btns[i];
        btn.frame = CGRectMake(x, y, w, h);
    }

    int k=1;
    for (UIButton * divide in self.divideVs) {
         UIButton *btn = self.btns[k];
        divide.x = btn.x;
        k++;
    }
}

-(void)setStatus:(DpStatus *)status
{
    _status = status;
    //设置转发数 >10000  20000 1.2W
    
    [self setBtn:_retweetBtn title:status.reposts_count];
    
    //设置评论数
    [self setBtn:_commentBtn title:status.comments_count];

    [self setBtn:_unlikeBtn title:status.attitudes_count];
}

-(void) setBtn:(UIButton *) button title: (int) count
{
    NSString * title =nil;
    if (count) {
        if (count > 10000) {
            CGFloat floatcount=  count *1.0/10000;
            title = [NSString stringWithFormat:@"%.1fw",floatcount];
            title  =[title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else{ //<10000
            title= [NSString stringWithFormat:@"%d",count];
        }
    }
    [button setTitle:title forState:UIControlStateNormal];

}
@end
