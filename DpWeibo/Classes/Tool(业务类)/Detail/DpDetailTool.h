//
//  DpDetailTool.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/26.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  微博的详细工具
 */
@interface DpDetailTool : NSObject

/**
 *  根据sinceId加载指定微博的最新评论列表数据
 *
 *  @param WeiboId 微博Id
 *  @param sinceId <#sinceId description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)loadNewCommentWithWeiboId:(NSString *)WeiboId SinceId:(NSString *) sinceId  success:(void(^)(NSArray * statuses,int totalNumber))success
                        failure:(void(^)(NSError * error)) failure;

/**
 *  根据maxId加载指定微博的之前评论列表数据
 *
 *  @param WeiboId <#WeiboId description#>
 *  @param maxId   <#maxId description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)loadMoreCommentWithWeiboId:(NSString*)WeiboId MaxId:(NSString *)maxId success:(void(^)(NSArray * statuses,int totalNumber)) success
                       failure:(void(^)(NSError * error)) failure;



/**
 *  根据sinceId加载指定微博的最转发列表数据
 *
 *  @param WeiboId 微博Id
 *  @param sinceId <#sinceId description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)loadNewRepostWithWeiboId:(NSString *)WeiboId SinceId:(NSString *) sinceId  success:(void(^)(NSArray * statuses,int totalNumber))success
                         failure:(void(^)(NSError * error)) failure;

/**
 *  根据maxId加载指定微博的之前转发列表数据
 *
 *  @param WeiboId <#WeiboId description#>
 *  @param maxId   <#maxId description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)loadMoreRepostWithWeiboId:(NSString*)WeiboId MaxId:(NSString *)maxId success:(void(^)(NSArray * statuses,int totalNumber)) success
                          failure:(void(^)(NSError * error)) failure;
@end
