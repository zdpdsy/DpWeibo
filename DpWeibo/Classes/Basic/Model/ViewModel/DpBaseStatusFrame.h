//
//  DpBaseStatusFrame.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/24.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DpStatus;
@interface DpBaseStatusFrame : NSObject
/**
 *  微博数据
 */
@property (strong, nonatomic) DpStatus * status;


//原创微博frame
@property (assign, nonatomic) CGRect originalViewFrame;

/**   ******原创微博子控件frame**** */
//头像frame
@property (assign, nonatomic) CGRect originalIconFrame;

//昵称 frame
@property (assign, nonatomic) CGRect originalNameFrame;

//vip frame
@property (assign, nonatomic) CGRect originalVipFrame;

//时间 frame
@property (assign, nonatomic) CGRect originalTimeFrame;

//来源 frame
@property (assign, nonatomic) CGRect originalSoureFrame;

//正文 frame
@property (assign, nonatomic) CGRect originalTextFrame;

//配图frame
@property (assign, nonatomic) CGRect originalPhotosFrame;


// 转发微博frame
@property (nonatomic, assign) CGRect retweetViewFrame;

/**   ******转发微博子控件frame**** */
// 昵称Frame
@property (nonatomic, assign) CGRect retweetNameFrame;

// 正文Frame
@property (nonatomic, assign) CGRect retweetTextFrame;

//配图frame
@property (assign, nonatomic) CGRect retweetPhotosFrame;


// 工具条frame
@property (nonatomic, assign) CGRect toolBarFrame;



// cell的高度
@property (nonatomic, assign) CGFloat cellHeight;
@end
