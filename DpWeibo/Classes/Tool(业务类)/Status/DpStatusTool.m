//
//  DpStatusTool.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/7.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpStatusTool.h"
#import "DpHttpTool.h"
#import "DpAccountTool.h"

#import "DpStatus.h"
#import "DpStatusParam.h"
#import "DpStatusResult.h"

#import "MJExtension.h"

@implementation DpStatusTool
+(void)loadMoreStatusWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSString * url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    
    DpStatusParam * params = [[DpStatusParam alloc] init];
    
    params.access_token =[DpAccountTool account].access_token;
    if (maxId) {//// 有微博数据，才需要上拉加载更多
        params.max_id = maxId;
    }
    
    
     //封装一下代码
//    NSMutableDictionary * params = [NSMutableDictionary dictionary];
//    
//    params[@"access_token"] = [DpAccountTool account].access_token;
//    
//    
//    params[@"max_id"] = maxId;
    
    [DpHttpTool Get:url parameters:params.keyValues success:^(id responseObject) {
        
        // //数据转模型
        // //1.获取字典数据
        // NSArray * dictArr  = responseObject[@"statuses"];
        //
        ////2.字典转模型
        // NSArray * status = (NSMutableArray *)[DpStatus objectArrayWithKeyValuesArray:dictArr];
        
        
        DpStatusResult * result = [DpStatusResult objectWithKeyValues:responseObject];
        
        
        if (success) {
            success(result.statuses);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+(void)loadNewStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSString * url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    
    DpStatusParam * params = [[DpStatusParam alloc] init];
    
    params.access_token =[DpAccountTool account].access_token;
    if(sinceId){ //有数据的时候 才会加载下拉刷新数据
        params.since_id = sinceId;
    }
     //封装一下代码
//    NSMutableDictionary * params = [NSMutableDictionary dictionary];
//    
//    params[@"access_token"] = [DpAccountTool account].access_token;
//    
//    
//    params[@"sinceId"] = sinceId;
    
    [DpHttpTool Get:url parameters:params.keyValues success:^(id responseObject) {
//        //数据转模型
//        //1.获取字典数据
//        NSArray * dictArr  = responseObject[@"statuses"];
//        
//        //2.字典转模型
//        NSArray * status = (NSMutableArray *)[DpStatus objectArrayWithKeyValuesArray:dictArr];
        
         DpStatusResult * result = [DpStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
@end
