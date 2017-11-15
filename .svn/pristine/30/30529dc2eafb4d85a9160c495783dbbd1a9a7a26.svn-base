//
//  ReplyTableViewCell.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/27.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "ReplyTableViewCell.h"

@implementation ReplyTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self addSubview:self.jiaoView];
        [self addSubview:self.replyView];
    }
    return self;
}
- (void)setDataArray:(NSArray *)array
{
    CGFloat replayH = 10;
    @autoreleasepool {
        
        for (int i = 0; i < array.count; i ++) {
            
            CGFloat tsH = [@"我的回复" CallateLabelSizeHeight:Font(12) lineWidth:60];
            UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(10, replayH, 60, tsH) backColor:[UIColor clearColor] text:@"我的回复" textColor:RGB_COLOR(116, 116, 116)  font:Font(12) textAlignment:NSTextAlignmentLeft numOnLines:1];
            [self.replyView addSubview:tsLabel];
            
             CGFloat contentH = [array[i] CallateLabelSizeHeight:Font(12) lineWidth:SCREEN_WIDTH - 30 - 45 - 20 - 60 - 10];
            
            UILabel *contentLabel = [JQXCustom creatLabel:CGRectMake(tsLabel.right + 10, replayH, SCREEN_WIDTH - 30 - 45 - 20 - 60 - 10, contentH) backColor:[UIColor clearColor] text:array[i] textColor:[UIColor blackColor]  font:Font(12) textAlignment:NSTextAlignmentLeft numOnLines:0];
            [self.replyView addSubview:contentLabel];
            
            replayH = contentLabel.bottom + 5;
            
        }
        
    }
    [self.replyView setHeight:replayH];
    
    
    
    
}
- (UIImageView *)jiaoView
{
    if(!_jiaoView){
       _jiaoView = [[UIImageView alloc]initWithFrame:CGRectMake(45 + 10 + 10 + 20, 10, 9, 9)];
        _jiaoView.image = [UIImage imageNamed:@"jiujiu"];
        
    }
    return _jiaoView;
}
- (UIView *)replyView
{
    if(!_replyView){
        _replyView = [[UIView alloc]initWithFrame:CGRectMake(45 + 10 + 10, _jiaoView.bottom, SCREEN_WIDTH - 30 - 45, 20)];
        _replyView.backgroundColor = RGB_COLOR(244, 244, 244);
        _replyView.layer.cornerRadius = 8;
        _replyView.layer.masksToBounds = YES;
    }
    return _replyView;
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
