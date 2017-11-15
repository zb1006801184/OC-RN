//
//  AddTableTableViewCell.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/25.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddTableSelectedDelegete <NSObject>
- (void)SelecctedTableSure:(UITableViewCell *)cell;
- (void)SelecctedTableCancel:(UITableViewCell *)cell;
@end
@interface AddTableTableViewCell : UITableViewCell
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIImageView *headerImg;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UILabel *sizeLabel;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)NSString *styleStr;
@property (nonatomic,strong)UIButton *selecteButton;

@property (nonatomic,weak)id<AddTableSelectedDelegete> tableDelegate;


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier style:(NSString *)styleStr;
- (void)setData:(NSDictionary *)dic;
@end
