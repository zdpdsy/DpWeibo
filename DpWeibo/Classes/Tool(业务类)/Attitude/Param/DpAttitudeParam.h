//
//  DpAttitudeParam.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/23.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpBaseParam.h"

@interface DpAttitudeParam : DpBaseParam

/**
 *  微博id
 */
@property (assign, nonatomic) long long id;

/**
 *  默认为=smile;
 */
@property (copy, nonatomic) NSString *attitude;

@end
