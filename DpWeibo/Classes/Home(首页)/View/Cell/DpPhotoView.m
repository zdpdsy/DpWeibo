//
//  DpPhotoView.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/11.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpPhotoView.h"
#import "DpPhoto.h"
#import "UIImageView+WebCache.h"

@interface DpPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation DpPhotoView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 裁剪图片，超出控件的部分裁剪掉
        self.clipsToBounds = YES;
        
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        _gifView = gifView;

    }
    return self;
}
-(void)setPhoto:(DpPhoto *)photo
{
    _photo = photo;
    //NSLog(@"%@",photo.thumbnail_pic);
    // 赋值
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    // 判断下是否显示gif
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y= self.height - self.gifView.height;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
