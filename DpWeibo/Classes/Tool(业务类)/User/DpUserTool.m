//
//  DpUserTool.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/8.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpUserTool.h"
#import "DpUserParam.h"
#import "DpUserResult.h"
#import "DpUser.h"

#import "DpAccount.h"
#import "DpAccountTool.h"

#import "DpHttpTool.h"

#import "MJExtension.h"
@implementation DpUserTool
+(void)unreadCount:(void (^)(DpUserResult *))success failure:(void (^)(NSError *))failure
{
    
    DpUserParam * param = [[DpUserParam alloc] init];
    
    param.uid =[DpAccountTool account].uid;
    
    //NSLog(@"uid=%@ ,access_token=%@",param.uid,param.access_token);
    [DpHttpTool Get:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        
        //字典转模型
        DpUserResult * result = [DpUserResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+(void)userInfoWithSuccess:(void (^)(DpUser *))success failure:(void (^)(NSError *))failure
{
    DpUserParam * param = [[DpUserParam alloc] init];
    
    param.uid = [DpAccountTool account].uid;
    
    [DpHttpTool Get:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        
        //字典转模型
        DpUser * user = [DpUser objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
