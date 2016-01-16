//
//  DpPhotosView.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/11.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpPhotosView.h"

#import "DpPhoto.h"

#import "DpPhotoView.h"

#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@implementation DpPhotosView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加9个子控件
        
        [self setUpAllChildView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    NSInteger totalcount = self.subviews.count;
    for (int  i = 0; i<totalcount; i++) {
        
        DpPhotoView * imageV = self.subviews[i];
        
        if (i<pic_urls.count) {//显示
            // 获取DpPhoto模型
            DpPhoto *photo = _pic_urls[i];
            
            if (photo) {
                imageV.photo = photo;

            }
            
            imageV.hidden = NO;
        }else{ //隐藏
            imageV.hidden = YES;
        }
    }
}

//添加九个控件
-(void) setUpAllChildView
{
    for (int i = 0; i < 9; i++) {
        DpPhotoView * imageV = [[DpPhotoView alloc] init];
        
        imageV.tag = i;
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageV addGestureRecognizer:tap];
        
        [self addSubview:imageV];
    }
}

#pragma mark - 点击图片的时候调用
-(void)tap:(UITapGestureRecognizer *) tap
{
    //获取当前点种的view
     UIImageView *tapView = tap.view;
    
    NSMutableArray * arrM =[NSMutableArray array];
    int k=0;
    
    //DpPhoto 转MJPhoto
    for (DpPhoto * photo in _pic_urls) {
        /*
         @property (nonatomic, strong) NSURL *url;
         @property (nonatomic, strong) UIImage *image; // 完整的图片
         
         @property (nonatomic, strong) UIImageView *srcImageView; // 来源view
         */
        MJPhoto * mphoto = [[MJPhoto alloc] init];
        NSString * photostr = photo.thumbnail_pic.absoluteString;
        //高清图片路径
        photostr = [photostr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mphoto.url  = [NSURL URLWithString:photostr];
        
        mphoto.srcImageView = tapView;
        
        mphoto.index =k;
        [arrM addObject:mphoto];
        k++;
    }

    // 弹出图片浏览器
    // 创建浏览器对象
    MJPhotoBrowser * browser = [[MJPhotoBrowser alloc] init];
    browser.photos = arrM;
    browser.currentPhotoIndex = tapView.tag;
    [browser show];
}


//- (void)tap:(UITapGestureRecognizer *)tap
//{
//    UIImageView *tapView = tap.view;
//    // CZPhoto -> MJPhoto
//    int i = 0;
//    NSMutableArray *arrM = [NSMutableArray array];
//    for (DpPhoto *photo in _pic_urls) {
//        
//        MJPhoto *p = [[MJPhoto alloc] init];
//        NSString *urlStr = photo.thumbnail_pic.absoluteString;
//        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//        p.url = [NSURL URLWithString:urlStr];
//        p.index = i;
//        p.srcImageView = tapView;
//        [arrM addObject:p];
//        i++;
//    }
//    
//    
//    // 弹出图片浏览器
//    // 创建浏览器对象
//    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
//    // MJPhoto
//    brower.photos = arrM;
//    brower.currentPhotoIndex = tapView.tag;
//    [brower show];
//}

//设置子控件的frame
-(void)layoutSubviews
{
    //总列数
    int cols = _pic_urls.count == 4?2:3;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    int col = 0;
    int row = 0;
    
    for (int i =0; i<_pic_urls.count; i++) {
        col = i%cols;
        row = i/cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + margin);
        y = row * (h + margin);
        imageV.frame = CGRectMake(x, y, w, h);
    }
}

@end
