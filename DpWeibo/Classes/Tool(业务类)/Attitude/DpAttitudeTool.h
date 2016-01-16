//
//  DpAttitudeTool.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/23.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DpAttitudeTool : NSObject

/**
 *  点赞微博
 *
 *  @param status  文字内容
 *  @param image   配图
 *  @param success 成功回调函数
 *  @param failure 失败回调函数
 */
+(void)attitudeWithWeiBoID:(NSString *) WeiID  success:(void(^)())success failure:(void(^)(NSError * error)) failure;

@end
