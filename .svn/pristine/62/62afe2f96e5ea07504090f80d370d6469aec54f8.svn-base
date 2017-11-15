//
//  JQXServiceCollectionViewCell.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/10/19.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "JQXServiceCollectionViewCell.h"

@implementation JQXServiceCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if([super initWithFrame:frame]){
        [self setMainUI];
    }
    return self;
}
- (void)setMainUI
{
    [self addSubview:self.imageView];
    [self addSubview:self.smallView];
    [self addSubview:self.deleteButton];
    [self.smallView addSubview:self.nameLabel];
    [self.smallView addSubview:self.telLabel];
//    [self.smallView addSubview:self.telButton];
    [self addSubview:self.addImage];
}
- (void)setMainUIData:(NSDictionary *)dic
{
    self.mainDic = dic;
    NSString *imgUrl = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"url"])];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"%@"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"name"])];
    self.telLabel.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"telphone"])];
}
- (UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame: CGRectMake(0, 0, (SCREEN_WIDTH - 5)/2, (SCREEN_WIDTH - 5)/2 - 10)];
        _imageView.image = [UIImage imageNamed:@"JQXShi"];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}
- (UIView *)smallView
{
    if(!_smallView){
        _smallView = [[UIView alloc]initWithFrame:CGRectMake(0, (SCREEN_WIDTH - 5)/2 - 10, (SCREEN_WIDTH - 5)/2, 30)];
//        _smallView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.2];
    }
    return _smallView;
}
- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [JQXCustom creatLabel:CGRectMake(0, 0, _smallView.width - 5, _smallView.height) backColor:[UIColor clearColor] text:@"黄经理" textColor:[UIColor blackColor] font:Font(13) textAlignment:NSTextAlignmentRight numOnLines:1];
    }
    return _nameLabel;
}
- (UILabel *)telLabel
{
    if(!_telLabel){
        _telLabel = [JQXCustom creatLabel:CGRectMake(5, 0, _smallView.width - 5, _smallView.height) backColor:[UIColor clearColor] text:@"13595623325" textColor:[UIColor blackColor] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:1];
    }
    return _telLabel;
}
- (UIButton *)deleteButton
{
    if(!_deleteButton){
        _deleteButton = [JQXCustom creatButton:CGRectMake(_imageView.width - 30, 0, 30, 30) backColor:[UIColor whiteColor] text:@"" textColor:[UIColor whiteColor] font:Font(12) addTarget:self Action:@selector(delegateAction)];
        [_deleteButton setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    }
    return _deleteButton;
}
- (UIButton *)telButton
{
    if(!_telButton){
        _telButton = [JQXCustom creatButton:CGRectMake(_imageView.width - 25, _smallView.height - 25, 25, 25) backColor:[UIColor whiteColor] text:@"" textColor:[UIColor whiteColor] font:Font(12) addTarget:self Action:@selector(CallAction)];
        [_telButton setImage:[UIImage imageNamed:@"serviceCall"] forState:UIControlStateNormal];
    }
    return _telButton;
}
- (UIImageView *)addImage
{
    if(!_addImage){
        _addImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 5)/2, (SCREEN_WIDTH - 5)/2 + 20)];
        _addImage.backgroundColor = [UIColor whiteColor];
        _addImage.image = [UIImage imageNamed:@"photo"];
        _addImage.userInteractionEnabled = YES;
    }
    return _addImage;
}
- (void)delegateAction
{
    [self.delegate ServiceDelete:self.mainDic];
}
- (void)CallAction
{
    [self.delegate ServiceCallDelete:self.mainDic];
}
@end
