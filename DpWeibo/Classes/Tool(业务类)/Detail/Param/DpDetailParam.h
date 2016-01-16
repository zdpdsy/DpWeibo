//
//  DpDetailParam.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/26.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DpBaseParam.h"

@interface DpDetailParam : DpBaseParam

/**
 *  需要查询的微博ID。
 */
@property (assign, nonatomic) long long id;


/**

 *  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 */
@property (nonatomic, copy) NSString *since_id;
/**
 *  若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
@property (nonatomic, copy) NSString *max_id;

/**
 *  单页返回的记录条数，默认为50。
 */
@property (assign, nonatomic) int count;

@end
