//
//  QJGlobalControl.h
//  TaoJuWangProject
//
//  Created by JieQingxia on 15/11/6.
//  Copyright © 2015年 JieQingxia. All rights reserved.
//

#import <Foundation/Foundation.h>
#define REACHABILNETWORK @"www.apple.com"
typedef void(^SuccessBlock)(id data);
typedef void(^FailBlock)(NSError *error);
@interface QJGlobalControl : NSObject

/**
 * 使用该函数请求数据
 * POST请求 参数以表单的格式传
 */
+ (void)sendPOSTWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;
/**
 * 使用该函数请求数据
 * GET请求
 */
+ (void)sendGETWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

/**
 * 使用该函数请求数据
 * POST请求 参数以json的格式传
 */
+ (void)sendPOSTJSONWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

/**
 *支付宝调用
 **/
+ (void)sendPOSTAplipayWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock;

/*
 
 *处理字符串四个四个一截取
 
 */
+ (NSString *)countNumAndChangeformat:(NSString *)bankCardNumber;
/*
 特殊字符
 */
+ (BOOL)isIncludeSpecialCharact:(NSString *)str;
/*
 校验手机号
 */
+ (BOOL)checkPhoneNumber:(NSString *)phone;
@end



