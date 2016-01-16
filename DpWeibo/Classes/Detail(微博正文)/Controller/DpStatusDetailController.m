//
//  DpStatusDetailController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/24.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpStatusDetailController.h"
#import "DpStatusFrame.h"
#import "DpStatusDetailCellFrame.h"
#import "DpStatus.h"


#import "DpStatusDetailCell.h"
#import "DpCommentCell.h"
#import "DpRepostCell.h"

#import "DpCommentCellFrame.h"
#import "DpRepostCellFrame.h"

#import "DpDetailHeader.h"
#import "MJRefresh.h"
#import "DpDetailTool.h"
#import "DpBaseText.h"

@interface DpStatusDetailController ()<DetailHeaderDelegate>

@property (strong,nonatomic) DpStatusDetailCellFrame * detailFrame;

@property (strong,nonatomic) DpDetailHeader * detailHeader;

/**
 *  ViewModel = dpcommentcellFrame
 */
@property (strong,nonatomic) NSMutableArray * CommentFrames;

/**
 *  ViewModel = dprepostcellFrame
 */
@property (strong,nonatomic) NSMutableArray * RepostFrames;

@end

@implementation DpStatusDetailController


//懒加载
-(NSMutableArray *)CommentFrames
{
    if (!_CommentFrames) {
        _CommentFrames = [NSMutableArray array];
    }
    return _CommentFrames;
}

-(NSMutableArray *)RepostFrames
{
    if (!_RepostFrames) {
        _RepostFrames  = [NSMutableArray array];
    }
    return _RepostFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"微博正文";
    //self.tableView.backgroundColor =[UIColor blackColor];
    self.tableView.backgroundColor = [UIColor colorWithRed:211/225.0  green:211/225.0 blue:211/225.0 alpha:1];
    //去掉tableview自带的分割线
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;

    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 8, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    
    _detailFrame = [[DpStatusDetailCellFrame alloc] init];
    _detailFrame.status = _status;
    
    if (_detailHeader == nil) {
        DpDetailHeader *header = [DpDetailHeader header];
        header.delegate = self;
        _detailHeader = header;
    }
    
   // NSLog(@"weiboid=%@",_status.idstr);
    //默认选中评论列表
    [self detailHeader:nil btnClick:DetailHeaderBtnTypeComment];
    
    
    [self addRefresh];
}

