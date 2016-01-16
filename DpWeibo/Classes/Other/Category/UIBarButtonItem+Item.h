//
//  UIBarButtonItem+Item.h
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/2.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)
/**
 *  返回一个uibarbuttonItem
 *
 *  @param image         <#image description#>
 *  @param highImage     <#highImage description#>
 *  @param target        <#target description#>
 *  @param action        <#action description#>
 *  @param controlEvents <#controlEvents description#>
 *
 *  @return <#return value description#>
 */
+(UIBarButtonItem *) barButtonItemWithImage:(UIImage *) image highImage:(UIImage *) highImage target:(id) target action:(SEL)action forControlEvents:(UIControlEvents) controlEvents;
@end
