//
//  EditShopTableViewCell.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/27.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "EditShopTableViewCell.h"

@implementation EditShopTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier style:(NSString *)styleStr
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = RGB_COLOR(239, 239, 239);
        self.styleStr = styleStr;
        [self setMainUI];
    }
    return self;
}
- (void)setMainUI
{
   
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.selecteButton];
    [self.bgView addSubview:self.headerImg];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.moneryLabel];
    [self.bgView addSubview:self.contentLabel];
    
    if([self.styleStr isEqualToString:@"上架"]){
        [self.headerImg addSubview:self.offLabel];
    }
    
}
- (void)setDataListDic:(NSDictionary *)dic
{
    NSString *imgStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"address"])];
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"JQXShi"]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"dishName"])];
    
    CGFloat money = [[NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"price"])] floatValue];
    self.moneryLabel.text = [NSString stringWithFormat:@"¥%.2f",money];
    
    NSString *typeName = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"typeName"])];
    if([typeName isEqualToString:@"(null)"]){
        typeName = @"";
    }
    self.contentLabel.text = typeName;
    
    if([dic[@"edit"] integerValue] == 0){
         [self.selecteButton setImage:[UIImage imageNamed:@"check_box_nor"] forState:UIControlStateNormal];
        self.selecteButton.tag = 100;
        
    }else{
        [self.selecteButton setImage:[UIImage imageNamed:@"check_box_sel"] forState:UIControlStateNormal];

        self.selecteButton.tag = 101;
    }
    
}

- (void)selectedAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
            [self.SelectedDelegate SelectedSectionConfirmCell:self];
            self.selecteButton.tag = 101;
            break;
        case 101:
            [self.SelectedDelegate SelectedSectionCancelCell:self];
            self.selecteButton.tag = 100;
            break;
            
        default:
            break;
    }
    
    
}
- (UIView *)bgView
{
    if(!_bgView){
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(7.5, 0, SCREEN_WIDTH - 10, 80)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 8;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIButton *)selecteButton
{
    if(!_selecteButton){
        _selecteButton = [JQXCustom creatButton:CGRectMake(0, (_bgView.height - 30)/2, 30, 30) backColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:Font(12) addTarget:self Action:@selector(selectedAction:)];
        [self.selecteButton setImage:[UIImage imageNamed:@"check_box_nor"] forState:UIControlStateNormal];
        self.selecteButton.tag = 100;
       
    }
    return _selecteButton;
}


- (UIImageView *)headerImg
{
    if(!_headerImg){
        _headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(_selecteButton.right, 7.5, _bgView.height - 15, _bgView.height - 15)];
        _headerImg.contentMode = UIViewContentModeScaleAspectFill;
        _headerImg.clipsToBounds = YES;
        _headerImg.backgroundColor = [UIColor clearColor];
        _headerImg.layer.cornerRadius = 5;
        _headerImg.layer.masksToBounds = YES;
    }
    return _headerImg;
}

- (UILabel *)offLabel
{
    if(!_offLabel){
        _offLabel = [JQXCustom creatLabel:CGRectMake(3, (_headerImg.height - 20)/2, _headerImg.width - 6, 20) backColor:[UIColor clearColor] text:@"已下架" textColor:[UIColor whiteColor] font:Font(12) textAlignment:NSTextAlignmentCenter numOnLines:1];
        _offLabel.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5];
        
    }
    return _offLabel;
}

- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [JQXCustom creatLabel:CGRectMake(_headerImg.right + 10, 7.5, 120, 25) backColor:[UIColor clearColor] text:@"鱼香肉丝" textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentLeft numOnLines:1];
        
    }
    return _titleLabel;
}
- (UILabel *)moneryLabel
{
    if(!_moneryLabel){
        _moneryLabel = [JQXCustom creatLabel:CGRectMake(_headerImg.right + 10, _bgView.height - 30, 120, 20) backColor:[UIColor clearColor] text:@"¥25" textColor:[UIColor colorWithHexString:@"#333333"] font:Font(14) textAlignment:NSTextAlignmentLeft numOnLines:1];
        
    }
    return _moneryLabel;
}

- (UILabel *)contentLabel
{
    if(!_contentLabel){
        _contentLabel = [JQXCustom creatLabel:CGRectMake(self.bgView.width - 100, 7.5, 90, 30) backColor:[UIColor clearColor] text:@"热菜" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentRight numOnLines:1];
        
    }
    return _contentLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