#pragma mark 添加刷新视图
-(void)addRefresh
{
    id mytableView = self;
    
    [self.tableView addFooterWithCallback:^{
        //上拉加载更多
        if (_detailHeader.currentType == DetailHeaderBtnTypeRePost) {
            [mytableView loadMoreRepost]; //加载更多转发
        }else{
            [mytableView loadMoreComment]; //加载更多评论
        }
    }];
    
    [self.tableView addHeaderWithCallback:^{
        //下拉加载最新
        if (_detailHeader.currentType == DetailHeaderBtnTypeRePost) {
            [mytableView loadNewRepost]; //加载最新转发
        }else{
            [mytableView loadNewComment]; //加载最新评论
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 获取当前需要使用的数据
-(NSMutableArray *)currentFrames
{
    if (_detailHeader.currentType == DetailHeaderBtnTypeComment) {
        return _CommentFrames;
    }else{
        return _RepostFrames;
    }
}


#pragma mark  - DetailHeader的代理方法
-(void)detailHeader:(DpDetailHeader *)header btnClick:(DetailHeaderBtnType)index
{
    //先刷新表格（马上显示对应数据，避免数据迟缓）
    [self.tableView reloadData];
    
    if (index == DetailHeaderBtnTypeRePost) { //点击了转发
        [self loadNewRepost];
    }else if (index == DetailHeaderBtnTypeComment) { //点击了评论
        [self loadNewComment];
    }
}

#pragma mark - TableView的代理方法

//有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

//每组多少个
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0) {
        return 1;
    }else{
        return [[self currentFrames] count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     if (indexPath.section == 0) { //微博详情
         
        DpStatusDetailCell * cell = [DpStatusDetailCell cellWithTableView:tableView];
        
        //数据模型
        DpStatusDetailCellFrame * statusF = self.detailFrame;
        
        cell.statusF = statusF;
        
        return cell;
     }else if(_detailHeader.currentType == DetailHeaderBtnTypeRePost){ //转发
         
         static NSString * reuseId = @"repostcell";
         DpRepostCell * cell = [DpRepostCell cellWithTableView:tableView reuseIdentifier:reuseId];
         
         //数据模型
         DpRepostCellFrame * cellFrame = self.RepostFrames[indexPath.row];
        
         cell.cellFrame = cellFrame;
         [cell setIndexPath:indexPath rowCount:self.RepostFrames.count];

         return cell;
     }else{ //评论
         static NSString * reuseId = @"commentcell";
         DpCommentCell * cell = [DpCommentCell cellWithTableView:tableView reuseIdentifier:reuseId];
         
         //数据模型
         DpCommentCellFrame * cellFrame = self.CommentFrames[indexPath.row];
         cell.cellFrame = cellFrame;
         [cell setIndexPath:indexPath rowCount:self.CommentFrames.count];
         return cell;
     }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return _detailFrame.cellHeight;
    }else{
        return [[self currentFrames][indexPath.row] cellHeight];
    }
   
    
}

#pragma mark section 设置头部显示组件高度，并显示组件
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 60;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    _detailHeader.status = _status;
    return _detailHeader;
}


-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section != 0;
}


#pragma mark - 加载最新的转发
-(void)loadNewRepost
{
    NSString * since_id = nil;
    if (self.RepostFrames.count) {//有最新数据
        DpBaseText * s = [self.RepostFrames[0] baseText];
        since_id = s.idstr;
    }
    [DpDetailTool loadNewRepostWithWeiboId:_status.idstr SinceId:since_id success:^(NSArray *statuses,int totalNumber) {
        // 模型转换视图模型 DpBaseText -> DpBaseTextCellFrame
        NSMutableArray *baseFrames = [NSMutableArray array];
        for (DpBaseText * bText in statuses) {
            
            DpBaseTextCellFrame *statusF = [[DpRepostCellFrame alloc] init];
            
            statusF.baseText = bText;
            
            [baseFrames addObject:statusF];
        }
        //更新微博转发数据计数
        _status.reposts_count = totalNumber;
        
        //吧数据加到最前面
        NSIndexSet * indexSet  = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        
        [self.RepostFrames insertObjects:baseFrames atIndexes:indexSet];
        
        //重新加载
        [self.tableView reloadData];
        
       
        [self.tableView headerEndRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"loadnewpost error =%@",error);
    }];
}

#pragma mark - 加载更多的转发数据
-(void)loadMoreRepost
{
    NSString * max_id = nil;
    if (self.RepostFrames.count) {//有最新数据
        DpBaseText * s = [[self.RepostFrames lastObject] baseText];
        long long maxId = [s.idstr longLongValue]-1;
        max_id = [NSString stringWithFormat:@"%lld",maxId];
    }
    [DpDetailTool loadMoreRepostWithWeiboId:_status.idstr MaxId:max_id success:^(NSArray *statuses,int totalNumber) {
        // 模型转换视图模型 DpBaseText -> DpBaseTextCellFrame
        NSMutableArray *baseFrames = [NSMutableArray array];
        for (DpBaseText * bText in statuses) {
            
            DpBaseTextCellFrame *statusF = [[DpRepostCellFrame alloc] init];
            
            statusF.baseText = bText;
            
            [baseFrames addObject:statusF];
        }
        
        //更新微博评论数据计数
        _status.reposts_count = totalNumber;
        
        //吧数据加到最后面
        [self.RepostFrames addObjectsFromArray:baseFrames];
        
        //重新加载
        [self.tableView reloadData];
       
        [self.tableView footerEndRefreshing];
        
    } failure:^(NSError *error) {
        [self.tableView footerEndRefreshing];
        NSLog(@"loadnewcomment error =%@",error);
    }];
}

#pragma mark - 加载最新的评论
-(void) loadNewComment
{
    NSString * since_id = nil;
    if (self.CommentFrames.count) {//有最新数据
        DpBaseText * s = [self.CommentFrames[0] baseText];
        since_id = s.idstr;
    }
    [DpDetailTool loadNewCommentWithWeiboId:_status.idstr SinceId:since_id success:^(NSArray *statuses,int totalNumber) {
        // 模型转换视图模型 DpBaseText -> DpBaseTextCellFrame
        NSMutableArray *baseFrames = [NSMutableArray array];
        for (DpBaseText * bText in statuses) {
            
            DpBaseTextCellFrame *statusF = [[DpCommentCellFrame alloc] init];
            
            statusF.baseText = bText;
            
            [baseFrames addObject:statusF];
        }
        
        //更新微博评论数据计数
        _status.comments_count = totalNumber;
        
        //吧数据加到最前面
        NSIndexSet * indexSet  = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        
        [self.CommentFrames insertObjects:baseFrames atIndexes:indexSet];
        
        //重新加载
        [self.tableView reloadData];
        
        //[_headerView endRefreshing];
       
        [self.tableView headerEndRefreshing];
        
    } failure:^(NSError *error) {
        [self.tableView headerEndRefreshing];
        NSLog(@"loadnewcomment error =%@",error);
    }];
}

#pragma mark - 加载更多的评论数据
-(void) loadMoreComment
{
    NSString * max_id = nil;
    if (self.CommentFrames.count) {//有最新数据
        DpBaseText * s = [[self.CommentFrames lastObject] baseText];
        long long maxId = [s.idstr longLongValue]-1;
        max_id = [NSString stringWithFormat:@"%lld",maxId];
    }
    [DpDetailTool loadMoreCommentWithWeiboId:_status.idstr MaxId:max_id success:^(NSArray *statuses,int totalNumber) {
        // 模型转换视图模型 DpBaseText -> DpBaseTextCellFrame
        NSMutableArray *baseFrames = [NSMutableArray array];
        for (DpBaseText * bText in statuses) {
            
            DpBaseTextCellFrame *statusF = [[DpCommentCellFrame alloc] init];
            
            statusF.baseText = bText;
            
            [baseFrames addObject:statusF];
        }
        
        //更新微博评论数据计数
        _status.comments_count = totalNumber;
        
        //吧数据加到最后面
        [self.CommentFrames addObjectsFromArray:baseFrames];
        
        //重新加载
        [self.tableView reloadData];

       [self.tableView footerEndRefreshing];//结束上啦控件
        
    } failure:^(NSError *error) {
        [self.tableView footerEndRefreshing];//结束上啦控件
        NSLog(@"loadnewcomment error =%@",error);
    }];
}
@end
