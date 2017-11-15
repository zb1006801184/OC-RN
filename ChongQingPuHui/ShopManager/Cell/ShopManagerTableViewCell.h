//
//  ShopManagerTableViewCell.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/27.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopManagerTableViewCell : UITableViewCell
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIImageView *headerImg;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *moneryLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UILabel *offLabel;
@property (nonatomic,strong)NSString *styleStr;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier style:(NSString *)styleStr;
- (void)setDataListDic:(NSDictionary *)dic;
@end
