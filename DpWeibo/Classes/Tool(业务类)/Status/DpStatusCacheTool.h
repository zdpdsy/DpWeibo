//
//  DpStatusCacheTool.h
//  DpWeibo
//
//  Created by 曾大鹏 on 16/2/24.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DpStatusParam;
@interface DpStatusCacheTool : NSObject

//模型数组 dpstatus
+(void)saveWithStatuses:(NSArray *)statuses;

+(NSArray *)statusedWithParam:(DpStatusParam *)param;
@end
