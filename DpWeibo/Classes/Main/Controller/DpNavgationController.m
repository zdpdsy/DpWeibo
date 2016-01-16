//
//  DpNavgationController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/1.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpNavgationController.h"
@interface DpNavgationController()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end


@implementation DpNavgationController

+(void)initialize
{
    //设置所有导航条文字的颜色
    
     // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem * navItem = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    [navItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    //self.interactivePopGestureRecognizer.delegate = nil;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

//重写push方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //设置非根控制器的导航条的内容
    //NSLog(@"navgation..push方法 %ld",self.childViewControllers.count);
    if (self.childViewControllers.count == 0) {//根控制器
        
    }else{ //非根控制器
        
        //当push控制器的时候 隐藏系统自带的tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置导航条的按钮
        viewController.navigationItem.leftBarButtonItem = left;
        
        UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popToRoot) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = right;
    }
    [super pushViewController:viewController animated:animated];
}

-(void) popToPre
{
    [self popViewControllerAnimated:YES];
}
-(void)popToRoot
{
    [self popToRootViewControllerAnimated:YES];
}

#pragma mark - Navigation代理方法

//导航控制器即将显示新的控制器的时候调用
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UITabBarController * tabBarVc = (UITabBarController *) DpKeyWindow.rootViewController;
    //NSLog(@"%@",tabBarVc.tabBar.subviews);
    
    //删除系统的tabBarButton
    for (UIView * tabBarButton in tabBarVc.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
           // NSLog(@"删除系统自带的UITabBarButton");
        }
    }
}

//导航控制器跳转完成的时候调用
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果是根控制器
    if (viewController == self.viewControllers[0]) {
        //还原滑动返回
         self.interactivePopGestureRecognizer.delegate =  _popDelegate;//关闭滑动返回
    }else{
        //控制ViewController是否启用右滑返回
        //实现滑动返回功能
        //清空滑动返回的代理,就能实现滑动返回的功能
        self.interactivePopGestureRecognizer.delegate = nil;//开始滑动返回
    }

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
