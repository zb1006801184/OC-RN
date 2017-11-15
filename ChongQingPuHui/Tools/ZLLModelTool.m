//
//  ZLLModelTool.m
//  ChongQingPuHui
//
//  Created by zll on 2017/11/1.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "ZLLModelTool.h"

@implementation ZLLModelTool
+ (void)setNormol:(NSString *)Normol forkey:(NSString *)keyS {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:Normol forKey:keyS];
    [user synchronize];
}

+ (NSString *)getNormolWithKey:(NSString *)keyS{
    //记录用户数据
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString * uuid = [userDefaults objectForKey:keyS];
    return uuid;
}
#pragma 判断字符串是否为空
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
@end
