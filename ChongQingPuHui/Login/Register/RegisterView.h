//
//  RegisterView.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/24.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIView
@property (nonatomic,strong)UILabel *tsLabel;
@property (nonatomic,strong)UIButton *jButton;
- (instancetype)initWithFrame:(CGRect)frame lineStr:(NSString *)line;
@end
