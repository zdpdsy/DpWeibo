//
//  DpOptionStatusController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/27.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpOptionStatusController.h"
#import "DpTextView.h"
#import "DpOptionStatusToolBar.h"

@interface DpOptionStatusController ()<UITextViewDelegate>



@property(nonatomic,weak) UIBarButtonItem *rightItem;

@property (weak,nonatomic) DpOptionStatusToolBar * toolBar;

@end

@implementation DpOptionStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条
    [self setUpNavgationBar];
    
    //设置textView
    [self setUpTextView];
    
    //设置工具条
    [self setUpToolBar];
    
    //监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
#pragma mark  - 键盘frame改变的时候调用
-(void)keyboardFrameChange:(NSNotification *)note
{
    /*
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 216}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 775}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 775}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 216}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 667}, {375, 216}}";
     UIKeyboardIsLocalUserInfoKey = 1;
     */
    //获取键盘弹出的动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //获取键盘结束的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
    if (frame.origin.y == self.view.height) {//没有弹出键盘
        [UIView animateWithDuration:duration animations:^{
            _toolBar.transform = CGAffineTransformIdentity;
        }];
        
    }else{
        //弹出键盘
        [UIView animateWithDuration:duration animations:^{
            
            //向上平移键盘的高度
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
}

#pragma mark - 设置导航条
-(void)setUpNavgationBar
{
    //左边
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:0 target:self action:@selector(dismiss)];
    
    //右边
    //创建一个button
    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [rightbtn sizeToFit];
    //  rightbtn.userInteractionEnabled = NO;
    
    // 监听按钮点击
    [rightbtn addTarget:self action:@selector(btnSend) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    
    rightBarItem.enabled = NO;
    
    self.navigationItem.rightBarButtonItem = rightBarItem;
    _rightItem = rightBarItem;
}

#pragma mark - 设置工具条
/**
 *  设置工具条
 */
-(void) setUpToolBar
{
    CGFloat h=35;
    CGFloat y = self.view.height - h;
    DpOptionStatusToolBar * toolbar = [[DpOptionStatusToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    
    [self.view addSubview:toolbar];
    
    _toolBar = toolbar;
}

#pragma mark  - 设置textView
/**
 *  设置textView
 */
-(void) setUpTextView
{
    DpTextView * textView = [[DpTextView alloc] initWithFrame:self.view.bounds];
    
    //设置占位符
    textView.placeholder = @"分享新鲜事...";
    textView.font = [UIFont systemFontOfSize:18];
    _textView = textView;
    [self.view addSubview:textView];
    
    // 默认允许垂直方向拖拽
    textView.alwaysBounceVertical = YES;
    
    // 监听文本框的输入
    /**
     *  Observer:谁需要监听通知
     *  name：监听的通知的名称
     *  object：监听谁发送的通知，nil:表示谁发送我都监听
     *
     */
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    
    //监听拖拽
    _textView.delegate = self;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //开始拖拽的时候 隐藏键盘
    [self.view endEditing:YES];
}


-(void)textChange
{
    // 判断下textView有木有内容
    if (_textView.text) {
        _textView.hidePlaceholder = YES;
        
        _rightItem.enabled = YES;
    }else{
        _textView.hidePlaceholder = NO;
        _rightItem.enabled= NO;
    }
}


#pragma mark - 发送或者取消（转发或者评微博请求）
-(void) btnSend
{
    
}

//取消
-(void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 移除通知
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //显示键盘
    [_textView becomeFirstResponder];
}

-(void)dealloc
{
    //注意移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
