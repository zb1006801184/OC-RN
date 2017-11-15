//
//  BuyTimeTableViewCell.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/9/25.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "BuyTimeTableViewCell.h"

@implementation BuyTimeTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self addSubview:self.startTimeButton];
        [self addSubview:self.endTimeButton];
        
    }
    return self;
}
- (void)setData:(NSDictionary *)dic{
    NSString *starStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"startTime"])];
    if([starStr isEqualToString:@"(null)"]){
        starStr = @"";
    }
    [self.startTimeButton setTitle:starStr forState:UIControlStateNormal];
    
    NSString *endStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"endTime"])];
    if([endStr isEqualToString:@"(null)"]){
        endStr = @"";
    }
    [self.endTimeButton setTitle:endStr forState:UIControlStateNormal];
}
- (UIButton *)startTimeButton
{
    if(!_startTimeButton){
        _startTimeButton = [JQXCustom creatButton:CGRectMake(20,10, SCALE_WIDTH(110), 35) backColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:Font(13) addTarget:self Action:@selector(StartTimeAction)];
        _startTimeButton.layer.borderWidth = 1;
        _startTimeButton.layer.borderColor = RGB_COLOR(221, 221, 221).CGColor;
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(_startTimeButton.right + 10, _startTimeButton.top + 35/2 , 15, 1)];
        lineView.backgroundColor = RGB_COLOR(221, 221, 221);
        [self addSubview:lineView];
    }
    return _startTimeButton;
}

- (UIButton *)endTimeButton
{
    if(!_endTimeButton){
        _endTimeButton = [JQXCustom creatButton:CGRectMake(_startTimeButton.right + 35,10, SCALE_WIDTH(110), 35) backColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:Font(13) addTarget:self Action:@selector(EndTimeAction)];
        _endTimeButton.layer.borderWidth = 1;
        _endTimeButton.layer.borderColor = RGB_COLOR(221, 221, 221).CGColor;
    }
    return _endTimeButton;
}

- (UIButton *)addButton
{
    if(!_addButton){
        _addButton = [JQXCustom creatButton:CGRectMake(_endTimeButton.right + 22,10, 35, 35) backColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:Font(13) addTarget:self Action:@selector(AddAction)];
        [_addButton setImage:[UIImage imageNamed:@"buttonAdd"] forState:UIControlStateNormal];
    }
    return _addButton;
}
- (UIButton *)deleteButton
{
    if(!_deleteButton){
        _deleteButton = [JQXCustom creatButton:CGRectMake(_endTimeButton.right + 20,10, 40, 35) backColor:[UIColor clearColor] text:@"删除" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(15) addTarget:self Action:@selector(DeleteAction)];
    }
    return _deleteButton;
}

#pragma mark - 消费时段 开始
- (void)StartTimeAction
{
    [self.ButtonDelegate StartTimeClassSure:self];
}
#pragma mark - 消费时段 结束
- (void)EndTimeAction
{
    [self.ButtonDelegate EndTimeTimeClassSure:self];
}
#pragma mark - 添加
- (void)AddAction
{
    [self.ButtonDelegate AddClassSure:self];
}
#pragma mark - 删除
- (void)DeleteAction
{
    [self.ButtonDelegate DeleteClassSure:self];
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
