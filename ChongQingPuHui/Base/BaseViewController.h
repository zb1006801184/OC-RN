//
//  BaseViewController.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/14.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterView.h"//自定义View
@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) UIView *navBarView;

- (void)setNavBarWithTitle:(NSString *)titleLab isBack:(BOOL)back;

@end
