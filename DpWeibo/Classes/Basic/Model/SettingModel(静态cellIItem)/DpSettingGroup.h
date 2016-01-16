//
//  DpSettingGroup.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/14.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DpSettingGroup : NSObject
/*
 组的头部标题
 **/
@property (strong,nonatomic) NSString * headerTitle;

/**
 组的尾部标题
 */
@property (strong,nonatomic) NSString * footerTitle;


/**
 组的每一行数据
 */
@property (strong,nonatomic) NSArray * items;
@end
