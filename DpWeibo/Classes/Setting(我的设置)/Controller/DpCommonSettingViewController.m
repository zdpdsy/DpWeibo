//
//  DpCommonSettingViewController.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/15.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpCommonSettingViewController.h"
#import "DpFontSizeViewController.h"
#import "DpQualityViewController.h"

#import "DpSettingGroup.h"

#import "DpSettingItem.h"
#import "DpSettingSwithItem.h"
#import "DpSettingLabelItem.h"
#import "DpSettingArrowItem.h"
#import "DpSettingBadgeItem.h"
#import "UIImageView+WebCache.h"

@interface DpCommonSettingViewController ()
@property (weak,nonatomic) DpSettingItem  * fontSize;
@end

@implementation DpCommonSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加第0组
    [self setUpGroup0];
    // 添加第1组
    [self setUpGroup1];
    // 添加第2组
    [self setUpGroup2];
    // 添加第3组
    [self setUpGroup3];
    
    //添加第4组
    [self setUpGroup4];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fontSizeChange:) name:DpFontSizeChangeNote object:nil];
    
    
    // Do any additional setup after loading the view.
}

-(void)fontSizeChange:(NSNotification *)notication
{
    
    _fontSize.subTitle = notication.userInfo[DpFontSizeKey];
    [self.tableView reloadData];
}

-(void)setUpGroup0{
    //阅读模式
    DpSettingItem * read = [[DpSettingItem alloc] initWithTitle:@"阅读模式"];
    read.subTitle =@"有图模式";
    
    //字体大小
    DpSettingItem * font = [[DpSettingItem alloc] initWithTitle:@"字体大小"];
    NSString *fontSizeStr =  [DpUserDefaults objectForKey:DpFontSizeKey];
    if (fontSizeStr == nil) {
        fontSizeStr = @"中";
    }
    font.subTitle =fontSizeStr;
    font.descVc = [DpFontSizeViewController class];
    _fontSize = font;
    
    //显示备注
    DpSettingSwithItem * remark = [[DpSettingSwithItem alloc] initWithTitle:@"显示备注"];
    
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    
    group.items=@[read,font,remark];
    
    [self.groups addObject:group];
    
}

-(void)setUpGroup1{
    //图片质量
    DpSettingArrowItem * imageQuality = [[DpSettingArrowItem alloc] initWithTitle:@"图片质量"];
    
    imageQuality.descVc = [DpQualityViewController class];
    
    
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.items = @[imageQuality];
    
    [self.groups addObject:group];
}
-(void)setUpGroup2{
    //声音
    DpSettingSwithItem * sound = [[DpSettingSwithItem alloc] initWithTitle:@"声音"];
    
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.items = @[sound];
    
    [self.groups addObject:group];

}
-(void)setUpGroup3{
    //多语言环境
    DpSettingItem * language = [[DpSettingItem alloc] initWithTitle:@"多语言环境"];
    language.subTitle = @"跟随系统";
    
    
    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.items = @[language];
    
    [self.groups addObject:group];

}
-(void)setUpGroup4{
    //清空图片缓存
    DpSettingArrowItem * clearImage = [[DpSettingArrowItem alloc] initWithTitle:@"清空图片缓存"];
    
    
    //计算缓存大小
    CGFloat fileSize = [SDWebImageManager sharedManager].imageCache.getSize/1024.0;
    
    clearImage.subTitle =[NSString stringWithFormat:@"%.fKB",fileSize];
    
    if (fileSize >1024){
        fileSize =  fileSize/1024.0;
        clearImage.subTitle = [NSString stringWithFormat:@"%.1fM",fileSize];
    }
    
    //cache目录
    NSString * docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    //sdwebimagecache路径
    NSString * cachefilePath = [docPath stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    
    CGFloat calsize = [self sizeWithFile:cachefilePath];
    
    // NSLog(@"astring:%@",cachefilePath);
    
    
    
    clearImage.Operation = ^{
        
        [[SDWebImageManager sharedManager].imageCache clearDisk];
        clearImage.subTitle = nil;
        [self.tableView reloadData];
        
        
        //     NSString *docPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        //      NSString *filePath = [docPath stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
        //
        //        [self removeFile:filePath];
        
    };

    DpSettingGroup * group = [[DpSettingGroup alloc] init];
    group.items =@[clearImage];
    [self.groups addObject:group];
    
}

-(CGFloat) sizeWithFile:(NSString *) filePath
{
    CGFloat totalSize = 0;
    NSFileManager * manager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExtenist = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (isExtenist) {
        if (isDirectory) {
            
            //获取当前目录下的所有子文件目录
            NSArray * subPathArr  = [manager subpathsAtPath:filePath];
            for (NSString * subPath in subPathArr) {
                NSString * fullPath = [filePath stringByAppendingPathComponent:subPath];
                
                [manager fileExistsAtPath:fullPath isDirectory:&isDirectory];
                if (!isDirectory) {//计算文件尺寸
                    NSDictionary * dict  = [manager attributesOfItemAtPath:fullPath error:nil];
                    
                    totalSize += [dict[NSFileSize] floatValue];
                    
                }
            }
            
        }else{
            
            //获取指定文件的文件属性
            NSDictionary *dict =  [manager attributesOfItemAtPath:filePath error:nil];

            totalSize = [dict[NSFileSize] floatValue];
        }
        
    }
    return totalSize;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
