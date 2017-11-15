//
//  BuyTimeTableViewCell.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/9/25.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ButtonClassDelegate <NSObject>

- (void)StartTimeClassSure:(UITableViewCell *)cell;
- (void)EndTimeTimeClassSure:(UITableViewCell *)cell;
- (void)AddClassSure:(UITableViewCell *)cell;
- (void)DeleteClassSure:(UITableViewCell *)cell;
@end
@interface BuyTimeTableViewCell : UITableViewCell
@property (nonatomic,strong)UIButton *startTimeButton;
@property (nonatomic,strong)UIButton *endTimeButton;
@property (nonatomic,strong)UIButton *addButton;
@property (nonatomic,strong)UIButton *deleteButton;
@property (nonatomic,weak) id<ButtonClassDelegate>ButtonDelegate;
- (void)setData:(NSDictionary *)dic;

@end
