//
//  DpSettingItem.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/14.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^OperationBlock)();

@interface DpSettingItem : NSObject

/**
 *  标题
 */
@property (copy,nonatomic) NSString * title;

/**
 *  子标题
 */
@property (copy,nonatomic) NSString * subTitle;

/**
 *  图标
 */
@property (nonatomic, strong) UIImage * icon;


 /**
 *  存储一个特殊的Block 操作
 *   block 使用copy
 */

@property (copy,nonatomic) OperationBlock  Operation;

/**
 *  控制器类型
 */
@property (nonatomic, assign) Class descVc;

-(instancetype) initWithTitle:(NSString *)title;

+(instancetype) initWithTitle:(NSString *) title image:(UIImage *) image;

+(instancetype) initWithIcon:(UIImage *)image title:(NSString *)title descVc:(Class) descVc;


@end
