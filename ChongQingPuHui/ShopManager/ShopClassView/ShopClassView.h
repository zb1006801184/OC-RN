//
//  ShopClassView.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/24.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import <UIKit/UIKit.h>
//选中代理
@protocol SelectedClassDelegate <NSObject>

- (void)SelectedClassSure:(NSDictionary *)dic;
- (void)NewClassController;
@end

@interface ShopClassView : UIView

@property (nonatomic,strong)NSMutableArray *classArray;
@property (nonatomic,strong)NSString *classStr;
@property (nonatomic,strong)NSString *editStr;


@property (nonatomic, weak)id<SelectedClassDelegate> SelectedDelegate;

- (instancetype)initWithFrame:(CGRect)frame ClassStr:(NSString *)str classArr:(NSArray *)array
                      editStr:(NSString *)edit;
@end
