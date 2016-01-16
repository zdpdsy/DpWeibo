//
//  DpBaseTextCell.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/26.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DpBaseTextCellFrame;

@interface DpBaseTextCell : UITableViewCell

@property (strong,nonatomic) DpBaseTextCellFrame * cellFrame;

@property(nonatomic, strong)NSIndexPath *indexPath;
@property(nonatomic, weak)UITableView *myTableView;

+(instancetype)cellWithTableView:(UITableView *)tableView  reuseIdentifier:(NSString *) reuseIdentifier;
- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(int)count;

@end
