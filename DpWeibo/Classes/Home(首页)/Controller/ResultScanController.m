//
//  ResultScanController.m
//  iWeibo
//
//  Created by dengwei on 15/12/23.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

#import "ResultScanController.h"

@interface ResultScanController ()

@property (nonatomic, copy) NSString *scanResultStr;

@property (nonatomic, strong) UIWebView *resultView;
@end

@implementation ResultScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //设置左上角按钮
     UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = left;
    self.scanResultStr = [[NSUserDefaults standardUserDefaults] objectForKey:kScanUrlStr];
    
    [self setupUI];
    [self loadWebView];
}

-(void)setupUI
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    self.resultView = webView;
}

-(void)clickBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadWebView
{
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.scanResultStr]];
    [self.resultView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
