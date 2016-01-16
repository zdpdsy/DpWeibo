//
//  DpRepostController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/27.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpRepostController.h"
#import "DpTextView.h"
#import  "DpComposeTool.h"
#import "MBProgressHUD+MJ.h"
@interface DpRepostController ()

@end

@implementation DpRepostController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转发微博";
    
    self.textView.placeholder = @"转发...";
}
-(void)btnSend
{
    long long weiboId = [self.weiboId longLongValue];
    
    NSString * status = self.textView.text;
    [DpComposeTool repostWithWeiboId:weiboId status:status success:^{
        
        [MBProgressHUD showSuccess:@"转发成功"];
        
        //跳回首页
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"转发失败"];
        NSLog(@"repost error =  %@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
