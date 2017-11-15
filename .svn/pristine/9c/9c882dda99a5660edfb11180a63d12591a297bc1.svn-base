//
//  OrderMangerTableViewCell.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/25.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "OrderMangerTableViewCell.h"

@implementation OrderMangerTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setMainUI];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        self.layer.borderWidth = .5;
    }
    return self;
}
- (void)setMainUI
{
    [self addSubview:self.orderLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.timeLabel];
    [self addSubview:self.moneryLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.styleLabel];
    [self addSubview:self.bottomView];
}
- (void)setDataList:(NSDictionary *)dic
{
    self.orderLabel.text = [NSString stringWithFormat:@"订单号：%@",NULL_TO_NIL(dic[@"orderNo"])];

    self.timeLabel.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"createTime"])];
    self.moneryLabel.text = [NSString stringWithFormat:@"%@元",NULL_TO_NIL(dic[@"orderMoney"])];
    NSString *phoneStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"memberPhone"])];
    
    if([phoneStr isEqualToString:@"(null)"]){
        phoneStr = @"";
        
    }else{
        if(phoneStr.length == 11 || phoneStr.length == 11){
            phoneStr = [NSString stringWithFormat:@"%@****%@",[phoneStr substringToIndex:3],[phoneStr substringFromIndex:7]];
        }
    }
   
    
    self.phoneLabel.text = phoneStr;
    
    NSString *payTypeStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"payTypeString"])];
    if([payTypeStr isEqualToString:@"(null)"]){
        payTypeStr = @"";
    }
    self.styleLabel.text = payTypeStr;
}

- (UILabel *)orderLabel
{
    if(!_orderLabel){
        _orderLabel = [JQXCustom creatLabel:CGRectMake(20, 0, SCREEN_WIDTH - 40, SCALE_HEIGHT(40)) backColor:[UIColor clearColor] text:@"订单号68672134384758493023845" textColor:[UIColor blackColor] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:1];
    }
    return _orderLabel;
    
}
- (UIView *)lineView
{
    if(!_lineView){
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _orderLabel.bottom, SCREEN_WIDTH, .5)];
        _lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    
    return _lineView;
}

- (UILabel *)timeLabel
{
    if(!_timeLabel){
        _timeLabel = [JQXCustom creatLabel:CGRectMake(0, _lineView.bottom, SCREEN_WIDTH/3, SCALE_HEIGHT(120)-SCALE_HEIGHT(40)) backColor:[UIColor clearColor] text:@"2017-08-02 15:30:21" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentCenter numOnLines:2];
    }
    return _timeLabel;
    
}
- (UILabel *)moneryLabel
{
    if(!_moneryLabel){
        _moneryLabel = [JQXCustom creatLabel:CGRectMake(SCREEN_WIDTH/3, _lineView.bottom + (SCALE_HEIGHT(120)-SCALE_HEIGHT(40) - 40)/2, SCREEN_WIDTH/3, 20) backColor:[UIColor clearColor] text:@"0.01分" textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentCenter numOnLines:1];
    }
    return _moneryLabel;
    
}
- (UILabel *)phoneLabel
{
    if(!_phoneLabel){
        _phoneLabel = [JQXCustom creatLabel:CGRectMake(SCREEN_WIDTH/3,_moneryLabel.bottom, SCREEN_WIDTH/3, 20) backColor:[UIColor clearColor] text:@"155****0608" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentCenter numOnLines:1];
    }
    return _phoneLabel;
    
}
- (UILabel *)styleLabel
{
    if(!_styleLabel){
        _styleLabel = [JQXCustom creatLabel:CGRectMake(SCREEN_WIDTH/3 *2, _lineView.bottom, SCREEN_WIDTH/3, SCALE_HEIGHT(120)-SCALE_HEIGHT(40)) backColor:[UIColor clearColor] text:@"积分支付" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentCenter numOnLines:1];
    }
    return _styleLabel;
    
}
- (UIView *)bottomView
{
    if(!_bottomView){
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCALE_HEIGHT(120), SCREEN_WIDTH, 5)];
        _bottomView.backgroundColor = RGB_COLOR(239, 239, 239);
        
    }
    
    return _bottomView;
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
