//
//  DpNewFeatureCell.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/2.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DpNewFeatureCell : UICollectionViewCell
@property (strong,nonatomic) UIImage * image;
// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;
@end
