//
//  DpProfileViewController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/1.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpProfileViewController.h"
#import "DpSettingGroup.h"
#import "DpSettingSwithItem.h"
#import "DpSettingLabelItem.h"
#import "DpSettingArrowItem.h"
#import "DpProfileCell.h"

#import "DpSettingViewController.h"
@implementation DpProfileViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setUpNavBar];
   
    //设置第一组
    [self setUpGroups0];
    
    //设置第二组
    [self setUpGroups1];
    
    //设置第三组
    [self setUpGroups2];
    
    //设置第三组
    [self setUpGroups3];
    
    
    
}

-(void) setUpGroups0
{
    // 新的好友
    DpSettingArrowItem *friend = [DpSettingArrowItem initWithTitle:@"新的好友" image:[UIImage imageNamed:@"new_friend"]];
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.items = @[friend];
    [self.groups addObject:group];
    

}

-(void) setUpGroups1
{
    //我的相册
    DpSettingArrowItem * album = [DpSettingArrowItem initWithTitle:@"我的相册" image:[UIImage imageNamed:@"album"]];
    
    album.subTitle = @"(12)";
    
    //我的收藏
    DpSettingArrowItem * collect = [DpSettingArrowItem initWithTitle:@"我的收藏" image:[UIImage imageNamed:@"collect"]];
    
    collect.subTitle = @"(0)";
    
    //赞
    DpSettingArrowItem * like = [DpSettingArrowItem initWithTitle:@"赞" image:[UIImage imageNamed:@"like"]];
    
    like.subTitle = @"(0)";

    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.items = @[album,collect,like];
    
    [self.groups addObject:group];
    
    
}

-(void)setUpGroups2
{
    //微博支付
    DpSettingArrowItem * weibopay = [DpSettingArrowItem initWithTitle:@"微博支付" image:[UIImage imageNamed:@"pay"]];
    
   
    
    //个性化
    DpSettingArrowItem * vip = [DpSettingArrowItem initWithTitle:@"个性化" image:[UIImage imageNamed:@"vip"]];
     vip.subTitle = @"微博来源、皮肤、封面图";
    
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.items = @[weibopay,vip];
    
    [self.groups addObject:group];
    

}

-(void)setUpGroups3
{
    //二维码
    DpSettingArrowItem * code = [DpSettingArrowItem initWithTitle:@"我的二维码" image:[UIImage imageNamed:@"card"]];
    
    
    //个性化
    DpSettingArrowItem * draft = [DpSettingArrowItem initWithTitle:@"草稿箱" image:[UIImage imageNamed:@"draft"]];

    
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.items = @[code,draft];
    
    [self.groups addObject:group];
    
}
//设置导航条
-(void)setUpNavBar
{
    UIBarButtonItem * profile = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(settingBtnClick)];
    
    
    self.navigationItem.rightBarButtonItem = profile;
}

//跳转到我的设置页面
-(void)settingBtnClick
{
    DpSettingViewController * setting = [[DpSettingViewController alloc] init];
    
    [self.navigationController pushViewController:setting animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DpProfileCell *cell = [DpProfileCell cellWithTableView:tableView];
    
    // 获取模型
    DpSettingGroup *groupItem = self.groups[indexPath.section];
    DpSettingItem *item = groupItem.items[indexPath.row];
    
    // 设置模型
    cell.item = item;
    
    [cell setIndexPath:indexPath rowCount:groupItem.items.count];
    return cell;
}



-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
