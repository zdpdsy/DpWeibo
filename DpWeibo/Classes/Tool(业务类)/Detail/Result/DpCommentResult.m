//
//  DpCommentResult.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/26.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpCommentResult.h"
#import "MJExtension.h"
#import "DpBaseText.h"
@implementation DpCommentResult
+(NSDictionary *)objectClassInArray
{
    return @{@"comments":[DpBaseText class]};
}
@end
