//
//  ClassTableViewCell.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/27.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ClassDelegate <NSObject>
- (void) EditClassCell:(UITableViewCell *)cell;
- (void) DelegateCell:(UITableViewCell *)cell;
- (void) ScrollCell:(UITableViewCell *)cell;
@end

@interface ClassTableViewCell : UITableViewCell
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIButton *editButton;
@property (nonatomic,strong)UIButton *deleteButton;
@property (nonatomic,strong)UIButton *scrollButton;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier style:(NSString *)styleStr;

@property (nonatomic,weak)id<ClassDelegate> delegate;

- (void)setDataDic:(NSDictionary *)dic;

@end
