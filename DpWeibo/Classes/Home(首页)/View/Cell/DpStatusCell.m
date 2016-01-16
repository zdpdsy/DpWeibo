//
//  DpStatusCell.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/9.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpStatusCell.h"
#import "DpOriginalView.h"
#import "DpRetweetView.h"
#import "DpStatusToolBar.h"
#import "DpNavgationController.h"
#import "DpComposeViewController.h"

#import "DpCommentController.h"
#import "DpRepostController.h"
#import "DpStatusDetailController.h"
#import "DpStatusFrame.h"
#import "DpStatus.h"
@interface DpStatusCell()

@property (weak,nonatomic) DpOriginalView * originalView;

@property (weak,nonatomic) DpRetweetView * retweetView;



@end

@implementation DpStatusCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //添加子控件
        [self setUpAllChildView];
        
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString * reuseId =@"cell";
    
    id cell =[tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
        
    }
    return cell;
}

-(void)setUpAllChildView
{
    //原创微博
    DpOriginalView * originalView = [[DpOriginalView alloc] init];
    _originalView = originalView;
    
    [self addSubview:originalView];
    
    //转发微博
    DpRetweetView * retweetView = [[DpRetweetView alloc] init];
    _retweetView = retweetView;
    
    [self addSubview:_retweetView];
    
    //工具条
    DpStatusToolBar * statusToolBar = [[DpStatusToolBar alloc] init];
    statusToolBar.userInteractionEnabled = YES;
    _statusToolBar = statusToolBar;
    [self addSubview:statusToolBar];
    
    //监控转发微博的点击
    [_retweetView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRetweetView)]];
}

////显示被转发微博
-(void)showRetweetView
{
    DpStatusDetailController * detail = [[DpStatusDetailController alloc] init];
    
    detail.status = _statusF.status.retweeted_status;//转发微博数据
    
    //跳转
    UINavigationController * currentNav= [self getCurrentNavigationController];
    
    [currentNav pushViewController:detail animated:YES];
    
}

//获取当前控制器的导航控制器

- (UINavigationController*)getCurrentNavigationController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController*)nextResponder;
        }
    }
    return nil;
}
/*
 问题：1.cell的高度应该提前计算出来
 2.cell的高度必须要先计算出每个子控件的frame，才能确定
 3.如果在cell的setStatus方法计算子控件的位置，会比较耗性能
 
 解决:MVVM思想
 M:模型
 V:视图
 VM:视图模型（模型包装视图模型，模型+模型对应视图的frame）
 
 
 */
-(void)setStatusF:(DpStatusFrame *)statusF
{
    _statusF = statusF;
    //原创微博的frame
    _originalView.frame = statusF.originalViewFrame;
    _originalView.statusF = statusF;
    
    //转发微博的frame
    _retweetView.frame = statusF.retweetViewFrame;
    _retweetView.statusF = statusF;
    
    //工具条的frame
    _statusToolBar.frame = statusF.toolBarFrame;
    _statusToolBar.status = statusF.status;
}



@end
