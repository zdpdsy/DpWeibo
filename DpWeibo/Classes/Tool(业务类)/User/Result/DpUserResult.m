//
//  DpUserResult.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/8.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpUserResult.h"


@implementation DpUserResult
-(int)messageCount
{
    return _dm + _cmt + _mention_cmt + _mention_status;
}

-(int)totalCount
{
    return self.messageCount + _follower + _status;
}
@end
