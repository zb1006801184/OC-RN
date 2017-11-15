//
//  JQXCustom.m
//  PuHuiVip
//
//  Created by 节庆霞 on 2017/5/5.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "JQXCustom.h"

@implementation JQXCustom
/*
 
 *
 *color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

/*
 
 *
 *color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 
 */
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}
/*
 
 *
 *自定义Label
 
 */

+ (UILabel *)creatLabel:(CGRect)frame backColor:(UIColor *)backColor_ text:(NSString *)text_ textColor:(UIColor *)textColor_  font:(UIFont *)font_ textAlignment:(NSTextAlignment)textAli_ numOnLines:(NSInteger)numOnLines_
{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = backColor_;
    label.frame = frame;
    label.text = text_;
    label.textColor = textColor_;
    label.textAlignment = textAli_;//NSTextAlignmentLeft
    label.font = font_;//[UIFont systemFontOfSize:17]
    label.numberOfLines = numOnLines_;
    return label;
}
/*
 
 *
 *自定义Button
 
 */
+ (UIButton *)creatButton:(CGRect)frame backColor:(UIColor *)backColor_ text:(NSString *)text_ textColor:(UIColor *)textColor_  font:(UIFont *)font_ addTarget:(id)add_ Action:(SEL)action_
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = backColor_;
    [button setTitle:text_ forState:UIControlStateNormal];
    [button setTitleColor:textColor_ forState:UIControlStateNormal];
    button.titleLabel.font = font_;
    [button addTarget:add_ action:action_ forControlEvents:UIControlEventTouchUpInside];
    return button;
}
/*
 
 *
 *自定义TextField
 
 */
+ (UITextField *)creatTextFiled:(CGRect)frame placeholder:(NSString *)placeholderN
{
    UITextField *textFiled = [[UITextField alloc]initWithFrame:frame];
    textFiled.textAlignment = NSTextAlignmentLeft;
    textFiled.placeholder = placeholderN;
    textFiled.font = [UIFont systemFontOfSize:13];
    return textFiled;
}
@end
