//
//  main.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/11/29.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
/*
 1.创建UIApplicaction对象
 2.创建AppDelegate对象，并且成为UIApplication对象代理属性
 3.开启主运行循环:目的让程序一直运行
 4.加载info.plist文件,判断info.plist文件里面是不是指定main.storyboard,如果执行，就会去加载main.storyboard
 
 main.storyboard
 1.初始化窗口
 2.加载storyboard文件,并且创建箭头指向的控制器
 3.把新创建的控制器作为窗口的根控制器，让窗口显示
 */

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
