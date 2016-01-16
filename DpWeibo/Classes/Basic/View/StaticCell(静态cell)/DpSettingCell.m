//
//  DpSettingCell.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/14.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpSettingCell.h"
#import "DpSettingItem.h"
#import "DpSettingArrowItem.h"
#import "DpSettingSwithItem.h"
#import "DpSettingLabelItem.h"
#import "DpSettingBadgeItem.h"
#import "DpBadgeView.h"
#import "DpSettingCheckItem.h"

@interface DpSettingCell()

/**箭头*/
@property (strong,nonatomic) UIImageView * mArrow;

/**开关*/
@property (strong,nonatomic) UISwitch * mSwitch;

/**label*/
@property (weak,nonatomic) UILabel * mlabel;

/**
 *  打钩
 */
@property (strong,nonatomic) UIImageView * checkView;

@property (strong,nonatomic) DpBadgeView * badgeView;

@end


@implementation DpSettingCell
//懒加载
-(UIImageView *)mArrow
{
    if (!_mArrow) {
        _mArrow  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
        
    }
    return _mArrow;
}

-(UIImageView *)checkView
{
    if (!_checkView) {
        _checkView =[ [UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
        
    }
    return _checkView;

}
-(UISwitch *)mSwitch
{
    if (!_mSwitch) {
        _mSwitch = [[UISwitch alloc] init];
        [_mSwitch addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _mSwitch;
}

-(void)valueChange:(UISwitch *) Switch
{
    //把开关状态保存到用户编号设置
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:Switch.isOn forKey:self.item.title];//保存
    [defaults synchronize];//同步
}

-(UILabel *)mlabel
{
    if (!_mlabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        _mlabel = label;
        _mlabel.textAlignment = NSTextAlignmentCenter;
        _mlabel.textColor = [UIColor redColor];
        [self addSubview:_mlabel];
    }
    return _mlabel;
}


-(DpBadgeView *)badgeView
{
    if (!_badgeView) {
        _badgeView = [[DpBadgeView alloc] init];
        
    }
    return _badgeView;

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableview
{

    static NSString * reuserid = @"MineSetting";
    DpSettingCell * cell =[tableview dequeueReusableCellWithIdentifier:reuserid];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuserid];
    }
    return cell;
}

-(void)setItem:(DpSettingItem *)item
{
    _item = item;
    
    //赋值
    self.textLabel.text = _item.title;
    if (_item.icon) {
        //icon
        self.imageView.image = _item.icon;

    }
    
    
    //设置子标题
    self.detailTextLabel.text = _item.subTitle;
    

    if ([_item isKindOfClass:[DpSettingArrowItem class]]) { //箭头
        self.accessoryView = self.mArrow;
        //箭头可以选中
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
    }else if([item isKindOfClass:[DpSettingSwithItem class]]){ //开关
        //设置开关的状态
        self.mSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:self.item.title];
        
        self.accessoryView = self.mSwitch;
        //不能选中
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if([_item isKindOfClass:[DpSettingLabelItem class]]){ //label
        
        DpSettingLabelItem * labelItem = (DpSettingLabelItem *) _item;
        
        //self.accessoryView = self.mlabel;
        
        self.mlabel.text = labelItem.text;
        
        //label可以选中
        //self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
    }else if([_item isKindOfClass:[DpSettingBadgeItem class]]){ //badgeView
    
        DpSettingBadgeItem * badgeItem = (DpSettingBadgeItem *)_item;
        
        self.accessoryView = self.badgeView;
        self.badgeView.badgeValue = badgeItem.badgeValue;
    }else if([_item isKindOfClass:[DpSettingCheckItem class]]){ //badgeView
        
        DpSettingCheckItem * checkItem = (DpSettingCheckItem *)_item;
       
        if (checkItem.Check) {
            self.accessoryView = self.checkView;
        }else{
            self.accessoryView = nil;
            
        }
       
    }
    else{ // 没有
        self.accessoryView = nil;
        [_mlabel removeFromSuperview];
         _mlabel = nil;
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(int)count
{
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selBgView = (UIImageView *)self.selectedBackgroundView;
    if (count == 1) { // 只有一行
        bgView.image = [UIImage imageWithStretchableName:@"common_card_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_background_highlighted"];
        
    }else if(indexPath.row == 0){ // 顶部cell
        bgView.image = [UIImage imageWithStretchableName:@"common_card_top_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_top_background_highlighted"];
        
    }else if (indexPath.row == count - 1){ // 底部
        bgView.image = [UIImage imageWithStretchableName:@"common_card_bottom_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_bottom_background_highlighted"];
        
    }else{ // 中间
        bgView.image = [UIImage imageWithStretchableName:@"common_card_middle_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_middle_background_highlighted"];
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
