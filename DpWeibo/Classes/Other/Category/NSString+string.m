//
//  NSString+string.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/24.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "NSString+string.h"

@implementation NSString (string)
-(NSString *)fileAppend:(NSString *)append
{
    //1.1获得文件扩展名
    NSString *ext = [self pathExtension];
    //1.2删除最后面的扩展名
    NSString *imageName = [self stringByDeletingPathExtension];
    
    //1.3拼接append
    imageName = [imageName stringByAppendingString:append];
    
    //1.4拼接扩展名
    imageName = [imageName stringByAppendingPathExtension:ext];
    
    return imageName;
}

@end
