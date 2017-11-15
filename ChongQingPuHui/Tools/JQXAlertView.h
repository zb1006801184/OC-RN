//
//  JQXAlertView.h
//  PuHuiVip
//
//  Created by 节庆霞 on 2017/5/12.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JQXAlertView : UIView

@property (nonatomic,retain) UILabel *msgLabel;     //消息体

-(id)initWithMessage:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle;

-(void)showWithCompletion:(void (^)(NSInteger selectIndex))completeBlock;


@end
