//
//  DpRepostResult.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/26.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpRepostResult.h"
#import "MJExtension.h"
#import "DpBaseText.h"

@implementation DpRepostResult
+(NSDictionary *)objectClassInArray
{
     return @{@"reposts":[DpBaseText class]};
}
@end
