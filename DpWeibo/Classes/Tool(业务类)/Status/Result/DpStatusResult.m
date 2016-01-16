//
//  DpStatusResult.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/7.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpStatusResult.h"
#import "DpStatus.h"
#import "MJExtension.h"


@implementation DpStatusResult
// 实现这个方法，就会自动把数组中的字典转换成对应的模型
+(NSDictionary *)objectClassInArray
{
    return @{@"statuses":[DpStatus class]};
}
@end
