//
//  DpAttitudeTool.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/23.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpAttitudeTool.h"
#import "DpHttpTool.h"
#import "DpAttitudeParam.h"
#import "MJExtension.h"

@implementation DpAttitudeTool
+(void)attitudeWithWeiBoID:(NSString *)WeiID success:(void (^)())success failure:(void (^)(NSError *))failure
{
    DpAttitudeParam * param = [[DpAttitudeParam alloc] init];
    
    param.id = [WeiID longLongValue];
    param.attitude =@"simle";
    
    [DpHttpTool Post:@"https://api.weibo.com/2/attitudes/create.json" parameters:param.keyValues success:^(id responseObject) {
        if(success){
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
