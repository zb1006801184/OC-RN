//
//  AddTableTableViewCell.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/25.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "AddTableTableViewCell.h"

@implementation AddTableTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier style:(NSString *)styleStr
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = RGB_COLOR(239, 239, 239);
        self.styleStr = styleStr;
        [self setMainUI];
    }
    return self;
}

- (void)setData:(NSDictionary *)dic
{
    /*
     dishName  名称
     subscriptionMoney 最低消费
     saleNum 人数
     hopeTime  预计时间
     imgAddress  图片
     */
    
    NSString *imgStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"address"])];
    NSString *nameStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"dishName"])];
    
    CGFloat money = [[NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"money"])] floatValue];
    
    NSString *moneryStr = [NSString stringWithFormat:@"最低消费¥%.2f",money];
    
    NSString *timeStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"hopeTime"])];
    if([timeStr isEqualToString:@"(null)"]){
        timeStr = @"0";
    }else{
        timeStr = [NSString stringWithFormat:@"预计时长%@分钟",NULL_TO_NIL(dic[@"hopeTime"])];
    }
    NSString *peopleStr = [NSString stringWithFormat:@"%@人桌",NULL_TO_NIL(dic[@"count"])];
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"JQXShi"]];
    self.titleLabel.text = nameStr;
    self.contentLabel.text = moneryStr;
    self.sizeLabel.text = peopleStr;
    self.timeLabel.text = timeStr;
    
    if(![self.styleStr isEqualToString:@"正常"]){
        if([dic[@"edit"] integerValue] == 0){
            [self.selecteButton setImage:[UIImage imageNamed:@"check_box_nor"] forState:UIControlStateNormal];
            self.selecteButton.tag = 100;
        }else{
            [self.selecteButton setImage:[UIImage imageNamed:@"check_box_sel"] forState:UIControlStateNormal];
            self.selecteButton.tag = 101;
        }
    }
    
}

- (void)setMainUI
{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.headerImg];
    if(![self.styleStr isEqualToString:@"正常"]){
        [self.bgView addSubview:self.selecteButton];
        [self.headerImg setLeft:self.selecteButton.right];
    }
    
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.contentLabel];
    [self.bgView addSubview:self.sizeLabel];
//    [self.bgView addSubview:self.timeLabel];
    
}
- (UIView *)bgView
{
    if(!_bgView){
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH - 10, 80)];
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
        _headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(7.5, 7.5, _bgView.height - 15, _bgView.height - 15)];
        _headerImg.contentMode = UIViewContentModeScaleAspectFill;
        _headerImg.clipsToBounds = YES;
        _headerImg.layer.cornerRadius = 5;
        _headerImg.layer.masksToBounds = YES;
    }
    return _headerImg;
}
- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [JQXCustom creatLabel:CGRectMake(_headerImg.right + 10, 7.5, 120, 30) backColor:[UIColor clearColor] text:@"1号桌" textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentLeft numOnLines:1];
        
    }
    return _titleLabel;
}
- (UILabel *)contentLabel
{
    if(!_contentLabel){
        _contentLabel = [JQXCustom creatLabel:CGRectMake(_headerImg.right + 10, _bgView.height - 30, 120, 20) backColor:[UIColor clearColor] text:@"最低消费¥100元" textColor:[UIColor colorWithHexString:@"#333333"] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:1];
        
    }
    return _contentLabel;
}

- (UILabel *)sizeLabel
{
    if(!_sizeLabel){
        _sizeLabel = [JQXCustom creatLabel:CGRectMake(self.bgView.width - 100, 7.5, 90, 30) backColor:[UIColor clearColor] text:@"8人桌" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentRight numOnLines:1];
        
    }
    return _sizeLabel;
}
- (UILabel *)timeLabel
{
    if(!_timeLabel){
        _timeLabel = [JQXCustom creatLabel:CGRectMake(self.bgView.width - 130, _bgView.height - 30, 120, 20) backColor:[UIColor clearColor] text:@"预计时长90分钟" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentRight numOnLines:1];
        
    }
    return _timeLabel;
}
- (void)selectedAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
            [self.tableDelegate SelecctedTableSure:self];
            self.selecteButton.tag = 101;
            break;
        case 101:
            [self.tableDelegate SelecctedTableCancel:self];
            self.selecteButton.tag = 100;
            break;
            
        default:
            break;
    }
    
    
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
