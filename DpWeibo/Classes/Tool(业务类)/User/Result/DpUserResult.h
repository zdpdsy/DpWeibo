//
//  DpUserResult.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/8.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 status	int	新微博未读数
 follower	int	新粉丝数
 cmt	int	新评论数
 dm	int	新私信数
 mention_status	int	新提及我的微博数
 mention_cmt	int	新提及我的评论数
 */


@interface DpUserResult : NSObject

/**
 *  新微博未读数
 */
@property (assign, nonatomic) int status;

/**
 *  新粉丝数
 */
@property (assign, nonatomic) int follower;

/**
 *  新评论数
 */
@property (assign, nonatomic) int cmt;

/**
 *  新私信数
 */
@property (assign, nonatomic) int dm;

/**
 *  新提及我的微博数
 */
@property (assign, nonatomic) int mention_status;

/**
 *  新提及我的评论数
 */
@property (assign, nonatomic) int mention_cmt;

/**
 *  消息的总和
 *
 *  @return <#return value description#>
 */
-(int) messageCount;

/**
 *  未读消息的综合
 *
 *  @return <#return value description#>
 */
-(int)totalCount;
@end
