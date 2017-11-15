//
//  ClassShopTableViewCell.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/9/2.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassShopTableViewCell : UITableViewCell
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIImageView *headerImg;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *moneryLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UILabel *offLabel;

- (void)setDataListDic:(NSDictionary *)dic;
@end
