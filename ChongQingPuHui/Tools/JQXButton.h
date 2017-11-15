//
//  JQXButton.h
//  UIButton
//
//  Created by 节庆霞 on 2017/7/7.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JQXButton : UIButton
@property (nonatomic,strong)UIImageView *btnImg;
@property (nonatomic,strong)UILabel *btnLabel;
- (instancetype)initWithFrame:(CGRect)frame index:(int)indexPath;
- (instancetype)initWithFrame:(CGRect)frame styleStr:(NSString *)str;
@property (nonatomic,strong)UIImageView *btnStyleImg;
@property (nonatomic,strong)UILabel *btnStyleBtnLabel;
@end
