//
//  DpStatusTool.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/7.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  微博工具类
 */
@interface DpStatusTool : NSObject


/**
 *  根据sinceId加载最新的微博数据
 *
 *  @param sinceId <#sinceId description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)loadNewStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray * statuses))success
                        failure:(void(^)(NSError * error)) failure;

/**
 *  根据maxId加载之前的微博数据
 *
 *  @param maxId   <#maxId description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)loadMoreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray * statuses)) success
                        failure:(void(^)(NSError * error)) failure;
                                                          
@end
