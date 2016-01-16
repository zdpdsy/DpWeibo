//
//  DpFontSizeViewController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/18.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpFontSizeViewController.h"
#import "DpSettingCheckItem.h"
#import "DpSettingGroup.h"
@interface DpFontSizeViewController ()

@property (nonatomic, strong) DpSettingCheckItem * selCheckItem;

@end

@implementation DpFontSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpGroup0];
    
    // Do any additional setup after loading the view.
}
-(void)setUpSelItem:(DpSettingCheckItem*)item
{

    NSString * fontSizeStr = [DpUserDefaults objectForKey:DpFontSizeKey];
    if (fontSizeStr ==nil) {
        [self selItem:item];
        return ;
    }
    
    for (DpSettingGroup * group in self.groups) {
        for (DpSettingCheckItem * checkItem in group.items) {
            if ([checkItem.title isEqualToString:fontSizeStr]) {
                [self selItem:checkItem];
            }
        }
    }
}
- (void)setUpGroup0
{
    //大
    DpSettingCheckItem * bigItem = [[DpSettingCheckItem alloc] initWithTitle:@"大"];
    __weak typeof(self) vc = self;
    
    bigItem.Operation = ^{
        [vc selItem:bigItem];
    };
    //中 默认选中
    DpSettingCheckItem  *middleItem  =[[DpSettingCheckItem alloc] initWithTitle:@"中"];
    middleItem.Operation = ^{
        [vc selItem:middleItem];
    };
    _selCheckItem = middleItem;
    
    //小
    DpSettingCheckItem * smallItem  =[[DpSettingCheckItem alloc] initWithTitle:@"小"];
    
    smallItem.Operation =^{
        [vc selItem:smallItem];
    };
    
    DpSettingGroup * group  = [[DpSettingGroup  alloc] init];
    group.headerTitle =@"设置字体大小";
    
    group.items  =@[bigItem,middleItem,smallItem];
    
    [self.groups addObject:group];
    
    // 默认选中item
    [self setUpSelItem:middleItem];
}

- (void)selItem:(DpSettingCheckItem *)item
{
    _selCheckItem.Check = NO;
    item.Check = YES;
    _selCheckItem = item;
    [self.tableView reloadData];//重新刷新
    
    //存储
    [DpUserDefaults setObject:item.title forKey:DpFontSizeKey];
    [DpUserDefaults synchronize];//同步
    
    //发送通知
    
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:DpFontSizeChangeNote object:nil userInfo:@{DpFontSizeKey:item.title}];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
