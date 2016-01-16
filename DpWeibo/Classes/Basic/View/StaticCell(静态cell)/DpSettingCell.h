//
//  DpSettingCell.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/14.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DpSettingItem;

@interface DpSettingCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableview;

/**
 表格的数据模型
 */
@property (strong,nonatomic) DpSettingItem * item;

- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(int)count;

@end
