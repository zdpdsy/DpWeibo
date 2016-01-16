//
//  DpStatusCell.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/9.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DpStatusFrame;
@class DpStatusToolBar;

@interface DpStatusCell : UITableViewCell

@property (strong,nonatomic) DpStatusFrame * statusF;


+(instancetype) cellWithTableView:(UITableView *) tableView;

/**
 *  微博底部工具条
 */
@property (strong,nonatomic) DpStatusToolBar * statusToolBar;
@end
