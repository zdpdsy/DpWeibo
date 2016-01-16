//
//  DpBaseParam.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/8.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpBaseParam.h"
#import "DpAccountTool.h"
#import "DpAccount.h"
@implementation DpBaseParam
-(NSString *)access_token
{
    return [DpAccountTool account].access_token;
}
@end
