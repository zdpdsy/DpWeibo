//
//  DpBaseText.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/26.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//


#import "MJExtension.h"

@class DpUser;

@interface DpBaseText:NSObject<MJKeyValue>

/**
 *  微博创建时间
 */
@property (copy, nonatomic) NSString *created_at;

/**
 *  字符串型的微博ID
 */
@property (copy, nonatomic) NSString *idstr;

/**
 *  微博评论或转发内容
 */
@property (copy, nonatomic) NSString *text;

/**
 *  用户数据
 */
@property (strong,nonatomic) DpUser * user;

@end
