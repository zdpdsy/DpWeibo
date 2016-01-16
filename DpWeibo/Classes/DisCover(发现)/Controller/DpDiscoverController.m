//
//  DpDiscoverController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/1.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpDiscoverController.h"
#import "DpSearchBar.h"
#import "DpSettingGroup.h"
#import "DpSettingLabelItem.h"
#import "DpSettingArrowItem.h"
#import "DpSettingBadgeItem.h"
#import "DpHeaderView.h"
#import "DpProfileCell.h"

@interface DpDiscoverController ()

@end

@implementation DpDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DpSearchBar * searchView = [[DpSearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
    searchView.placeholder=@"大家都在搜";
    
    self.navigationItem.titleView = searchView;
    
    //添加第一组
    
    [self setUpGroups0];
    
    //添加第二组
    [self setUpGroups1];
    
    //添加第三组
    [self setUpGroups2];
    
    self.tableView.tableHeaderView = [DpHeaderView headView];
}

-(void)setUpGroups0{

    //热门微博
    DpSettingBadgeItem * hot = [DpSettingBadgeItem initWithTitle:@"热门微博" image:
                                [UIImage imageNamed:@"hot_status"]
                                ];
    hot.subTitle = @"全站最热微博尽搜罗";
    hot.badgeValue = @"1";
    
    
    //找人
    
    DpSettingLabelItem * findp  = [DpSettingLabelItem initWithTitle:@"找人" image:[UIImage imageNamed:@"find_people"]];
    
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.items =@[hot,findp];
    
    [self.groups addObject:group];
}

-(void)setUpGroups1{
    //奔跑2015
     DpSettingLabelItem * running =[DpSettingLabelItem initWithTitle:@"奔跑2015" image:[UIImage imageNamed:@"game_center"]];
    
    //玩游戏
    DpSettingBadgeItem * gamecenter =[DpSettingBadgeItem initWithTitle:@"玩游戏" image:[UIImage imageNamed:@"game_center"]];
    gamecenter.badgeValue = @"1";
    
    //周边
    DpSettingLabelItem * near  = [DpSettingLabelItem initWithTitle:@"周边" image:[UIImage imageNamed:@"near"]];
    
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.items =@[running,gamecenter,near];
    
    [self.groups addObject:group];
    
}

-(void)setUpGroups2{

    //微博之夜
    DpSettingLabelItem * weibonight = [DpSettingLabelItem initWithTitle:@"微博之夜" image:[UIImage imageNamed:@"movie"]];
    
    
    //股票
     DpSettingLabelItem * stock = [DpSettingLabelItem initWithTitle:@"股票" image:[UIImage imageNamed:@"movie"]];
    
    //听歌
    DpSettingLabelItem * music = [DpSettingLabelItem initWithTitle:@"听歌" image:[UIImage imageNamed:@"music"]];
    
    //购物
    
     DpSettingLabelItem * shopping = [DpSettingLabelItem initWithTitle:@"购物" image:[UIImage imageNamed:@"movie"]];
    
    //旅游
     DpSettingLabelItem * travel = [DpSettingLabelItem initWithTitle:@"旅游" image:[UIImage imageNamed:@"movie"]];
    
    //电影
    DpSettingLabelItem * movie = [DpSettingLabelItem initWithTitle:@"微博之夜" image:[UIImage imageNamed:@"movie"]];
    
    //更多频道
    DpSettingLabelItem * more = [DpSettingLabelItem initWithTitle:@"更多频道" image:[UIImage imageNamed:@"more"]];
    
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.items =@[weibonight,stock,music,shopping,travel,movie,more];
    
    [self.groups addObject:group];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
