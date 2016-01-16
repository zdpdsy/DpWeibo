//
//  DpStatusDetailController.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/24.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DpStatus;
@interface DpStatusDetailController : UITableViewController
/**
 *  当前微博数据
 */
@property (strong,nonatomic) DpStatus * status;
@end
