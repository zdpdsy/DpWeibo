//
//  DpCommentResult.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/26.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DpCommentResult : NSObject
/**
 *  评论明细
 */
@property (strong,nonatomic) NSArray * comments;
/**
 *  返回的总数
 */
@property (assign, nonatomic) int total_number;
@end
