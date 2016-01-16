//
//  DpOAuthViewController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/4.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpOAuthViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "DpAccountTool.h"
#import "DpAccount.h"
#import "DpRootTool.h"


#define client_id @"969836814"
#define client_secret @"ac06698b881e35dae1cea1bc1d237fbb"
#define redirect_uri @"http://www.baidu.com"

@interface DpOAuthViewController ()<UIWebViewDelegate>

@end

@implementation DpOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    /*
     client_id	true	string	申请应用时分配的AppKey。
     redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     */
    //请求授权
    
    NSString * baseUrl =@"https://api.weibo.com/oauth2/authorize";
    
    // 拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
    
    
    NSURL * url = [NSURL URLWithString:urlStr];
    
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
     webView.delegate = self;
    [webView loadRequest:request];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark webView的代理方法

//开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView
{
   //提示用户正在加载...
    [MBProgressHUD showMessage:@"正在加载..."];
}

// 拦截webView请求
// 当Webview需要加载一个请求的时候，就会调用这个方法，询问下是否请求
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {//如果存在
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        // 换取accessToken
        [self accessTokenWithCode:code];
        return NO;
    }
    
    //截取code 用来换取acessToken
    NSLog(@"回调url=%@",urlStr);
    return YES;
}

//根据code 去获取accessToken
-(void)accessTokenWithCode:(NSString *)code
{
    /*
     client_id	true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     
     grant_type为authorization_code时
     必选	类型及范围	说明
     code	true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
     https://api.weibo.com/oauth2/access_token
     */
//    NSString * url = @"https://api.weibo.com/oauth2/access_token";
//    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//    
//    dict[@"client_id"] = client_id;
//    dict[@"client_secret"] = client_secret;
//    dict[@"grant_type"] = @"authorization_code";
//    dict[@"code"] = code;
//    dict[@"redirect_uri"] = redirect_uri;
//    
//    AFHTTPRequestOperationManager * manager  = [AFHTTPRequestOperationManager manager];
//    
//    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"success ok result = %@",responseObject);
//        
//        
//        //保存用户信息 归档
//        DpAccount * account = [DpAccount accountWithDict:responseObject];
//        
//        [DpAccountTool saveAccount:account];
//        
//        //选择跟控制器
//        [DpRootTool chooseRootViewController:DpKeyWindow];
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"error ,msg = %@",error);
//    }];
    
    [DpAccountTool accessTokenWithCode:code success:^(id responseObejct) {
        
        //选择跟控制器
        [DpRootTool chooseRootViewController:DpKeyWindow];
        
    } failure:^(NSError *error) {
        NSLog(@"error ,msg = %@",error);
    }];
    
}

//webview加载完成的时候调用
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
//webview加载失败的时候调用
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
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
