//
//  DpMessageViewController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/1.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpMessageViewController.h"
#import "DpSettingGroup.h"
#import "DpSettingArrowItem.h"
#import "DpProfileCell.h"
@implementation DpMessageViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * chat = [[UIBarButtonItem alloc] initWithTitle:@"发起聊天" style:UIBarButtonItemStyleBordered target:self action:nil];
    
    self.navigationItem.rightBarButtonItem =chat;
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpGroups0];
}

-(void)setUpGroups0
{
    // @我的
    DpSettingArrowItem *attentmy = [DpSettingArrowItem initWithTitle:@"@我的" image:[UIImage imageNamed:@"messagescenter_at"]];

    //评论
    DpSettingArrowItem * comment = [DpSettingArrowItem initWithTitle:@"评论" image:
                                    [UIImage imageNamed:@"messagescenter_comments"]
                                    
                                    ];
    
    //赞
    DpSettingArrowItem * agree = [DpSettingArrowItem initWithTitle:@"赞" image:
                                  [UIImage imageNamed:@"messagescenter_good"]
                                  
                                    ];
    //订阅信息
    DpSettingArrowItem * dingmsg = [DpSettingArrowItem initWithTitle:@"订阅信息" image:
                                    [UIImage imageNamed:@"messagescenter_subscription"]
                                    
                                    ];
    DpSettingArrowItem * msg = [DpSettingArrowItem initWithTitle:@"未关注人消息" image:
                                [UIImage imageNamed:@"messagescenter_messagebox"]
                                ];
    
    DpSettingGroup * group  =[[DpSettingGroup alloc] init];
    
    group.items = @[attentmy,comment,agree,dingmsg,msg];
    
    [self.groups addObject:group];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DpProfileCell *cell = [DpProfileCell cellWithTableView:tableView];
    // 获取模型
    DpSettingGroup *groupItem = self.groups[indexPath.section];
    DpSettingItem *item = groupItem.items[indexPath.row];
    
    // 设置模型
    cell.item = item;
    //NSLog(@"%lf",cell.imageView.height);
    cell.imageView.layer.cornerRadius= 24;
    cell.imageView.layer.masksToBounds = YES;
    
    [cell setIndexPath:indexPath rowCount:groupItem.items.count];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
