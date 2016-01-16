//
//  DpHomeViewController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/1.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpHomeViewController.h"
#import "DpOneViewController.h"
#import "DpTwoViewController.h"
#import "DpTitleButton.h"
#import "DpCover.h"
#import "DpPopView.h"

#import "AFNetworking.h"

#import "MJExtension.h"
#import "UIImageView+WebCache.h"

#import "MJRefresh.h"

#import "DpStatus.h"
#import "DpUser.h"

#import "DpHttpTool.h"
#import "DpStatusTool.h"
#import "DpUserTool.h"

#import "DpAccountTool.h"
#import "DpAccount.h"

#import "DpStatusCell.h"
#import "DpStatusFrame.h"

#import "DpStatusDetailController.h"
#import "DpStatusToolBar.h"
#import "DpRepostController.h"
#import "DpCommentController.h"
#import "DpNavgationController.h"
#import "DpAttitudeTool.h"

#import "DpScanController.h"
#import "MBProgressHUD+MJ.h"
@interface DpHomeViewController ()<DpCoverDelegate,DpStatusToolBarDelegate>
@property (nonatomic, weak) DpTitleButton *titleButton;

@property (nonatomic, strong) DpOneViewController *one;

/*
 viewModel:DpStatusFrame
 */
@property (strong,nonatomic) NSMutableArray * statusFrames;
@end

@implementation DpHomeViewController

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (DpOneViewController *)one
{
    if (_one == nil) {
        _one = [[DpOneViewController alloc] init];
    }
    
    return _one;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tableView.backgroundColor =[UIColor blackColor];
    self.tableView.backgroundColor = [UIColor colorWithRed:211/225.0  green:211/225.0 blue:211/225.0 alpha:1];
    //去掉tableview自带的分割线
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    
    //设置导航条tarbar
    [self setUpNavgationBar];
    
    //添加下拉刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
    //开始自动刷新
    [self.tableView headerBeginRefreshing];
    
    //添加上拉加载更多控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    [self setUpUserName];
    
}

/**
 设置title为当前登陆用户的用户名
 */
-(void)setUpUserName
{
     // 一开始展示之前的微博名称，然后在发送用户信息请求，直接赋值
    [DpUserTool userInfoWithSuccess:^(DpUser *user) {
        
        [_titleButton setTitle:user.name forState:UIControlStateNormal];
        
        //获取当前的账号
        DpAccount * account = [DpAccountTool account];
        account.name = user.name;
        [DpAccountTool saveAccount:account];
        
    } failure:^(NSError *error) {
        DpLog(@"%@",error);
    }];
}

/**
 *  设置导航栏按钮
 */
