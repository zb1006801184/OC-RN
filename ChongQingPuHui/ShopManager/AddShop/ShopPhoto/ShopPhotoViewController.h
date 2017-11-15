//
//  ShopPhotoViewController.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/24.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

typedef void (^imageBlock)(NSMutableArray *imageArray,NSMutableArray *imageID);

#import "BaseViewController.h"

@interface ShopPhotoViewController : BaseViewController

@property(nonatomic,strong)imageBlock block;

-(void)imageVlueBlock:(imageBlock)block;
@property(nonatomic,strong)NSMutableArray *valueImageArray; //编辑
@property(nonatomic,strong)NSMutableArray *imageID;
@property (nonatomic,strong)NSString *titleStr;//添加餐位图片

@end
