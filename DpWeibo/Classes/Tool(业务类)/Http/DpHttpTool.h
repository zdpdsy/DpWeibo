//
//  DpHttpTool.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/7.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  DpUploadParam;
/*
 封装网络请求，解耦
 项目存在问题,太依赖第三方框架。
  1.为什么要封装网络请求:以后AFN升级,方法名改了,或者AFN淘汰了,
 直接改工具类就好了。
  2.好处:解耦,不依赖第三方框架
 */
@interface DpHttpTool : NSObject

/*
 
 [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
 //停止下拉刷新控件
 [self.tableView headerEndRefreshing];
 
 //把数据转成模型
 //1.获取字典数组
 NSArray * dictArr  = responseObject[@"statuses"];
 
 //2.字典数据转成模型
 NSArray * statuses = (NSMutableArray *)[DpStatus objectArrayWithKeyValuesArray:dictArr];
 
 //吧数据加到最前面
 NSIndexSet * indexSet  = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
 
 [self.statuses insertObjects:statuses atIndexes:indexSet];
 
 //重新加载
 [self.tableView reloadData];
 
 
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 NSLog(@"error ,msg = %@",error);
 }];
 
 block格式: <#returnType#>(^<#blockName#>)(<#parameterTypes#>) = ^(<#parameters#>) {
 <#statements#>
 };
 
 (void (^)(id responseObject)) success
 (void (^)(NSError *error))failure
 */

typedef void(^eblock)(NSError *error);

typedef void(^sblock)(id responseObject);

/**
 *  Get请求提交
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 成功时候的回调函数
 *  @param failure 失败时候的回调函数
 */
+(void)Get:(NSString *) url parameters:(id) params success:(sblock) success failure: (eblock) failure;

/**
 *  Post请求提交
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 成功时候的回调函数
 *  @param failure 失败时候的回调函数
 */
+(void)Post:(NSString *) url parameters:(id) params success:(sblock) success failure: (eblock) failure;


/**
 *  Get请求提交  - 另外一个写法
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 成功时候的回调函数
 *  @param failure 失败时候的回调函数
 */
+(void)HttpGet:(NSString *) url parameters:(id) params success:(void(^)(id responseObject)) success
       failure: (void(^)(NSError * error))failure;

/**
 *  Post提交 - 另外一个写法
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 成功时候的回调函数
 *  @param failure 失败时候的回调函数
 */
+(void)HttpPost:(NSString *) url parameters:(id) params success:(void(^)(id responseOjbect)) success
        failure:(void(^)(NSError * error)) failure;

/**
 *  上传文件
 *
 *  @param url         请求地址
 *  @param params      请求字典
 *  @param uploadParam 文件的信息
 *  @param success     请求成功的回调函数
 *  @param failure     请求失败的回调函数
 */
+(void)Upload:(NSString *) url parameters:(id) params uploadParam:(DpUploadParam *) uploadParam success:(void(^)(id responseObject)) success
      failure:(void(^)(NSError * error)) failure;

@end
