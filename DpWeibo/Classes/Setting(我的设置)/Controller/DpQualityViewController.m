//
//  DpQualityViewController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/18.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpQualityViewController.h"
#import "DpSettingItem.h"
#import "DpSettingGroup.h"
#import "DpSettingCheckItem.h"
#import "DpProfileCell.h"

@interface DpQualityViewController ()
@property (strong,nonatomic) DpSettingCheckItem * selUploadItem;

@property (strong,nonatomic) DpSettingCheckItem * selDownloadItem;

@end

@implementation DpQualityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //第0组
    [self setUpGroups0];
    
    //第1组
    [self setUpGroups1];
    
   
    // Do any additional setup after loading the view.
}



-(void)setUpGroups0{

    
    DpSettingCheckItem * high = [[DpSettingCheckItem alloc] initWithTitle:@"高清"];
    high.subTitle = @"建议在WiFi或3G网络使用";
    __weak typeof(self) vc = self;
    high.Operation =^{
        [vc selUploadItem:high];
    };
    
    
    DpSettingCheckItem * middle = [[DpSettingCheckItem alloc] initWithTitle:@"普通"];
    middle.subTitle = @"上传速度快，省流量";
    middle.Operation = ^{
        [vc selUploadItem:middle];
    };
    
    
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.headerTitle = @"上传图片质量";
    group.items  =@[high,middle];
    [self.groups addObject:group];
    
    //默认高清
    // 默认选中第0组的一行
    NSString *downLoad = [DpUserDefaults objectForKey:DpSelUploadKey];
    if (downLoad == nil) {
        [self selUploadItem:high];
        return;
    }
    
    for (DpSettingCheckItem *checkitem in group.items) {
        if ([checkitem.title isEqualToString:downLoad]) {
            [self selUploadItem:checkitem];
        }
    }
    
}

-(void)setUpGroups1{
    DpSettingCheckItem * high = [[DpSettingCheckItem alloc] initWithTitle:@"高清"];
    high.subTitle = @"建议在WiFi或3G网络使用";
    high.Check = YES;
    DpSettingCheckItem * middle = [[DpSettingCheckItem alloc] initWithTitle:@"普通"];
    middle.subTitle = @"下载速度快，省流量";
    
    
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.headerTitle = @"下载图片质量";
    group.items  =@[high,middle];
    
    [self.groups addObject:group];

    //默认高清
    // 默认选中第0组的一行
    NSString *downLoad = [DpUserDefaults objectForKey:DpSelDownloadKey];
    if (downLoad == nil) {
        [self selDownloadItem:high];
        
        return;
    }
    
    for (DpSettingCheckItem *checkitem in group.items) {
        if ([checkitem.title isEqualToString:downLoad]) {
            [self selDownloadItem:checkitem];
        }
    }
}

//选中下载
-(void)selUploadItem:(DpSettingCheckItem *) item
{
    _selUploadItem.Check = NO;
    item.Check = YES;
    _selUploadItem = item;
    
    [self.tableView reloadData];//重新刷新
    
    //存储
    [DpUserDefaults setObject:item.title forKey:DpSelUploadKey];
    [DpUserDefaults synchronize];//同步

}

//选中上传
-(void)selDownloadItem:(DpSettingCheckItem *)item
{
    _selDownloadItem.Check = NO;
    item.Check = YES;
    _selDownloadItem = item;
    
    [self.tableView reloadData];//重新刷新
    
    //存储
    [DpUserDefaults setObject:item.title forKey:DpSelDownloadKey];
    [DpUserDefaults synchronize];//同步
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview代理方法
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


@end
