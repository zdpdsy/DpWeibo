//
//  DpStatusCacheTool.m
//  DpWeibo
//
//  Created by 曾大鹏 on 16/2/24.
//  Copyright © 2016年 曾大鹏. All rights reserved.
//

#import "DpStatusCacheTool.h"
#import "DpAccountTool.h"
#import "DpStatus.h"
#import "FMDB.h"
#import "DpStatusParam.h"
@implementation DpStatusCacheTool

static FMDatabase * _db;

+(void)initialize
{
    //1.缓存路径
    NSString * cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    
    //2.拼接文件名
    NSString * filePath = [cachePath stringByAppendingPathComponent:@"status.sqlite"];
    
    //创建一个数据库实例
    _db = [FMDatabase databaseWithPath:filePath];
    
    BOOL isOpen = [_db open];
    if (isOpen) {
        DpLog(@"数据库开启成功");
    }else{
        DpLog(@"数据库开启失败");
    }
    
    //创建table
    BOOL falg= [_db executeUpdate:@"create table if not exists t_status(id integer primary key autoincrement,idstr text,access_token text,dict blob);"];
    if (falg) {
        DpLog(@"创建table 成功");
    }else{
        DpLog(@"创建table 失败");
    }
}
+(void)saveWithStatuses:(NSArray *)statuses
{
    //遍历模型数据
    for (NSDictionary * statusDict in statuses) {
        
        NSString * idstr = statusDict[@"idstr"];
        NSString * access_token  =[DpAccountTool account].access_token;
       // NSDictionary * statusDict = status.keyValues;
        //DpLog(@"statusdict=%@",statusDict);
        
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:statusDict];
        
        BOOL isAddSucceed = [_db executeUpdate:@"insert into t_status(idstr,access_token,dict) values(?,?,?)",idstr,access_token,data];
        if (isAddSucceed) {
            DpLog(@"插入success");
        }else{
            DpLog(@"插入failure");
        }
    }
}

+(NSArray *)statusedWithParam:(DpStatusParam *)param
{
    NSString * sql =[NSString stringWithFormat:@"select * from t_status where access_token = '%@' order by idstr desc limit 20;",param.access_token];
    if (param.since_id) { //获取最新微博
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr > '%@'order by idstr desc limit 20;",param.access_token,param.since_id];
    }else if(param.max_id){ //获取更多微博
         sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr <= '%@'order by idstr desc limit 20;",param.access_token,param.max_id];
    }
    //select * from t_status where access_token = param.accesstoekn order by idstr desc limit 20
    FMResultSet * set = [_db executeQuery:sql];
    NSMutableArray * arrM = [NSMutableArray array];
    while ([set next]) {
        NSData * dictData =[set dataForColumn:@"dict"];
        NSDictionary * dict=[NSKeyedUnarchiver unarchiveObjectWithData:dictData];
        //字典转模型
        DpStatus * status = [DpStatus objectWithKeyValues:dict];
        
        [arrM addObject:status];
    }
    return arrM;
}
@end
