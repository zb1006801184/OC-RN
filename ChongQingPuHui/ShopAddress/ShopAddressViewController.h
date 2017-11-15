//
//  ShopAddressViewController.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/24.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "BaseViewController.h"
//声明一个block
typedef void (^MessageBlock)(NSMutableDictionary *messageDic);
@interface ShopAddressViewController : BaseViewController
@property (nonatomic,strong)NSString *styleStr;

//定义一个block属性
@property (nonatomic,copy) MessageBlock block;

//block语句块的函数
- (void)messageText:(MessageBlock)block;
@end
