//
//  JQXCustom.h
//  PuHuiVip
//
//  Created by 节庆霞 on 2017/5/5.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQXCustom : NSObject
/*
 
 *
 *color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

/*
 
 *
 *color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
/*
 
 *
 *自定义Label
 
 */
+ (UILabel *)creatLabel:(CGRect)frame backColor:(UIColor *)backColor_ text:(NSString *)text_ textColor:(UIColor *)textColor_  font:(UIFont *)font_ textAlignment:(NSTextAlignment)textAli_ numOnLines:(NSInteger)numOnLines_;
/*
 
 *
 *自定义Button
 
 */
+ (UIButton *)creatButton:(CGRect)frame backColor:(UIColor *)backColor_ text:(NSString *)text_ textColor:(UIColor *)textColor_  font:(UIFont *)font_ addTarget:(id)add_ Action:(SEL)action_;
/*
 
 *
 *自定义TextField
 
 */
+ (UITextField *)creatTextFiled:(CGRect)frame placeholder:(NSString *)placeholderN;
@end

