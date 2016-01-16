//
//  DpAccountTool.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/6.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DpAccount.h"
@class DpAccount;
@interface DpAccountTool : NSObject

/**
 *  保存account实体 归档
 *
 *  @param account <#account description#>
 */
+(void) saveAccount:(DpAccount *) account;

/**
 *  获取实体 解档
 *
 *  @return <#return value description#>
 */
+(DpAccount*)account;



/**
 *  获取access_token by code
 *
 *  @param code    <#code description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+(void)accessTokenWithCode:(NSString *)code success:(void(^)())success
                   failure:(void(^)(NSError * error))failure;
         
@end
