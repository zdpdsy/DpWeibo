//
//  DpScanController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/28.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpScanController.h"
#import  "ResultScanController.h"
#import <AVFoundation/AVFoundation.h>

@interface DpScanController ()<AVCaptureMetadataOutputObjectsDelegate>

//扫码的view
@property (nonatomic, strong) UIView *boxView;

//扫描线
@property (nonatomic, strong) CALayer *scanLayer;

//相机的view
@property (strong,nonatomic) UIView * viewPreview;

//捕捉会话
@property (nonatomic, strong) AVCaptureSession *captureSession;

//展示layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation DpScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildView];
    
    [self startRecoding];
    // Do any additional setup after loading the view.
}

-(void)setUpAllChildView
{
    self.title = @"扫一扫";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * viewPre = [[UIView alloc] init];
    viewPre.frame =  CGRectMake(20, 80, 320, 400);
    viewPre.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewPre];
    _viewPreview = viewPre;
    
    _captureSession = nil;
}

//获取相机
-(AVCaptureDevice *) getCamera
{
    return [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
}
-(void)startRecoding
{
    NSError *error;
    
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    AVCaptureDevice * captureDevice =  [self getCamera];
    
    //2.用captureDevice创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        DpLog(@"%@", [error localizedDescription]);
    }
    
     //3.创建媒体数据输出流
    AVCaptureMetadataOutput * captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
    //4.实例化捕捉会话
    _captureSession = [[AVCaptureSession alloc] init];
    
    if ([_captureSession canAddInput:input]) {
        //4.1.将输入流添加到会话
        [_captureSession addInput:input];
    }
    if ([_captureSession canAddOutput:captureMetadataOutput]) {
        //4.2.将媒体输出流添加到会话中
        [_captureSession addOutput:captureMetadataOutput];
    }
    
    //5.创建串行队列，并加媒体输出流添加到队列当中
    dispatch_queue_t dispatchQueue = dispatch_queue_create("myScanQueue", NULL);
    
    //5.1.设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    //5.2.设置输出媒体数据类型为QRCode 二维码
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    
    //6.实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    
    //7.设置预览图层的填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    //8.设置图层的frame
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    
    //9.将图层添加到预览view的图层上
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    //10.设置扫描范围
    captureMetadataOutput.rectOfInterest =  CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
    //10.1扫描框
    CGSize  viewPreSize = _viewPreview.bounds.size;
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(viewPreSize.width*0.1f, viewPreSize.height*0.2f, viewPreSize.width * 0.8f, viewPreSize.width * 0.8f)];
    _boxView.layer.borderColor = [UIColor orangeColor].CGColor;
    _boxView.layer.borderWidth = 1.0f;
    [_viewPreview addSubview:_boxView];
    
    //10.2.扫描线
    _scanLayer = [[CALayer alloc] init];
    _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, 2);
    _scanLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [_boxView.layer addSublayer:_scanLayer];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    
    [timer fire];
    
    //11.开始扫描
    [_captureSession startRunning];

}

-(void)stopReading
{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_scanLayer removeFromSuperlayer];
    [_videoPreviewLayer removeFromSuperlayer];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate的代理方法
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //判断是否有数据
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        //判断回传的数据类型
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            [[NSUserDefaults standardUserDefaults] setObject:metadataObj.stringValue forKey:kScanUrlStr];
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
        }
    }
    
    //跳转
    ResultScanController *resultScan = [[ResultScanController alloc] init];
    UINavigationController *resultNav = [[UINavigationController alloc] initWithRootViewController:resultScan];
    //[self.navigationController pushViewController:resultScan animated:YES];
    [self presentViewController:resultNav animated:YES completion:nil];
    
}

- (void)moveScanLayer:(NSTimer *)timer
{
    CGRect frame = _scanLayer.frame;
    if (_boxView.frame.size.height == _scanLayer.frame.origin.y) {
        frame.origin.y = 0;
        _scanLayer.frame = frame;
    }else{
        frame.origin.y += 5;
        if (frame.origin.y > _boxView.frame.size.height) {
            frame.origin.y = _boxView.frame.size.height;
        }
        [UIView animateWithDuration:0.1 animations:^{
            _scanLayer.frame = frame;
        }];
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
