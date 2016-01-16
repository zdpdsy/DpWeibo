//
//  DpDetailTool.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/26.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpDetailTool.h"
#import "DpHttpTool.h"
#import "DpAccountTool.h"
#import "DpDetailParam.h"
#import "MJExtension.h"

#import "DpRepostResult.h"
#import "DpCommentResult.h"
@implementation DpDetailTool
+(void)loadMoreRepostWithWeiboId:(NSString *)WeiboId MaxId:(NSString *)maxId success:(void (^)(NSArray *,int))success failure:(void (^)(NSError *))failure
{
    DpDetailParam * param = [[DpDetailParam alloc] init];
    
    param.count = DpRepostsCount;
    param.id= [WeiboId longLongValue];
    
    if (maxId) {
        param.max_id = maxId;
    }
    
    [DpHttpTool Get:@"https://api.weibo.com/2/statuses/repost_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        DpRepostResult * result = [DpRepostResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.reposts,result.total_number);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}

+(void)loadNewRepostWithWeiboId:(NSString *)WeiboId SinceId:(NSString *)sinceId success:(void (^)(NSArray *,int))success failure:(void (^)(NSError *))failure
{
    DpDetailParam * param = [[DpDetailParam alloc] init];
    
    param.id= [WeiboId longLongValue];
    param.count = DpRepostsCount;
    
    if (sinceId) {
        param.since_id = sinceId;
    }
    
    [DpHttpTool Get:@"https://api.weibo.com/2/statuses/repost_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        DpRepostResult * result = [DpRepostResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.reposts,result.total_number);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)loadNewCommentWithWeiboId:(NSString *)WeiboId SinceId:(NSString *)sinceId success:(void (^)(NSArray *,int))success failure:(void (^)(NSError *))failure
{
    DpDetailParam * param = [[DpDetailParam alloc] init];
    param.id= [WeiboId longLongValue];
    param.count = DpCommentsCount;
    if (sinceId) {
        param.since_id = sinceId;
    }
    
    [DpHttpTool Get:@"https://api.weibo.com/2/comments/show.json" parameters:param.keyValues success:^(id responseObject) {
        DpCommentResult * result = [DpCommentResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.comments,result.total_number);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)loadMoreCommentWithWeiboId:(NSString *)WeiboId MaxId:(NSString *)maxId success:(void (^)(NSArray *,int))success failure:(void (^)(NSError *))failure
{
    DpDetailParam * param = [[DpDetailParam alloc] init];    
    param.id= [WeiboId longLongValue];
    param.count = DpCommentsCount;
    if (maxId) {
        param.max_id = maxId;
    }
    
    [DpHttpTool Get:@"https://api.weibo.com/2/comments/show.json" parameters:param.keyValues success:^(id responseObject) {
        DpCommentResult * result = [DpCommentResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.comments,result.total_number);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
