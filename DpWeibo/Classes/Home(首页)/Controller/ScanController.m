//
//  ScanController.m
//  iWeibo
//
//  Created by dengwei on 15/12/20.
//  Copyright (c) 2015年 dengwei. All rights reserved.
//

/*
 步骤如下：
 1.导入AVFoundation框架，import<AVFoundation/AVFoundation.h>
 2.设置一个用于显示扫描的view
 3.实例化AVCaptureSession、AVCaptureVideoPreviewLayer
 */

#import "ScanController.h"
#import <AVFoundation/AVFoundation.h>
#import "ResultScanController.h"

@interface ScanController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) UIView *boxView;

@property (nonatomic, strong) CALayer *scanLayer;

//相机的view
@property (nonatomic, strong) UIView *viewPreview;

//捕捉会话
@property (nonatomic, strong) AVCaptureSession *captureSession;

//展示layer
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

/**
 *  开始扫描
 */
-(void)startReading;

/**
 *  停止扫描
 */
-(void)stopReading;

@end

@implementation ScanController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self buildUI];
    [self startReading];
}

#pragma mark 创建界面
-(void)buildUI
{
    self.title = @"扫一扫";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *viewPreview = [[UIView alloc] init];
    viewPreview.frame = CGRectMake(20, 84, 320, 400);
    viewPreview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewPreview];
    self.viewPreview = viewPreview;
    
    _captureSession = nil;
}

- (AVCaptureDevice *)getFrontCamera
{
    return [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
}

- (void)startReading
{
    NSError *error;
#warning 扫码需要真机才能使用
    //1.初始化捕捉设备（AVCaptureDevice），类型为AVMediaTypeVideo
    AVCaptureDevice *captureDevice = [self getFrontCamera];
    
    
    //2.用captureDevice创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        DpLog(@"%@", [error localizedDescription]);
        //return;
    }
    
    //3.创建媒体数据输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    
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
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myScanQueue", NULL);
    //5.1.设置代理
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    //5.2.设置输出媒体数据类型为QRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    //6.实例化预览图层
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    
    //7.设置预览图层填充方式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    //8.设置图层的frame
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    
    //9.将图层添加到预览view的图层上
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    //10.设置扫描范围
    captureMetadataOutput.rectOfInterest = CGRectMake(0.2f, 0.2f, 0.8f, 0.8f);
    //10.1.扫描框
    _boxView = [[UIView alloc] initWithFrame:CGRectMake(_viewPreview.bounds.size.width * 0.1f, _viewPreview.bounds.size.height * 0.2f, _viewPreview.bounds.size.width * 0.8f, _viewPreview.bounds.size.width * 0.8f)];
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

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
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
    
    ResultScanController *resultScan = [[ResultScanController alloc] init];
    UINavigationController *resultNav = [[UINavigationController alloc] initWithRootViewController:resultScan];
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
