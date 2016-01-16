//
//  DpDetailHeader.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/25.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpDetailHeader.h"
#import "DpStatus.h"

@interface DpDetailHeader ()





@property (weak, nonatomic) IBOutlet UIImageView *hint;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UIButton *repost;
@property (weak, nonatomic) IBOutlet UIButton *attitude;

@property (strong,nonatomic) UIButton * selectedBtn;
@end

@implementation DpDetailHeader

+(instancetype)header
{
    return [[NSBundle mainBundle] loadNibNamed:@"DpDetailHeader" owner:nil options:nil][0];
}

-(IBAction)btnClick:(UIButton *)sender
{
      //控制状态
    _selectedBtn.enabled = YES;
    sender.enabled = NO;
    _selectedBtn = sender;
    
    //移动小三角形
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center = _hint.center;
       
        center.x = sender.center.x;
        
        _hint.center = center;
    }];
    
    DetailHeaderBtnType type = (sender == _repost) ? DetailHeaderBtnTypeRePost : DetailHeaderBtnTypeComment;
    
    _currentType = type;
    
    //执行代理方法
    if ([_delegate respondsToSelector:@selector(detailHeader:btnClick:)]) {
        [_delegate detailHeader:self btnClick:type];
    }

}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)awakeFromNib
{
     //self.backgroundColor = [UIColor blackColor];
    [self btnClick:_comment];
}
-(void)setStatus:(DpStatus *)status
{
    _status = status;
    [self setButton:_repost title:@"转发" count:status.reposts_count];
    [self setButton:_comment title:@"评论" count:status.comments_count];
    [self setButton:_attitude title:@"赞" count:status.attitudes_count];
    
}

#pragma mark 设置按钮文字
-(void)setButton:(UIButton *)btn title:(NSString *)title count:(NSInteger)count
{
    if (count >= 10000) {  //上万
        CGFloat final = count / 10000.0;
        title = [NSString stringWithFormat:@"%@ %.1f万", title,final];
        //替换".0"为空串
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [btn setTitle:title forState:UIControlStateNormal];
        
    }else if(count > 0){ //一万以内
        title = [NSString stringWithFormat:@"%@ %ld", title,count];
        [btn setTitle:title forState:UIControlStateNormal];
    }else{ //没有
        [btn setTitle:title forState:UIControlStateNormal];
    }
}
@end
