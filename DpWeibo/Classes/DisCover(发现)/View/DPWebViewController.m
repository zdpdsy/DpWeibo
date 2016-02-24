//
//  DPWebViewController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 16/2/20.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "DPWebViewController.h"
#import "DpNavgationController.h"
#import "DpComposeViewController.h"
#import "DpScanController.h"
@interface DPWebViewController ()<UIWebViewDelegate>

@property (strong,nonatomic) UIWebView * webView;
@end

@implementation DPWebViewController

-(void)loadView
{
    UIWebView * webView = [[UIWebView alloc] init];
    webView.delegate = self;
    self.webView = webView;
    self.view =webView;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(btnClick)];


    //获取本地连接
    NSURL * url =[[NSBundle mainBundle] URLForResource:@"test.html" withExtension:nil];
    
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:urlRequest];
    // Do any additional setup after loading the view.
}
#pragma mark - webView代理方法
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    /*
     Javascript调用Native，并没有现成的API可以直接拿来用，而是需要间接地通过一些方法来实现。UIWebView有个特性：在UIWebView内发起的所有网络请求，都可以通过delegate函数在Native层得到通知。这样，我们就可以在UIWebView内发起一个自定义的网络请求，通常是这样的格式：jsbridge://methodName?param1=value1&param2=value2
     
     于是在UIWebView的delegate函数中，我们只要发现是jsbridge://开头的地址，就不进行内容的加载，转而执行相应的调用逻辑。
     */
    NSString * requestStr = [request.URL absoluteString];
    //js协议头 dpweibo  dpweibo://location/locationcallback?key=value&key1=value1
    NSString * protocol = @"dpweibo://";
    
    
    if ([requestStr hasPrefix:protocol]) {
        //截取协议后面的参数
        NSString * requestContent = [requestStr substringFromIndex:[protocol length]];
        NSArray * arr= [requestContent componentsSeparatedByString:@"/"];
        NSString * scheme = arr[0];
        
        if ([scheme isEqualToString:@"location"]) {
            //跳转发送微博界面
            [self doAction:@"sendweibo"];
        }else  if ([scheme isEqualToString:@"scan"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接类型" message:@"当前为WIFI连接" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
//            //跳转到扫码页面
//            [self doAction:@"scan"];
        }
        return NO;
    }
    return YES;
}

-(void)doAction:(NSString*)op{
    
    if ([op isEqualToString:@"sendweibo"]) {
        // 创建发送微博控制器
        DpComposeViewController * compose = [[DpComposeViewController alloc] init];
        
        //必须为NavgationController 才能modal
        DpNavgationController * nav = [[DpNavgationController alloc] initWithRootViewController:compose];
        
        //modal 发送微博界面
        [self presentViewController:nav animated:YES completion:nil];
        
    }else if ([op isEqualToString:@"scan"]){
        // 创建发送扫码控制器
        DpScanController * scan = [[DpScanController alloc] init];
        scan.touchOption = @"3dtouch";
        
        //必须为NavgationController 才能modal
        DpNavgationController * nav = [[DpNavgationController alloc] initWithRootViewController:scan];
        
        //modal 发送扫码微博界面
        [self presentViewController:nav animated:YES completion:nil];
    }
}


#pragma mark - 其他
-(void)btnClick{
     //隐藏 模态窗口
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
