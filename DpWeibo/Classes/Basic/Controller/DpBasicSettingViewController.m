//
//  DpBasicSettingViewController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/14.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpBasicSettingViewController.h"
#import "DpSettingGroup.h"
#import "DpSettingCell.h"
#import "DpSettingItem.h"


@interface DpBasicSettingViewController ()

@end

@implementation DpBasicSettingViewController

//懒加载
-(NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

#pragma mark 只要调用 init 方法，就返回组样式表格
-(instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor  = DpColor(211,211,211);
    
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    DpSettingGroup * groupItem  = self.groups[section];
    
    return groupItem.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //自定义一个tableViewCell
    DpSettingCell * cell = [DpSettingCell cellWithTableView:tableView];
    
    //获取模型数据
    DpSettingGroup * group = self.groups[indexPath.section];
    DpSettingItem * item = group.items[indexPath.row];
    
    cell.item= item;
    
    [cell setIndexPath:indexPath rowCount:group.items.count];
    // Configure the cell...
    
    return cell;
}



#pragma mark 组的头部名字
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    DpSettingGroup * group = self.groups[section];
    return  group.headerTitle;
}
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    DpSettingGroup * group = self.groups[section];
    return group.footerTitle;
}

#pragma mark - cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //获取模型数据
    DpSettingGroup * group = self.groups[indexPath.section];
    DpSettingItem * item = group.items[indexPath.row];
    
    //如果有block
    if (item.Operation) {
        item.Operation();
    }else if(item.descVc){ //如果要跳转控制器
        //创建控制器并且显示
        id vc = [[item.descVc alloc] init];
        //设置title
        [vc setTitle:item.title];
        //跳转
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end
