//
//  DpRootTool.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/6.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpRootTool.h"
#import "DpTabBarController.h"
#import "DpNewFeatureController.h"
#define DpVersionKey @"Version"

@implementation DpRootTool
+(void)chooseRootViewController:(UIWindow *)window
{
   
        // 1.获取当前的版本号
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
        // NSLog(@"%@",[NSBundle mainBundle].infoDictionary);
        
        // 2.从沙盒中取出上次存储的版本号
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:DpVersionKey];
        
        if (![currentVersion isEqualToString:lastVersion]) { //第一次使用该版本
            
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:DpVersionKey];
            [[NSUserDefaults standardUserDefaults] synchronize];//同步
            
            //创建新特性窗口
            DpNewFeatureController * newFeatureVc = [[DpNewFeatureController alloc] init];
            window.rootViewController = newFeatureVc;
            
            
        }else{ //不是第一次使用版本
            
            //创建tabbar控制器
            DpTabBarController * tabBarVc = [[DpTabBarController alloc] init];
            
            //设置根控制器
            window.rootViewController = tabBarVc;
            
        }
}
@end
