//
//  DpStatusParam.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/7.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DpBaseParam.h"
// 参数模型如何设计，直接参考接口文档的参数列表
@interface DpStatusParam : DpBaseParam


/**
 *  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 */
@property (nonatomic, copy) NSString *since_id;
/**
 *  若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
@property (nonatomic, copy) NSString *max_id;

@end
