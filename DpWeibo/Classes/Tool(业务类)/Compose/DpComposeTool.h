//
//  DpComposeTool.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/13.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DpComposeTool : NSObject
//void (^)(DpUser *)

/**
 *  发送文字微博
 *
 *  @param status  发送微博内容
 *  @param success 成功回调函数
 *  @param failure 失败回调函数
 */
+(void)composeWithStatus:(NSString *) status success:(void(^)())success failure:(void(^)(NSError * error))failure;

/**
 *  发送图片微博
 *
 *  @param status  文字内容
 *  @param image   配图
 *  @param success 成功回调函数
 *  @param failure 失败回调函数
 */
+(void)composeWithStatus:(NSString *) status Image:(UIImage *) image success:(void(^)())success failure:(void(^)(NSError * error)) failure;

/**
 *  转发指定微博
 *
 *  @param weiboId 微博ID
 *  @param status  内容
 *  @param success 成功回调函数
 *  @param failure 失败回调函数
 */
+(void)repostWithWeiboId:(long long )weiboId status:(NSString *)status  success:(void(^)())success failure:(void(^)(NSError * error)) failure;

/**
 *  评论指定微博
 *
 *  @param weiboId 微博ID
 *  @param status  内容
 *  @param success 成功回调函数
 *  @param failure 失败回调函数
 */
+(void)commentWithWeiboId:(long long)weiboId status:(NSString *)status success:(void(^)())success
                  failure:(void(^)(NSError * error)) failure;

@end
