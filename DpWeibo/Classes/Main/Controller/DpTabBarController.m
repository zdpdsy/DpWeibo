//
//  DpTabBarController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/11/30.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpTabBarController.h"
#import "DpNavgationController.h"
#import "UIImage+image.h"
#import "DpTabBarView.h"
#import "DpMessageViewController.h"
#import "DpProfileViewController.h"
#import "DpDiscoverController.h"
#import "DpHomeViewController.h"
#import "DpComposeViewController.h"
#import "DpUserTool.h"
#import "DpUserResult.h"

@interface DpTabBarController ()<DpTabBarDelegate>
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, weak) DpHomeViewController *home;

@property (nonatomic, weak) DpMessageViewController *message;

@property (nonatomic, weak) DpProfileViewController *profile;
@end

@implementation DpTabBarController

//懒加载
-(NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

//第一次调用这个类或者子类的时候调用
+(void)initialize
{
    //获取所有的uitabbaritem
    UITabBarItem * item  = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    //设置字体颜色
    
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [item setTitleTextAttributes:att forState:UIControlStateNormal];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildController];
    
    [self setUpTabBar];
    
    // 每隔一段时间请求未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
    
    
    // Do any additional setup after loading the view.
}
//请求未读消息
-(void)requestUnread
{
     //DpLog(@"开始请求未读信息");
    [DpUserTool unreadCount:^(DpUserResult *result) {
        //设置首页未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        
        //设置消息未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        
        //设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        
        //设置应用程序的所有未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        
        
    } failure:^(NSError *error) {
        DpLog(@"%@",error);
    }];
}
/**
 *  添加自定义tabbar
 */
-(void)setUpTabBar
{
    //自定义tabar
    DpTabBarView * tabBar = [[DpTabBarView alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.delegate = self;
    tabBar.items= self.items;
    
    // 添加到系统的tabBar
    [self.tabBar addSubview:tabBar];
    
    // 移除系统的tabBar
    //[self.tabBar removeFromSuperview];

}

-(void)tabBar:(DpTabBarView *)tabBar didClickButton:(NSInteger)index
{
    
    if (index == 0 && self.selectedIndex == index) { // 点击首页，刷新
        [_home refresh];
    }
    
    //NSLog(@"选中第几个=%ld",index);
    self.selectedIndex = index;
}
//点击+号按钮事件
-(void)tabBarDidClickPlusButton:(DpTabBarView *)tabbar
{
    // 创建发送微博控制器
    DpComposeViewController * compose = [[DpComposeViewController alloc] init];
    
    //必须为NavgationController 才能modal
    DpNavgationController * nav = [[DpNavgationController alloc] initWithRootViewController:compose];
    
    
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //删除系统的tabBarButton
    for (UIView * tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
            //NSLog(@"删除系统自带的UITabBarButton");
        }
    }
    //这里才显示view
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//添加所有自控制器
-(void) setUpAllChildController
{
    //首页
    DpHomeViewController * home = [[DpHomeViewController alloc] init];
    [self setUpOneChildController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    _home = home;

    
    //消息
    DpMessageViewController * message = [[DpMessageViewController alloc] init];
    [self setUpOneChildController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    _message = message;
    
    //发现
    DpDiscoverController * discover = [[DpDiscoverController alloc] init];
    [self setUpOneChildController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    
    //设置
    
    DpProfileViewController * profile = [[DpProfileViewController alloc] init];
    [self setUpOneChildController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    _profile = profile;
}

#pragma mark - 添加一个子控制器
// navigationItem决定导航条上的内容
// 导航条上的内容由栈顶控制器的navigationItem决定
/**
 *  添加一个子控制器
 *
 *  @param vc            <#vc description#>
 *  @param image         <#image description#>
 *  @param selectedImage <#selectedImage description#>
 *  @param title         <#title description#>
 */
-(void) setUpOneChildController:(UIViewController *) vc image:(UIImage*) image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.title = title;

    vc.tabBarItem.image =image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    
     // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    DpNavgationController * nav = [[DpNavgationController alloc] initWithRootViewController:vc];
    //initWithRootViewController方法 底层会调用push方法  [self.navigationController pushViewController:one animated:YES];方法

    
    [self addChildViewController:nav];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
