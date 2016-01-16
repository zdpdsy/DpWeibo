//
//  DpTextView.m
//  DpWeibo
//
//  Created by 曾大鹏 on 15/12/12.
//  Copyright © 2015年 曾大鹏. All rights reserved.
//

#import "DpTextView.h"
@interface DpTextView()
@property (weak,nonatomic) UILabel * placeholderLabel;
@end

@implementation DpTextView
//懒加载
-(UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        
        UILabel * label = [[UILabel alloc] init];
        
        [self addSubview:label];
        _placeholderLabel = label;
    }
    return _placeholderLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor redColor];
        //设置字体
        self.font = [UIFont systemFontOfSize:13];
    }
    return self;
}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    [self.placeholderLabel sizeToFit];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    // label的尺寸跟文字一样
    [self.placeholderLabel sizeToFit];

}
-(void)setHidePlaceholder:(BOOL)hidePlaceholder
{
    _hidePlaceholder = hidePlaceholder;
    self.placeholderLabel.hidden = hidePlaceholder;
}
//设置子控件的frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.x = 5;
    self.placeholderLabel.y = 8;
}

@end
