//
//  UIColor+Hex.h
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

#import <UIKit/UIKit.h>


#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