-(void)setUpNavgationBar
{
    //左边
    UIBarButtonItem * leftItem =[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右边
    UIBarButtonItem * rightItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(scanMenu) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    //中间 titleView 自定义一个按钮
    DpTitleButton * titleButton = [DpTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    self.navigationItem.titleView = titleButton;
    
    
}

-(void)titleClick:(UIButton * ) btn
{
    btn.selected = !btn.selected;
    //弹出一个遮罩层
    DpCover * cover = [DpCover show];
    //设置代理
    cover.delegate = self;
    
    //弹出pop菜单
    CGFloat popW=200;
    CGFloat popX = (self.view.width-200)*0.5;
    CGFloat popY=55;
    CGFloat popH = popW;
    
    DpPopView * menu = [DpPopView showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.one.view;
}

//scanMenu
-(void)scanMenu
{
//   // NSLog(@"popshghgh");
//    //跳转到另外一个控制器
//    
//    //创建one控制器
//    DpTwoViewController * two = [[DpTwoViewController alloc] initWithNibName:nil bundle:[NSBundle mainBundle]];
//    
//    
//    [self.navigationController pushViewController:two animated:YES];
//    
//    
//    
//     [_titleButton setImage:nil forState:UIControlStateNormal];
    
    DpLog(@"扫描二维码");
    DpScanController *scanController = [[DpScanController alloc] init];
    [self.navigationController pushViewController:scanController animated:YES];
}

//添加好友
-(void)friendsearch
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 蒙版的代理方法
-(void)coverDidClick:(DpCover *)cover
{
    DpLog(@"调用蒙版的方法...");
    // 隐藏pop菜单
    [DpPopView hide];
    
    _titleButton.selected = NO;
}


#pragma mark - 刷新最新的微博
- (void)refresh{
    
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
}

#pragma mark - 上下加载更多下拉刷新
/**
 *  下拉刷新
 */
-(void) loadNewStatus
{
    
    NSString * since_id = nil;
    if (self.statusFrames.count) {//有最新数据
        DpStatus * s = [self.statusFrames[0] status];
        since_id = s.idstr;
    }
    
    [DpStatusTool loadNewStatusWithSinceId:since_id success:^(NSArray *statuses) {
        //展示最新的微博数
        [self showNewStatusCount:statuses.count];
        
        //停止下拉刷新控件
        [self.tableView headerEndRefreshing];
        
        // 模型转换视图模型 DpStatus -> DpStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (DpStatus *status in statuses) {
            DpStatusFrame *statusF = [[DpStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        
        //吧数据加到最前面
        NSIndexSet * indexSet  = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        
        [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];
        
        //重新加载
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        //停止下拉刷新控件
        [self.tableView headerEndRefreshing];
        [MBProgressHUD showError:@"啊哦，鹏哥加载不出来旧数据，sorry"];
        NSLog(@"error ,msg = %@",error);
    }];
    
    
//    NSString * url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
//    
//    NSMutableDictionary * params = [NSMutableDictionary dictionary];
//    
//    params[@"access_token"] = [DpAccountTool account].access_token;
    
   
    
    //第二种写法
//    [DpHttpTool Get:url parameters:params success:^(id responseObject) {
//        //停止下拉刷新控件
//        [self.tableView headerEndRefreshing];
//
//        //把数据转成模型
//        //1.获取字典数组
//        NSArray * dictArr  = responseObject[@"statuses"];
//
//        //2.字典数据转成模型
//        NSArray * statuses = (NSMutableArray *)[DpStatus objectArrayWithKeyValuesArray:dictArr];
//
//        //吧数据加到最前面
//        NSIndexSet * indexSet  = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
//
//        [self.statuses insertObjects:statuses atIndexes:indexSet];
//        
//        //重新加载
//        [self.tableView reloadData];
//        
//    } failure:^(NSError *error) {
//        NSLog(@"error ,msg = %@",error);
//    }];
    
    //第一种写法
//    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
//    
//    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //停止下拉刷新控件
//        [self.tableView headerEndRefreshing];
//        
//        //把数据转成模型
//        //1.获取字典数组
//        NSArray * dictArr  = responseObject[@"statuses"];
//        
//        //2.字典数据转成模型
//        NSArray * statuses = (NSMutableArray *)[DpStatus objectArrayWithKeyValuesArray:dictArr];
//        
//        //吧数据加到最前面
//        NSIndexSet * indexSet  = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
//        
//        [self.statuses insertObjects:statuses atIndexes:indexSet];
//        
//        //重新加载
//        [self.tableView reloadData];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"error ,msg = %@",error);
//    }];
    
}

/**
 *  显示最新的微博数 label
 */
-(void)showNewStatusCount:(int) count
{
    if (count == 0) {
        return;
    }
    CGFloat x =0;
   
    CGFloat lableh=35;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - lableh;
    
    CGFloat lablew = self.view.width;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, lablew, lableh)];
    
    //设置背景色
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    //设置文字颜色
    label.textColor = [UIColor whiteColor];
    
    //文子句中
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"最新微博数%d",count];
    
    //插入到导航控制器下导航条下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //设置动画效果 往下平移
    [UIView animateWithDuration:0.25 animations:^{
        
        //向下平移
        label.transform = CGAffineTransformMakeTranslation(0, lableh);
        
    } completion:^(BOOL finished) {
        
        //往上平移
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
             //还原
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];//完成后移除lable
        }];
    }];
}


/**
 *  上下加载更多
 */
