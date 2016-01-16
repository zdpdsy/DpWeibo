//
//  DpBaseStatusCell.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/24.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DpBaseStatusFrame;

@interface DpStatusDetailCell : UITableViewCell

@property (strong,nonatomic) DpBaseStatusFrame * statusF;

+(instancetype) cellWithTableView:(UITableView *) tableView;
@end
