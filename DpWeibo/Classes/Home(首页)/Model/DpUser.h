//
//  DpUser.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/6.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DpUser : NSObject
/**
 *  微博昵称
 */
@property (copy, nonatomic) NSString *name;

/**
 *  微博头像
 */
@property (strong,nonatomic) NSURL * profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;


@property (nonatomic, assign,getter=isVip) BOOL vip;

@end
