//
//  AppDelegate.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/11/29.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>

#import "AppDelegate.h"
#import "DpTabBarController.h"
#import "DpNewFeatureController.h"
#import "DpOAuthViewController.h"
#import "DpAccountTool.h"
#import "DpAccount.h"
#import "DpRootTool.h"
#import "UIImageView+WebCache.h"
@interface AppDelegate ()
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation AppDelegate

//当程序启动完成后被调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //注册通知
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:settings];
    
    
    
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    
//    
//    // 后台播放
//    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//    
//    // 单独播放一个后台程序
//    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
//    
//    [session setActive:YES error:nil];
    
    //
    AVAudioSession * session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //单独播放一个后台程序
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    [session setActive:YES error:nil];
    
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    DpAccount * account = [DpAccountTool account];
    
    if (account) { //如果已经授权过
        [DpRootTool chooseRootViewController:self.window];
        
    }else{
        DpOAuthViewController * oAuth = [[DpOAuthViewController alloc] init];
        self.window.rootViewController = oAuth;
    }
    //显示窗口
     // makeKeyAndVisible底层实现
    // 1. application.keyWindow = self.window
    // 2. self.window.hidden = NO;
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}
//搜到内存警告的时候调用
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    //删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}
//失去焦点
- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    
    AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    [player prepareToPlay];
    player.numberOfLoops = -1;//无限播放
    [player play];//开始播放
    _player = player;
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

//程序进入后台开始调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    //程序进入后台
//    // 开启一个后台任务,时间不确定，优先级比较低，假如系统要关闭应用，首先就考虑
//    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
//        
//        // 当后台任务结束的时候调用
//        [application endBackgroundTask:ID];
//        
//    }];
    
    UIBackgroundTaskIdentifier id = [application beginBackgroundTaskWithExpirationHandler:^{
        //当后台任务结束的时候调用
        [application endBackgroundTask:id];
    }];
    // 如何提高后台任务的优先级，欺骗苹果，我们是后台播放程序
    
    // 但是苹果会检测你的程序当时有没有播放音乐，如果没有，有可能就干掉你
    
    // 微博：在程序即将失去焦点的时候播放静音音乐.
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

#pragma mark 程序从后台再次回到前台运行时调用
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    //关闭后台播放的音乐
    [_player stop];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
