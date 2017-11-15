//
//  JQXChangePhotoController.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/10/22.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "BaseViewController.h"
//声明一个block
typedef void (^JQXPhotoBlock)(NSMutableArray *photoArray);
@interface JQXChangePhotoController : BaseViewController
@property (nonatomic,strong)NSMutableArray *mainArray;
//定义一个block属性
@property (nonatomic,copy) JQXPhotoBlock block;

//block语句块的函数
- (void)photoArray:(JQXPhotoBlock)block;
@end
