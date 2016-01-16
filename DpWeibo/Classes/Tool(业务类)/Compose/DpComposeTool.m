//
//  DpComposeTool.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/13.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpComposeTool.h"
#import "DpComposeParam.h"
#import "DpUploadParam.h"
#import "DpRepostParam.h"
#import "DpCommentParam.h"
#import "DpHttpTool.h"
#import "MJExtension.h"

@implementation DpComposeTool
+(void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    DpComposeParam * param = [[DpComposeParam alloc] init];
    param.status =status;
    
    [DpHttpTool Post:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+(void)composeWithStatus:(NSString *)status Image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure
{
    DpComposeParam * param = [[DpComposeParam alloc] init];
    param.status =status;
    
    DpUploadParam * uploadP= [[DpUploadParam alloc] init];
    
    // 创建上传的模型
    uploadP.data = UIImagePNGRepresentation(image);
    uploadP.name = @"pic";
    uploadP.fileName = @"image.png";
    uploadP.mimeType = @"image/png";
    
    
    [DpHttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues uploadParam:uploadP success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+(void)repostWithWeiboId:(long long)weiboId status:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    DpRepostParam * param = [[DpRepostParam alloc] init];
    
    param.id = weiboId;
    
    param.status = status;
    
    [DpHttpTool Post:@"https://api.weibo.com/2/statuses/repost.json" parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+(void)commentWithWeiboId:(long long)weiboId status:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    DpCommentParam * param  = [[DpCommentParam alloc] init];
    param.id  = weiboId;
    param.comment = status;
    
    [DpHttpTool Post:@"https://api.weibo.com/2/comments/create.json" parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