-(void)loadMoreStatus
{
    NSString * max_id = nil;
    if (self.statusFrames.count) {
        DpStatus *s = [[self.statusFrames lastObject] status];
        long long maxId = [s.idstr longLongValue]-1;
        max_id= [NSString stringWithFormat:@"%lld",maxId];
    }
    //第三种写法
    [DpStatusTool loadMoreStatusWithMaxId:max_id success:^(NSArray *statuses) {
        
        //停止上拉加载控件
        [self.tableView footerEndRefreshing];

        // 模型转换视图模型 DpStatus -> DpStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (DpStatus *status in statuses) {
            DpStatusFrame *statusF = [[DpStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        
        //把数据加载到最后
        [self.statusFrames addObjectsFromArray:statusFrames];

        //刷新
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        //停止上拉加载控件
        [self.tableView footerEndRefreshing];
         [MBProgressHUD showError:@"啊哦，鹏哥加载不出来上拉数据，sorry"];
         DpLog(@"error msg =%@",error);
    }];
    
    
    //第二种写法
    
//    NSString * url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
//    
//    NSMutableDictionary * params = [NSMutableDictionary dictionary];
//    
//    params[@"access_token"] = [DpAccountTool account].access_token;
//    
//    if (self.statuses.count) {
//        long long maxId = [[[self.statuses lastObject] idstr] longLongValue]-1;
//        params[@"max_id"] = [NSString stringWithFormat:@"%lld",maxId];
//    }
//    
//    //http请求工具类
//    [DpHttpTool Get:url parameters:params success:^(id responseObject) {
//        //停止上拉加载控件
//        [self.tableView footerEndRefreshing];
//        
//        //数据转模型
//        //1.获取字典数据
//        NSArray * dictArr = responseObject[@"statuses"];
//        
//        //1.字典转模型
//        NSArray * status = (NSMutableArray *)[DpStatus objectArrayWithKeyValuesArray:dictArr];
//        
//        //把数据加载到最后
//        [self.statuses addObjectsFromArray:status];
//        
//        //刷新
//        [self.tableView reloadData];
//
//    } failure:^(NSError *error) {
//        DpLog(@"error msg =%@",error);
//    }];
    
     //第一种写法
//    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //停止上拉加载控件
//        [self.tableView footerEndRefreshing];
//        
//        //数据转模型
//        //1.获取字典数据
//        NSArray * dictArr = responseObject[@"statuses"];
//        
//        //1.字典转模型
//        NSArray * status = (NSMutableArray *)[DpStatus objectArrayWithKeyValuesArray:dictArr];
//        
//        //把数据加载到最后
//        [self.statuses addObjectsFromArray:status];
//        
//        //刷新
//        [self.tableView reloadData];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DpLog(@"error msg =%@",error);
//    }];
    
}


#pragma mark - TableView的代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
       DpStatusCell * cell = [DpStatusCell cellWithTableView:tableView];
    
    //数据模型
    DpStatusFrame * statusF = self.statusFrames[indexPath.row];
    
    cell.statusF = statusF;
    cell.statusToolBar.delegate = self;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     // 获取status模型
    DpStatusFrame * statusF = self.statusFrames[indexPath.row];
    return statusF.cellHeight;
}

#pragma mark 监听cell的点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DpStatusDetailController * detail = [[DpStatusDetailController alloc] init];
    DpStatusFrame * statusF = self.statusFrames[indexPath.row];
    detail.status = statusF.status;
    
    [self.navigationController pushViewController:detail animated:YES];
    
}


#pragma mark - DpStatusToolBarDelegate的代理方法
-(void)statusbarClick:(UIButton *)btn WithWeiboId:(NSString *)weiboId
{
    //1.必须为NavgationController 才能modal
    
    // 创建转发微博控制器
    DpRepostController * repost = [[DpRepostController alloc] init];
    DpNavgationController * repostNav = [[DpNavgationController alloc] initWithRootViewController:repost];

    
    // 创建评论微博控制器
    DpCommentController * comment = [[DpCommentController alloc] init];
    DpNavgationController * commentNav = [[DpNavgationController alloc] initWithRootViewController:comment];
    
    
    switch (btn.tag) {
        case 0:  //转发
            repost.weiboId = weiboId;
            [self presentViewController:repostNav animated:YES completion:nil];
            break;
        case 1: //评论
            comment.weiboId = weiboId;
            [self presentViewController:commentNav animated:YES completion:nil];
            break;
        case 2: //点赞
            [DpAttitudeTool attitudeWithWeiBoID:weiboId success:^{
                NSLog(@"点赞成功");
            } failure:^(NSError *error) {
                NSLog(@"点赞失败,error = %@",error);
            }];
            break;
        default:
            break;
    }
}
@end
