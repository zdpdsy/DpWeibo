//
//  DpComposeViewController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/12.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpComposeViewController.h"
#import "DpTextView.h"
#import "DpComposeToolBar.h"
#import "DpComposePhotosView.h"
#import "DpComposeTool.h"
#import "MBProgressHUD+MJ.h"

@interface DpComposeViewController ()<UITextViewDelegate,DpComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak,nonatomic) DpTextView * textView;

@property(nonatomic,weak) UIBarButtonItem *rightItem;

@property (weak,nonatomic) DpComposeToolBar * toolBar;

@property (weak,nonatomic) DpComposePhotosView * photosView;
/**
 *  Model=UIImage
 */
@property (strong,nonatomic) NSMutableArray * images;
@end

@implementation DpComposeViewController

#pragma mark -  懒加载
-(NSMutableArray *)images
{
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置导航条
    [self setUpNavgationBar];
    
    //设置textView
    [self setUpTextView];
    
    [self setUpToolBar];
    
    //监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //设置相册视图
    [self setUpPhotosView];
    // Do any additional setup after loading the view.
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  设置工具条
 */
-(void) setUpToolBar
{
    CGFloat h=35;
    CGFloat y = self.view.height - h;
    DpComposeToolBar * toolbar = [[DpComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    
    [self.view addSubview:toolbar];
    
    _toolBar = toolbar;
    _toolBar.delegate = self;
}


/**
 *  设置相册视图
 */
-(void)setUpPhotosView
{
    DpComposePhotosView * photosView = [[DpComposePhotosView alloc] initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height -70)];
    
    _photosView = photosView;
    
    //图片添加到textView中
    [_textView addSubview:photosView];
}

#pragma mark  - UIImagePickerController的代理方法(选择图片完成的时候调用)
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 获取选中的图片
   // NSLog(@"%@",info);
    UIImage * image =info[UIImagePickerControllerOriginalImage];
    
    [self.images addObject:image];
    
    
    _rightItem.enabled = YES;
    
    _photosView.image = image;
    
    //返回
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma  mark  - composetoolbar的代理方法
-(void)composeToolBar:(DpComposeToolBar *)toolBar didClickBtn:(NSInteger)index
{
    //点击相册
    if (index == 0) {
        //系统相册
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        //相册类型
        imagePicker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
        
        //设置代理
        imagePicker.delegate = self;
        
        //弹出相册
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

/**
 *  设置导航条
 */
-(void) setUpNavgationBar
{

    //title
    
    self.title = @"发微博";
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
    [rightbtn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    
     rightBarItem.enabled = NO;
    
    self.navigationItem.rightBarButtonItem = rightBarItem;
    _rightItem = rightBarItem;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //显示键盘
    [_textView becomeFirstResponder];
}
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
    if (_textView.text.length > 0) {
        _textView.hidePlaceholder = YES;
        
        _rightItem.enabled = YES;
    }else{
        _textView.hidePlaceholder = NO;
        _rightItem.enabled= NO;
    }
}


-(void)dealloc
{
    //注意移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
//取消
-(void)dismiss
{
     [self dismissViewControllerAnimated:YES completion:nil];
}

//发送
-(void)compose
{
    if (self.images.count) {
        [self sendImgWeibo];
    }else{
        [self sendTitleWeibo];
    }
}

//发送文字微博
-(void) sendTitleWeibo
{
    [DpComposeTool composeWithStatus:_textView.text success:^{
        
        [MBProgressHUD showSuccess:@"发送成功"];
        
        //返回首页
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        NSLog(@"send weibo error ,reason = %@",error);
    }];
}

//发送图片+文字微博
-(void)sendImgWeibo
{
    UIImage *image = self.images[0];
    
    NSString *status = _textView.text.length?_textView.text:@"分享图片";
    
    _rightItem.enabled = NO; //避免发送多次
    [DpComposeTool composeWithStatus:status Image:image success:^{
        
        [MBProgressHUD showSuccess:@"发送成功"];
        
         _rightItem.enabled = YES;
        
        //返回首页
        [self dismissViewControllerAnimated:YES completion:nil];
       
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        
        NSLog(@"send error=%@",error);
    }];
}

@end
