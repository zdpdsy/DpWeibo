//
//  DpUserTool.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/8.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 
 必选	类型及范围	说明
 source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
 access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 uid	true	int64	需要获取消息未读数的用户UID，必须是当前登录用户。
 callback	false	string	JSONP回调函数，用于前端调用返回JS格式的信息。
 unread_message	false	boolean	未读数版本。0：原版未读数，1：新版未读数。默认为0。
 */
@class DpUserResult,DpUser;
@interface DpUserTool : NSObject



/**
*  获取某个用户的各种消息未读数
*
*  @param success 请求成功后的回调函数
*  @param failure 请求失败后的回调函数
*/
+(void) unreadCount:(void(^)(DpUserResult * result)) success failure:(void(^)(NSError * error)) failure;

/**
 *  获取用户信息
 *
 *  @param success <#success description#>
 */
+(void) userInfoWithSuccess:(void(^)(DpUser* user))success failure:(void(^)(NSError * error)) failure;
@end
