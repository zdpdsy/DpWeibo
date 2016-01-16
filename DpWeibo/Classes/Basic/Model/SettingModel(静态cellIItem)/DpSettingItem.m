//
//  DpSettingItem.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/14.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpSettingItem.h"

@implementation DpSettingItem

-(instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        self.title = title;
    }
    return self;
}

+(instancetype)initWithTitle:(NSString *)title image:(UIImage *)image
{
    DpSettingItem * item = [[self alloc] initWithTitle:title];
    item.icon = image;
    return item;
}

+(instancetype)initWithIcon:(UIImage *)image title:(NSString *)title descVc:(Class)descVc
{
    DpSettingItem * item = [self initWithTitle:title image:image];
    item.descVc = descVc;
    return item;
}
@end
