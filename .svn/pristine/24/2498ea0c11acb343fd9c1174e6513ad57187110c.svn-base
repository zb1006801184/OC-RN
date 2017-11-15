//
//  ClassTableViewCell.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/27.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "ClassTableViewCell.h"

@implementation ClassTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier style:(NSString *)styleStr;
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = RGB_COLOR(239, 239, 239);
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.contentLabel];
        if([styleStr isEqualToString:@"编辑"]){
           [self.bgView addSubview:self.editButton];
            [self.bgView addSubview:self.deleteButton];
            [self.bgView addSubview:self.scrollButton];
        }
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dic
{
    self.contentLabel.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"typeName"])];
}
- (UIView *)bgView
{
    if(!_bgView){
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH - 10, 55)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 8;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}
- (UILabel *)contentLabel
{
    if(!_contentLabel){
        _contentLabel = [JQXCustom creatLabel:CGRectMake(10,0, _bgView.width - 20, _bgView.height) backColor:[UIColor clearColor] text:@"蔬菜" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:1];
        
    }
    return _contentLabel;
}
- (UIButton *)editButton
{
    if(!_editButton){
        // _bgView.width - 120, 0, 40, 50
        _editButton = [JQXCustom creatButton:CGRectMake(_bgView.width - 100, 0, 50, _bgView.height) backColor:[UIColor clearColor] text:@"" textColor:[UIColor clearColor] font:Font(12) addTarget:self Action:@selector(EditAction)];
        [_editButton setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(_editButton.width - 1,10, 1,  _bgView.height - 20)];
        lineView.backgroundColor = RGB_COLOR(239, 239, 239);
        [_editButton addSubview:lineView];
    }
    return _editButton;
}
- (UIButton *)deleteButton
{
    if(!_deleteButton){
        // _bgView.width - 80, 0, 40, 50
        _deleteButton = [JQXCustom creatButton:CGRectMake(_bgView.width - 50, 0, 50,  _bgView.height) backColor:[UIColor clearColor] text:@"" textColor:[UIColor clearColor] font:Font(12) addTarget:self Action:@selector(DeleteAction)];
        [_deleteButton setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(_deleteButton.width - 1,10, 1,  _bgView.height - 20)];
        lineView.backgroundColor = RGB_COLOR(239, 239, 239);
        [_deleteButton addSubview:lineView];
    }
    return _deleteButton;
}
- (UIButton *)scrollButton
{
    if(!_scrollButton){
        _scrollButton = [JQXCustom creatButton:CGRectMake(_bgView.width - 60, 0, 60,  _bgView.height) backColor:[UIColor clearColor] text:@"" textColor:[UIColor clearColor] font:Font(12) addTarget:self Action:@selector(ScrollAction)];
        _scrollButton.hidden = YES;
    }
    return _scrollButton;
}
#pragma mark - 编辑
- (void)EditAction
{
    [self.delegate EditClassCell:self];
}
#pragma mark - 删除
- (void)DeleteAction
{
    [self.delegate DelegateCell:self];
}
#pragma mark - 移动
- (void)ScrollAction
{
    [self.delegate ScrollCell:self];
}
//#pragma mark - 重写系统移动按钮样式
//- (void) setEditing:(BOOL)editing animated:(BOOL)animated
//{
//    [super setEditing: editing animated: YES];
//    
//    if (editing) {
//        
//        for (UIView * view in self.subviews) {
//            if ([NSStringFromClass([view class]) rangeOfString: @"Reorder"].location != NSNotFound) {
//                for (UIView * subview in view.subviews) {
//                    if ([subview isKindOfClass: [UIImageView class]]) {
//                        ((UIImageView *)subview).frame = CGRectMake(15, (50 - 23)/2, 23, 23);
//                        ((UIImageView *)subview).image = [UIImage imageNamed: @"3"];
//                    }
//                }
//            }
//        }
//    }
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
