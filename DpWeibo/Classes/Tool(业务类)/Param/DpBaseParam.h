//
//  DpBaseParam.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/8.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DpBaseParam : NSObject
/**
 *  采用OAuth授权方式为必填参数,访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;
@end
