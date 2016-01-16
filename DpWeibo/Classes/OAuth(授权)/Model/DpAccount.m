//
//  DpAccount.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/6.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpAccount.h"
#define DpAccountTokenKey @"token"
#define DpUidKey @"uid"
#define DpExpires_inKey @"exoires"
#define DpExpires_dateKey @"date"
#define DpNameKey @"name"

@implementation DpAccount
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    DpAccount *account = [[self alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    // 计算过期的时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

// 归档的时候调用：告诉系统哪个属性需要归档，如何归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:DpAccountTokenKey];
    [aCoder encodeObject:_expires_in forKey:DpExpires_inKey];
    [aCoder encodeObject:_uid forKey:DpUidKey];
    [aCoder encodeObject:_expires_date forKey:DpExpires_dateKey];
    [aCoder encodeObject:_name forKey:DpNameKey];
}

// 解档的时候调用：告诉系统哪个属性需要解档，如何解档

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        // 一定要记得赋值
        _access_token =  [aDecoder decodeObjectForKey:DpAccountTokenKey];
        _expires_in = [aDecoder decodeObjectForKey:DpExpires_inKey];
        _uid = [aDecoder decodeObjectForKey:DpUidKey];
        _expires_date = [aDecoder decodeObjectForKey:DpExpires_dateKey];
        _name = [aDecoder decodeObjectForKey:DpNameKey];
    }
    return self;
}

/**
 *  KVC底层实现：遍历字典里的所有key(uid)
 一个一个获取key，会去模型里查找setKey: setUid:,直接调用这个方法，赋值 setUid:obj
 寻找有没有带下划线_key,_uid ,直接拿到属性赋值
 寻找有没有key的属性，如果有，直接赋值
 在模型里面找不到对应的Key,就会报错.
 */

//+(instancetype)accountWithDict:(NSDictionary *)dict
//{
//    DpAccount * account = [[self alloc] init];
//    
//    //kvc赋值
//    [account setValuesForKeysWithDictionary:dict];
//    
//    return account;
//}
//-(void)setExpires_in:(NSString *)expires_in
//{
//    _expires_in = expires_in;
//    
//    // 计算过期的时间 = 当前时间 + 有效期
//    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
//    
//}
//
//// 解档的时候调用：告诉系统哪个属性需要解档，如何解档
//-(id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init]) {
//        _expires_in = [aDecoder decodeObjectForKey:DpExpires_inKey];
//        _expires_date = [aDecoder decodeObjectForKey:DpExpires_dateKey];
//        _access_token = [aDecoder decodeObjectForKey:DpAccountTokenKey];
//        _uid = [aDecoder decodeObjectForKey:DpUidKey];
//    }
//    return self;
//}
//
//// 归档的时候调用：告诉系统哪个属性需要归档，如何归档
//-(void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder setValue:_expires_in forKey:DpExpires_inKey];
//    [aCoder setValue:_expires_date forKey:DpExpires_dateKey];
//    [aCoder setValue:_access_token forKey:DpAccountTokenKey];
//    [aCoder setValue:_uid forKey:DpUidKey];
//}
///**
// *  KVC底层实现：遍历字典里的所有key(uid)
// 一个一个获取key，会去模型里查找setKey: setUid:,直接调用这个方法，赋值 setUid:obj
// 寻找有没有带下划线_key,_uid ,直接拿到属性赋值
// 寻找有没有key的属性，如果有，直接赋值
// 在模型里面找不到对应的Key,就会报错.
// */

@end
