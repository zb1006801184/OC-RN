//
//  JQXServiceCollectionViewCell.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/10/19.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JQXServiceDelegate <NSObject>
- (void)ServiceDelete:(NSDictionary *)dic;
- (void)ServiceCallDelete:(NSDictionary *)dic;
@end
@interface JQXServiceCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIButton *deleteButton;
@property (nonatomic,strong)UIView *smallView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *telLabel;
@property (nonatomic,strong)UIButton *telButton;
@property (nonatomic,strong)NSDictionary *mainDic;
@property (nonatomic,strong)UIImageView *addImage;
@property (nonatomic,weak)id<JQXServiceDelegate>delegate;

- (void)setMainUIData:(NSDictionary *)dic;
@end
