//
//  DpSettingViewController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/15.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpSettingViewController.h"
#import "DpCommonSettingViewController.h"
#import "DpSettingGroup.h"
#import "DpSettingSwithItem.h"
#import "DpSettingLabelItem.h"
#import "DpSettingArrowItem.h"
#import "DpSettingBadgeItem.h"
#import "DpRootTool.h"
#import "DpOAuthViewController.h"
#import "DpNavgationController.h"
#import "MBProgressHUD+MJ.h"

#define DpUserAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]
@interface DpSettingViewController ()

@end

@implementation DpSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加第3组
   [self setUpGroup3];
    // Do any additional setup after loading the view.
}


-(void) setUpGroup0
{
    //账号管理
    DpSettingBadgeItem * account = [[DpSettingBadgeItem alloc] initWithTitle:@"账号管理"];
    account.badgeValue = @"8";
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.items = @[account];
    
    [self.groups addObject:group];

}

-(void) setUpGroup1
{
    //我的相册
    DpSettingArrowItem * album = [[DpSettingArrowItem alloc] initWithTitle:@"我的相册"];
    
    //通用设置
    DpSettingArrowItem * common = [[DpSettingArrowItem alloc] initWithTitle:@"通用设置"];
    common.descVc = [DpCommonSettingViewController class];
    
    //隐私和安全
    
    DpSettingArrowItem * security  = [[DpSettingArrowItem alloc] initWithTitle:@"隐私和安全"];
    
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    
    group.items =@[album,common,security];
    
    [self.groups addObject:group];
}

-(void) setUpGroup2
{
    //意见反馈
    DpSettingArrowItem * suggest = [[DpSettingArrowItem alloc] initWithTitle:@"意见反馈"];
    
    
    
    //关于微博
    DpSettingArrowItem * about = [[DpSettingArrowItem alloc] initWithTitle:@"关于微博"];
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.items = @[suggest,about];
    
    [self.groups addObject:group];
    
}

-(void) setUpGroup3
{
    //退出账号
    DpSettingLabelItem * signout = [[DpSettingLabelItem alloc] init];
    signout.text =@"退出当前账号";
    signout.Operation =^{
    
        //NSLog(@"%@",DpUserAccountFileName);
        
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:DpUserAccountFileName];
        //NSLog(@"%d",isExist);
        if (isExist) {
           
            //退出当前账号，需要重新登录
            [[NSFileManager defaultManager] removeItemAtPath:DpUserAccountFileName error:nil];
            
            
            DpOAuthViewController * oauth =[[DpOAuthViewController alloc] init];
            //必须为NavgationController 才能modal
            
            
            DpNavgationController * nav = [[DpNavgationController alloc] initWithRootViewController:oauth];
            
            [self.navigationController presentViewController:nav animated:YES completion:nil];

        }
        
        
         //[DpRootTool chooseRootViewController:DpKeyWindow];
    };
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.items =@[signout];
    
    [self.groups addObject:group];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
