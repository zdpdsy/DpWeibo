//
//  DpStatus.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/6.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpStatus.h"
#import "DpPhoto.h"
#import "NSDate+MJ.h"
@implementation DpStatus

+(NSArray *)ignoredPropertyNames
{
    return @[@"retweetName"];
}
// 实现这个方法，就会自动把数组中的字典转换成对应的模型
+(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[DpPhoto class]};
}
//时间处理 重写getter方法
/*
 
 去年:
 2013-01-11 yyyy-MM-dd
 
 判断是否是今年
 今年:
 一分钟之内 刚刚
 一小时之内 多少分钟前
 24小时以内 多少小时
 昨天：  昨天 13：22  昨天：HH:mm
 前天   10-1 13：22  MM-dd HH:mm
 
 
 */
-(NSString *)created_at
{
   
    //获取微博创建时间
    //1.创建日期格式化器
    NSDateFormatter * fm = [[NSDateFormatter alloc] init];
    fm.dateFormat =@"EEE MMM d HH:mm:ss Z yyyy";
#warning 真机必须加上这句话，否则转换不成功，必须告诉日期格式的区域，才知道怎么解析
    fm.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    
    NSDate * createDate  = [fm dateFromString:_created_at];
    //NSLog(@"originaldate = %@ 。。。。createdate=%@",_created_at,createDate);
    
    if ([createDate isThisYear]) { //如果为今年
        
        if ([createDate isToday]) { //今天
            
            //获取时间差
            NSDateComponents * cmp =[createDate deltaWithNow];
            //NSLog(@" h = %ld--- m = %ld----s = %ld",cmp.hour,cmp.minute,cmp.second);
            if (cmp.hour >=1) { // 至少1小时
                return [NSString stringWithFormat:@"%ld小时前",cmp.hour];
            }else if (cmp.minute >1){ // 1~60分钟内发的
                return [NSString stringWithFormat:@"%ld分钟前",cmp.minute];
            }else {
                return  @"刚刚";
            }
            
            
        }else if([createDate isYesterday]){ //昨天
        
            fm.dateFormat =@"昨天 HH:mm";
            
            return [fm stringFromDate:createDate];
        }else{ //前天
          
            fm.dateFormat = @"MM-dd HH:mm";
           
            return [fm stringFromDate:createDate];
        }
    }else{ //不是今年
        fm.dateFormat = @"yyyy-MM-dd";
        return [fm stringFromDate:createDate];
    }
    
    return _created_at;
}

//来源处理
-(void)setSource:(NSString *)source
{
    NSString *searchText = source;
    NSRange range = [searchText rangeOfString:@">"];
    searchText = [searchText substringFromIndex:range.location + range.length];
    
    range = [searchText rangeOfString:@"<"];
    searchText = [searchText substringToIndex:range.location];
    
    _source = [NSString stringWithFormat:@"来自%@",searchText];
}
-(void)setRetweeted_status:(DpStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    _retweetName = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
}
@end
