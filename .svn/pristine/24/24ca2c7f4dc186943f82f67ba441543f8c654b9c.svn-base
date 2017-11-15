//
//  QJGlobalControl.m
//  TaoJuWangProject
//
//  Created by JieQingxia on 15/11/6.
//  Copyright © 2015年 JieQingxia. All rights reserved.
//

#import "QJGlobalControl.h"
#import "AFNetworking.h"
#define urlCount          30     //正式环境是28 测试环境是27 伪正式30
#define urlPayCount       25  //正式环境是27 测试环境是21  伪正式25
@implementation QJGlobalControl

//网络请求数据
+ (void)sendPOSTWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock
{
    
    NSDate *senddate = [NSDate date];
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    
    NSString *newUrl = @"";
    //判断是不是支付接口
    if([url isEqualToString:http_QuckPay] || [url isEqualToString:httpAplipayUrl] ||[url isEqualToString:http_bj_com_payUrl]){
        
        newUrl = [url substringFromIndex:urlPayCount];
        
    }else{
        
        newUrl = [url substringFromIndex:urlCount];
        
    }
    
    
    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dict];
    [newDic setObject:date2 forKey:@"timestamp"];
    [newDic setObject:@"I" forKey:@"client_type"];
    [newDic setObject:newUrl forKey:@"url"];
    
    NSString *sign = [YSTFileManageTool encryptUrlWithParaDic:newDic];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dict];
    [params setObject:date2 forKey:@"timestamp"];
    [params setObject:@"I" forKey:@"client_type"];
    [params setObject:sign forKey:@"sign"];
    
//    NSLog(@"🍊🍊newDic    ======%@     🍊🍊 params ===== %@ ",newDic,params);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [NSString stringWithFormat:@"%@",[user objectForKey:LoginToken]];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic_ = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        successBlock(dic_);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
    
}


//网络请求数据
+ (void)sendGETWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock
{
    
    NSDate *senddate = [NSDate date];
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    
    NSString *newUrl = @"";
    //判断是不是支付接口
    if([url isEqualToString:http_QuckPay] || [url isEqualToString:httpAplipayUrl] ||[url isEqualToString:http_bj_com_payUrl]){
        
        newUrl = [url substringFromIndex:urlPayCount];
        
    }else{
        
        newUrl = [url substringFromIndex:urlCount];
        
    }
    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dict];
    [newDic setObject:date2 forKey:@"timestamp"];
    [newDic setObject:@"I" forKey:@"client_type"];
    [newDic setObject:newUrl forKey:@"url"];
    
    NSString *sign = [YSTFileManageTool encryptUrlWithParaDic:newDic];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dict];
    [params setObject:date2 forKey:@"timestamp"];
    [params setObject:@"I" forKey:@"client_type"];
    [params setObject:sign forKey:@"sign"];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [NSString stringWithFormat:@"%@",[user objectForKey:LoginToken]];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic_ = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        successBlock(dic_);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
    
}

//网络请求数据已json形式传参
+ (void)sendPOSTJSONWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [NSString stringWithFormat:@"%@",[user objectForKey:LoginToken]];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
//    NSLog(@"%@",manager.requestSerializer.HTTPRequestHeaders.allValues);
    [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic_ = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        successBlock(dic_);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];

}

/**
 *支付宝调用
 **/
+ (void)sendPOSTAplipayWithUrl:(NSString *)url parameters:(NSDictionary *)dict success:(SuccessBlock)successBlock fail:(FailBlock)failBlock
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        NSDictionary *dic_ = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
    
    
}
/*
 
 *处理字符串四个四个一截取
 
 */
+ (NSString *)countNumAndChangeformat:(NSString *)bankCardNumber
{
    NSUInteger size = bankCardNumber.length / 4;
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++)
    {
        [tmpStrArr addObject:[bankCardNumber substringWithRange:NSMakeRange(n*4, 4)]];
    }
    
    [tmpStrArr addObject:[bankCardNumber substringWithRange:NSMakeRange(size*4, (bankCardNumber.length % 4))]];
    
    bankCardNumber = [tmpStrArr componentsJoinedByString:@"  "];
    
    return bankCardNumber;
}
/*
   特殊字符
 */
+ (BOOL)isIncludeSpecialCharact:(NSString *)str{
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"？……`?~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）‘；：”“’。，、——+|《》$_€/r/n/t"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}
/*
 校验手机号
 */
+ (BOOL)checkPhoneNumber:(NSString *)phone

{
    
    //正则表达式
    
    NSString *pattern = @"^1+[34578]+\\d{9}$";
    
    //创建一个谓词,一个匹配条件
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    //评估是否匹配正则表达式
    
    BOOL isMatch = [pred evaluateWithObject:phone];
    
    return isMatch;
    
}

@end


