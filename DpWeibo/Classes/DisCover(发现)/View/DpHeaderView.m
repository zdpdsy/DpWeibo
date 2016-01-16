//
//  MJHeaderView.m
//  13-团购
//
//  Created by 曾大鹏 on 15/8/17.
//  Copyright (c) 2015年 曾大鹏. All rights reserved.
//

#import "DpHeaderView.h"

@interface DpHeaderView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic,assign) NSInteger  pageIndex;
@property (nonatomic,strong) NSTimer * timer;
@end

@implementation DpHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)headView
{
    DpHeaderView * headerView = [[[NSBundle mainBundle] loadNibNamed:@"DpHeaderView" owner:nil options:nil]lastObject];
    return headerView;
}

//xib加载完毕后的事件
-(void)awakeFromNib
{
    //设置大小
    CGFloat iconW = self.scrollView.frame.size.width;
    CGFloat iconH = self.scrollView.frame.size.height;
    for (int i = 0; i < 5; i++) {
        NSString * imgName = [NSString stringWithFormat:@"ad_%02d",i];
        UIImageView * iconView = [[UIImageView alloc] init];
        [self.scrollView addSubview:iconView];
        UIImage * img = [UIImage imageNamed:imgName];
       
        CGFloat iconX = iconW * i;
        CGFloat iconY = 0;
        iconView.image = img;
        iconView.frame=CGRectMake(iconX, iconY, iconW, iconH);
    }
    self.pageControl.numberOfPages = 5;
    self.scrollView.contentSize = CGSizeMake(5 * iconW, 0);
     self.scrollView.showsHorizontalScrollIndicator = NO;
    //设置代理
    self.scrollView.delegate = self;
    [self addtimer0];
}

- (void) addtimer0{
    //定时器
    
    NSTimer * timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(autoNextPage) userInfo:nil repeats:YES];
    self.timer = timer;
    //消息循环
    NSRunLoop * loop = [NSRunLoop currentRunLoop];
    [loop addTimer:timer forMode:NSRunLoopCommonModes];
    //NSDefaultRunLoopMode 会有问题。如果页面上有两个scrollview，则会相互影响
    //立即执行定时器的方法
    //[timer fire];
    
}
//自动下一个图片
- (void) autoNextPage
{
    NSInteger page=self.pageControl.currentPage;
    self.pageControl.currentPage = page;
    if(page == self.pageControl.numberOfPages - 1){
        page = 0;
    }
    else{
        page ++ ;
    }
    
    CGFloat offsetx = self.scrollView.frame.size.width * page;
    [UIView animateWithDuration:1 animations:^{
        self.scrollView.contentOffset=CGPointMake(offsetx, 0);
        
    }];
}

#pragma mark -scrollview的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //超过一半 则显示下一个
    int page = (scrollView.contentOffset.x + scrollView.frame.size.width * 0.5)/ scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止计时器
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //重新生成一个定时器
    [self addtimer0];
}
@end
