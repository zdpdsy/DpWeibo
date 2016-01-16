//
//  UIImage+image.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/11/30.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

+(instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage * image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

#pragma mark 可以自由拉伸不会变形的图片
+(UIImage *)resizedImage:(NSString *)imageName
{
    
    return [self resizedImage:imageName xPos:0.5 yPos:0.5];
    
}


+ (UIImage *)resizedImage:(NSString *)imageName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}


/*
 拉伸图片
 */
+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    /*
     意思就是用来创建一个内容可拉伸，而边角不拉伸的图片，需要两个参数，第一个是左边不拉伸区域的宽度，第二个参数是上面不拉伸的高度。那么接下来的一个像素会被拉伸。例如，leftCapHeight为6，topCapHeight为8。那么，图片左边的6个像素，上边的8个像素。不会被拉伸，而左边的第7个像素，上边的第9个像素这一块区域将会被拉伸。剩余的部分也不会被拉伸。
     */
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
