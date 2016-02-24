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
#import "DpComposeViewController.h"
#import "DpScanController.h"
#import "DpNavgationController.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"
//初始化的import参数注意要链接原生微信SDK。


//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"


@interface AppDelegate ()
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation AppDelegate

//当程序启动完成后被调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //注册通知
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:settings];
    
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
    
    
    [self init3dTouchIcon];
    
    [self initShareSDK];
    
    // Override point for customization after application launch.
    return YES;
}

#pragma mark - 初始化3dtouch appItem
-(void)init3dTouchIcon
{
    UIApplicationShortcutItem * shortItem1 = [[UIApplicationShortcutItem alloc]initWithType:@"compose" localizedTitle:@"写微博" localizedSubtitle:@"看我哦" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose] userInfo:nil];
    
    
    
    UIApplicationShortcutItem * shortItem2 = [[UIApplicationShortcutItem alloc]initWithType:@"scan" localizedTitle:@"扫描二维码" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCapturePhoto] userInfo:nil];
    
    
    NSArray *shortItems = [[NSArray alloc] initWithObjects:shortItem1, shortItem2, nil];
    // NSLog(@"%@", shortItems);
    [[UIApplication sharedApplication] setShortcutItems:shortItems];
}


#pragma mark - 初始化shareSDK
-(void) initShareSDK
{
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:mobAppKey
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat)
//                            @(SSDKPlatformTypeQQ)
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
//             case SSDKPlatformTypeQQ:
//                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:sinaClientId appSecret:sinaClientSecret redirectUri:sinaRedirectUri authType:SSDKAuthTypeBoth];
                 
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx1c26149202ec6e08"
                                       appSecret:@"69a554ea2567f88606a74fdeb8c031be"];
                 break;
//             case SSDKPlatformTypeQQ:
//                 [appInfo SSDKSetupQQByAppId:@"100371282"
//                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
//                                    authType:SSDKAuthTypeBoth];
//                 break;
             default:
                 break;
         }
     }];
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
#pragma mark - 3dtouch处理
-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    NSLog(@"3d touch begin");
    //判断先前我们设置的唯一标识
    if ([shortcutItem.type isEqualToString:@"compose"]) {

        // 创建发送微博控制器
        DpComposeViewController * compose = [[DpComposeViewController alloc] init];
        
        //必须为NavgationController 才能modal
        DpNavgationController * nav = [[DpNavgationController alloc] initWithRootViewController:compose];
        
        //modal 发送微博界面
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
        
    }else if ([shortcutItem.type isEqualToString:@"scan"]){
        
      
        
        // 创建发送微博控制器
        DpScanController * scan = [[DpScanController alloc] init];
        scan.touchOption = @"3dtouch";
        
        //必须为NavgationController 才能modal
        DpNavgationController * nav = [[DpNavgationController alloc] initWithRootViewController:scan];
        
        //modal 发送微博界面
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
        
    }

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
