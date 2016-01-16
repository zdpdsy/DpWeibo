//
//  DpBaseStatusCell.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/24.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpStatusDetailCell.h"

#import "DpOriginalView.h"
#import "DpRetweetView.h"
#import "DpRetweetedDock.h"

#import "DpStatusDetailController.h"
#import "DpNavgationController.h"
#import "DpStatusFrame.h"
#import "DpStatus.h"

@interface DpStatusDetailCell ()
@property (weak,nonatomic) DpOriginalView * originalView;

@property (weak,nonatomic) DpRetweetView * retweetView;

@property (weak,nonatomic) DpRetweetedDock * retweetDock;

@end
@implementation DpStatusDetailCell

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
    static NSString * reuseId =@"detailcell";
    
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
    DpRetweetedDock * retweetDock = [[DpRetweetedDock alloc] init];
    
    //[self addSubview:_retweetDock];
    
    //操作条
  
    retweetDock.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    
    CGFloat x = _retweetView.frame.size.width - retweetDock.frame.size.width;
    CGFloat y = _retweetView.frame.size.height - retweetDock.height-5;
    //XLog(@"width:%f height:%f x:%f y:%f",_retweeted.frame.size.width,_retweeted.frame.size.height,x,y);
    //XLog(@"dock width:%f height:%f",dock.frame.size.width, dock.frame.size.height);
    retweetDock.frame = CGRectMake(x, y, 200, 35);
    _retweetDock = retweetDock;
    [_retweetView addSubview:retweetDock];
    
    //监听转发微博的点击 手势
    [_retweetView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRetweetView)]];
}
////显示被转发微博
-(void)showRetweetView
{
    DpStatusDetailController * detail = [[DpStatusDetailController alloc] init];
    detail.status = _retweetDock.status.retweeted_status;//转发微博数据
    
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
-(void)setStatusF:(DpBaseStatusFrame *)statusF
{
    _statusF = statusF;
    //原创微博的frame
    _originalView.frame = statusF.originalViewFrame;
    
    _originalView.statusF = statusF;
    
    //转发微博的frame
    _retweetView.frame = statusF.retweetViewFrame;
    _retweetView.statusF = statusF;
    
   // _retweetDock.frame = statusF.toolBarFrame;
    
    
    _retweetDock.status = statusF.status;
    
//    //工具条的frame
//    _statusToolBar.frame = statusF.toolBarFrame;
//    _statusToolBar.status = statusF.status;
}


@end
