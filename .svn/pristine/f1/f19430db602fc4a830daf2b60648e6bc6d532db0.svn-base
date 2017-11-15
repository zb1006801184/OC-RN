//
//  MessageHeaderCell.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/27.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "MessageHeaderCell.h"

@implementation MessageHeaderCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setMianUI];
    }
    return self;
}
- (void)setMianUI
{
    [self addSubview:self.img];
    [self addSubview:self.nickLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.contentLabel];
    @autoreleasepool {
        for (int i = 0; i < 5; i ++) {
            UIImageView *gryImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - (15 *5 + 5*4) - 10) + i *15 + i *5, 40, 15, 15)];
            gryImg.image = [UIImage imageNamed:@"yellow star_n"];
            [self addSubview:gryImg];
        }
    }
    
    [self addSubview:self.starView];
    
}
- (void)setDataDic:(NSDictionary *)dic
{
    NSArray *array = dic[@"cList"];
    NSString *contentStr = [NSString stringWithFormat:@"%@",array[0][@"content"]];
     CGFloat contentH = [contentStr CallateLabelSizeHeight:Font(14) lineWidth:SCREEN_WIDTH - 30 - 45];
    [self.contentLabel setHeight:contentH];
    NSString *imgStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"headImage"])];
    [self.img sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"JQXShi"]];
    
    NSString *nickStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"nikeName"])];
    if([nickStr isEqualToString:@"(null)"]){
        nickStr = @"匿名用户";
    }
    self.nickLabel.text = nickStr;
    
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@",dic[@"created_time"]];
    self.contentLabel.text = contentStr;
   
    [self.starView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    @autoreleasepool {
        for (int i = 0; i < [dic[@"startNum"] intValue]; i ++) {
            UIImageView *starImg = [[UIImageView alloc]initWithFrame:CGRectMake(i *15 + i *5, 0, 15, 15)];
            starImg.image = [UIImage imageNamed:@"yellow star_s"];
            [self.starView addSubview:starImg];
        }
    }
     [self.replyView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if(array.count > 1){//array 的第一条数据是评论内容
        [self.jiaoView setTop:self.contentLabel.bottom + 10];
        [self.replyView setTop:self.jiaoView.bottom];
        [self addSubview:self.jiaoView];
        [self addSubview:self.replyView];
        CGFloat replayH = 10;
        @autoreleasepool {
            
            for (int i = 1; i < array.count; i ++) {
                NSDictionary *dict = array[i];
                CGFloat tsW = [@"匿名用户回复" CallatelabelSizeWidth:Font(12) lineHeight:15];
                UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(10, replayH, tsW, 15) backColor:[UIColor clearColor] text:@"" textColor:RGB_COLOR(116, 116, 116)  font:Font(12) textAlignment:NSTextAlignmentLeft numOnLines:1];
                NSString *userType = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dict[@"userType"])];
                if([userType intValue] == 1){
                    tsLabel.text = [NSString stringWithFormat:@"%@回复",self.nickLabel.text];
                }else{
                    tsLabel.text = @"我的回复";
                }
                
                
                [self.replyView addSubview:tsLabel];
                
                NSString *replyStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dict[@"content"])];
                CGFloat contentH = [replyStr CallateLabelSizeHeight:Font(12) lineWidth:SCREEN_WIDTH - 30 - 45 - 20 - 60 - 10];
                
                UILabel *contentLabel = [JQXCustom creatLabel:CGRectMake(tsLabel.right + 5, replayH, SCREEN_WIDTH - 30 - 45 - 20 - 60 - 10, contentH) backColor:[UIColor clearColor] text:replyStr textColor:[UIColor blackColor]  font:Font(12) textAlignment:NSTextAlignmentLeft numOnLines:0];
                [self.replyView addSubview:contentLabel];
                
                replayH = contentLabel.bottom + 5;
                
            }
            
        }
        [self.replyView setHeight:replayH + 5];
    }
    
    
    
}
- (UIImageView *)img{
    if(!_img){
        _img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 45, 45)];
        _img.backgroundColor = [UIColor orangeColor];
        _img.layer.cornerRadius = _img.height/2;
        _img.layer.masksToBounds = YES;
    }
    return _img;
}
- (UILabel *)nickLabel
{
    if(!_nickLabel){
        _nickLabel = [JQXCustom creatLabel:CGRectMake(_img.right + 10, 40, (SCREEN_WIDTH - (15 *5 + 5*4) - 10 - _img.width - 20), 15) backColor:[UIColor clearColor] text:@"白发飞天小魔女" textColor:[UIColor blackColor] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:1];
    }
    return _nickLabel;
}
- (UILabel *)timeLabel
{
    if(!_timeLabel){
        _timeLabel = [JQXCustom creatLabel:CGRectMake(_img.right + 10, _nickLabel.bottom + 5, (SCREEN_WIDTH - (15 *5 + 5*4) - 10 - _img.width - 20), 15) backColor:[UIColor clearColor] text:@"2017-08-21 22:10:00" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(9) textAlignment:NSTextAlignmentLeft numOnLines:1];
    }
    return _timeLabel;
}

- (UILabel *)contentLabel
{
    if(!_contentLabel){
        _contentLabel = [JQXCustom creatLabel:CGRectMake(_img.right + 10, _img.bottom + 30, (SCREEN_WIDTH - 10 - _img.width - 20), 15) backColor:[UIColor clearColor] text:@"hahahahahahahahahahahahaha" textColor:[UIColor colorWithHexString:@"#333333"] font:Font(14) textAlignment:NSTextAlignmentLeft numOnLines:0];
    }
    return _contentLabel;
}
- (UIImageView *)jiaoView
{
    if(!_jiaoView){
        _jiaoView = [[UIImageView alloc]initWithFrame:CGRectMake(45 + 10 + 10 + 20,_contentLabel.bottom + 10, 9, 9)];
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

- (UIView *)starView
{
    if(!_starView){
        _starView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - (15 *5 + 5*4) - 10, 40, (15 *5 + 5*4), 15)];
        _starView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    }
    return _starView;
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
