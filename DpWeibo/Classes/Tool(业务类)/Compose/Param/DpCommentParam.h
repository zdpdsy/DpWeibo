//
//  DpCommentParam.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/27.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpBaseParam.h"

@interface DpCommentParam : DpBaseParam
/**
 *  需要查询的微博ID。
 */
@property (assign, nonatomic) long long id;

/**
 *  评论内容
 */
@property (nonatomic, copy) NSString *comment;
@end
