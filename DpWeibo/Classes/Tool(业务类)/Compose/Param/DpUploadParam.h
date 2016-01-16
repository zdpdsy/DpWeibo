//
//  DpUploadParam.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/14.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpBaseParam.h"

@interface DpUploadParam : DpBaseParam

/**
 *  要上传的文件二进制数据
 */
@property (strong,nonatomic) NSData * data;

/**
 *  上传文件的参数名称
 */
@property (strong,nonatomic) NSString * name;

/**
 *  文件名称
 */
@property (strong,nonatomic) NSString * fileName;

/**
 *  上传到服务器的文件类型
 */
@property (strong,nonatomic) NSString * mimeType;

@end
