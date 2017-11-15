//
//  AdvanceTableViewCell.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/26.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AdvanceTableViewCellDelegate <NSObject>
- (void)AdvanceTableViewCell:(NSDictionary *)dic;
- (void)MessageTableViewCell:(NSDictionary *)dic;
- (void)AdvanceCancleTableViewCell:(NSDictionary *)dic;
@end

@interface AdvanceTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *img;
@property (nonatomic,strong)UILabel *shopTimeLabel;
@property (nonatomic,strong)UILabel *styleLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *peopleLabel;
@property (nonatomic,strong)UILabel *tableLabel;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *allPriceLabel;
@property (nonatomic,strong)UIButton *haveButton;//接单按钮
@property (nonatomic,strong)UIButton *cancleButton;//取消接单按钮
@property (nonatomic,strong)UIButton *messageButton;//评价信息按钮

@property (nonatomic,strong)NSDictionary *mainDic;

- (void)setDataDic:(NSDictionary *)dic index:(NSInteger)index;
@property (nonatomic,weak)id<AdvanceTableViewCellDelegate> cellDelegate;

@end
