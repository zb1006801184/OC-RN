//
//  UIColor+Hex.m
//  LoginDemo
//
//  Created by JieQingxia on 13/8/19.
//  Copyright (c) 2013年 JieQingxia. All rights reserved.
//
//                                      _ooOoo_
//                                     o8888888o
//                                     88" . "88
//                                     (| _ _ |)
//                                      O\ = /O
//                                  ____/`---'\____
//                                .   ' \\| |// '  .
//                                 / \\||| : |||// \
//                               / _||||| -:- |||||- \
//                                 | | \\\ - /// | |
//                               | \_| ''\---/'' | |
//                                \ .-\__ `-` __/-. /
//                              ___`. .' /--.--\ `. .___
//                           ."" '< `.___\_<|>_/___.'>'"".
//                          | | : `- \`.;`\ - /`;.`/ -`: | |
//                            \ \ `-. \_ __\ /__ _/ .-` / /
//                    ======`-.____`-.___\_____/___.-`____.-`======
//
//                    .............................................
//
//                             佛祖保佑             永无BUG
//
//                       佛曰:
//                             写字楼里写字间，写字间里程序员；
//                             程序人员学程序，又拿程序换酒钱。
//                             就行旨在网上坐，酒醉还来网下眠；
//                             酒醉酒醒日复日，网上网下年复年。
//                             但愿老死电脑间，不愿鞠躬老板前；
//                             奔驰宝马贵者趣，公交自行程序员。
//                             别人笑我忒疯癫，我笑自己命太贱；
//                             不见满街漂亮妹，那个归得程序员？
//
//                    .............................................

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

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

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}


@end
