//
//  DpStatus.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/6.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "DpUser.h"
/*
 返回值字段	字段类型	字段说明
 created_at	string	微博创建时间
 id	int64	微博ID
 mid	int64	微博MID
 idstr	string	字符串型的微博ID
 text	string	微博信息内容
 source	string	微博来源
 favorited	boolean	是否已收藏，true：是，false：否
 truncated	boolean	是否被截断，true：是，false：否
 in_reply_to_status_id	string	（暂未支持）回复ID
 in_reply_to_user_id	string	（暂未支持）回复人UID
 in_reply_to_screen_name	string	（暂未支持）回复人昵称
 thumbnail_pic	string	缩略图片地址，没有时不返回此字段
 bmiddle_pic	string	中等尺寸图片地址，没有时不返回此字段
 original_pic	string	原始图片地址，没有时不返回此字段
 geo	object	地理信息字段 详细
 user	object	微博作者的用户信息字段 详细
 retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
 reposts_count	int	转发数
 comments_count	int	评论数
 attitudes_count	int	表态数
 mlevel	int	暂未支持
 visible	object	微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
 pic_ids	object	微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
 ad	object array	微博流内的推广微博ID
 */
@interface DpStatus : NSObject<MJKeyValue>

/**
 *  转发微博
 */
@property (nonatomic, strong) DpStatus *retweeted_status;

/**
 *  转发微博昵称
 */
@property (nonatomic, copy) NSString *retweetName;

/**
 *  用户
 */
@property (nonatomic, strong) DpUser *user;

/**
 *  微博创建时间
 */
@property (copy, nonatomic) NSString *created_at;

/**
 *  字符串型的微博ID
 */
@property (copy, nonatomic) NSString *idstr;

/**
 *  微博信息内容
 */
@property (copy, nonatomic) NSString *text;

/**
 *  微博来源
 */
@property (copy, nonatomic) NSString *source;

/**
 *  转发数
 */
@property (nonatomic, assign) int reposts_count;

/**
 *  评论数
 */
@property (nonatomic, assign) int comments_count;

/**
 *  表态数(赞)
 */
@property (nonatomic, assign) int attitudes_count;

/**
 *  配图数组(DpPhoto)
 */
@property (nonatomic, strong) NSArray *pic_urls;

@end
