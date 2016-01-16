//
//  DpCommentController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/27.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpCommentController.h"
#import "DpTextView.h"
#import "DpComposeTool.h"
#import "MBProgressHUD+MJ.h"
@interface DpCommentController ()

@end

@implementation DpCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"发评论";
    
    self.textView.placeholder = @"写评论...";
    
}


-(void)btnSend
{
    long long weiboId  = [self.weiboId longLongValue];
    
    NSString * status = self.textView.text;
    
    [DpComposeTool commentWithWeiboId:weiboId status:status success:^{
        [MBProgressHUD showSuccess:@"发送评论成功"];
        
        //跳回首页
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
       
        [MBProgressHUD showError:@"发送评论失败"];
        NSLog(@"send weibo error ,reason = %@",error);
    }];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
