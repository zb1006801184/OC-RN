//
//  EditShopTableViewCell.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/27.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import <UIKit/UIKit.h>
//选中代理
@protocol ShoppingSectionDelegate <NSObject>

-(void)SelectedSectionConfirmCell:(UITableViewCell *)cell;
-(void)SelectedSectionCancelCell:(UITableViewCell *)cell;
@end

@interface EditShopTableViewCell : UITableViewCell
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIButton *selecteButton;
@property (nonatomic,strong)UIImageView *headerImg;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *moneryLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UILabel *offLabel;
@property (nonatomic,strong)NSString *styleStr;

@property (nonatomic, weak)id<ShoppingSectionDelegate> SelectedDelegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier style:(NSString *)styleStr;

- (void)setDataListDic:(NSDictionary *)dic;
@end

