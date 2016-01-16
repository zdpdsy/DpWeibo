//
//  DpRepostResult.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/26.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DpRepostResult : NSObject

/**
 *  转发明细
 */
@property (strong,nonatomic) NSArray * reposts;

/**
 *  返回的总数
 */
@property (assign, nonatomic) int total_number;
@end
