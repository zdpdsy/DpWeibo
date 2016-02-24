//
//  DpAccountTool.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/6.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpAccountTool.h"
#import "DpHttpTool.h"
#import "DpAccountParam.h"
#import "MJExtension.h"




@implementation DpAccountTool
static DpAccount * _account;

+(void)saveAccount:(DpAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:DpAccountFileName];
}

+(DpAccount *)account
{
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:DpAccountFileName];
        
        // 判断下账号是否过期，如果过期直接返回Nil
        if ([_account.expires_date compare:[NSDate date]] == NSOrderedAscending) {
            return nil;
        }
    }
    return _account;
}

+(void)accessTokenWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSString * url = @"https://api.weibo.com/oauth2/access_token";
    
    DpAccountParam * params = [[DpAccountParam alloc] init];
    
    params.client_id = sinaClientId;
    
    params.client_secret = sinaClientSecret;
    params.grant_type = @"authorization_code";
    params.code = code;
    params.redirect_uri = sinaRedirectUri;
    
//    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//    
//    dict[@"client_id"] = client_id;
//    dict[@"client_secret"] = client_secret;
//    dict[@"grant_type"] = @"authorization_code";
//    dict[@"code"] = code;
//    dict[@"redirect_uri"] = redirect_uri;
    [DpHttpTool Post:url parameters:params.keyValues success:^(id responseObject) {
        
        NSLog(@"success ok result = %@",responseObject);
        
        
        //保存用户信息 归档
        DpAccount * account = [DpAccount accountWithDict:responseObject];
        
        [DpAccountTool saveAccount:account];
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
