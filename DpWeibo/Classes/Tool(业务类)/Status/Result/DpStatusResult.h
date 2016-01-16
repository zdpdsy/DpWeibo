//
//  DpStatusResult.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/7.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DpStatusResult : NSObject
/**
 *  用户的微博数组（DpStatus）
 */
@property (nonatomic, strong) NSArray *statuses;
///**
// *  用户最近微博总数
// */
//@property (nonatomic, assign) int *total_number;
@end
