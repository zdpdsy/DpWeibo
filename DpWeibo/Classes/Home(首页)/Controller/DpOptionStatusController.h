//
//  DpOptionStatusController.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/27.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DpTextView;

@interface DpOptionStatusController : UIViewController
/**
 *  要转发或者评论的微博ID
 */
@property (copy, nonatomic) NSString * weiboId;

@property (weak,nonatomic) DpTextView * textView;

/**
 *  发送或者取消（转发或者评微博请求）
 */
-(void)btnSend;
@end
