//
//  AdvanceTableViewCell.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/26.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "AdvanceTableViewCell.h"

@implementation AdvanceTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = RGB_COLOR(239, 239, 239);
        [self setMainUI];
        
          [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifActon:) name:@"JQXHaveButton" object:nil];
    }
    return self;
}

- (void)notifActon:(NSNotification *)notif
{
    self.haveButton.userInteractionEnabled = YES;
    self.cancleButton.userInteractionEnabled = YES;
}

- (void)setMainUI
{
    //电话
    UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH - 20, 50)];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.layer.cornerRadius = 8;
    phoneView.layer.masksToBounds = YES;
    [self addSubview:phoneView];
    
    self.img = [[UIImageView alloc]initWithFrame:CGRectMake(20, (phoneView.height - 20)/2, 20, 20)];
    [phoneView addSubview:self.img];
    
    self.phoneLabel = [JQXCustom creatLabel:CGRectMake(self.img.right + 10, 0, 130, phoneView.height) backColor:[UIColor clearColor] text:@"18502349987" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(12) textAlignment:NSTextAlignmentLeft numOnLines:1];
    [phoneView addSubview:self.phoneLabel];
    
    
    self.styleLabel = [JQXCustom creatLabel:CGRectMake(phoneView.width - 90, 0, 80, phoneView.height) backColor:[UIColor clearColor] text:@"已评价" textColor:[UIColor blackColor] font:Font(12) textAlignment:NSTextAlignmentRight numOnLines:1];
    [phoneView addSubview:self.styleLabel];
    
    //预计到店时间
    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(10, phoneView.bottom + 1, SCREEN_WIDTH - 20, 55)];
    timeView.backgroundColor = [UIColor whiteColor];
    timeView.layer.cornerRadius = 8;
    timeView.layer.masksToBounds = YES;
    [self addSubview:timeView];
    
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, (phoneView.height - 20)/2, 20, 20)];
    img1.image = [UIImage imageNamed:@"time_img"];
    [timeView addSubview:img1];
    
    UILabel *tsTimeLabel = [JQXCustom creatLabel:CGRectMake(img1.right + 10, 0, 130, phoneView.height) backColor:[UIColor clearColor] text:@"预计到店时间" textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentLeft numOnLines:1];
    [timeView addSubview:tsTimeLabel];
    
    self.shopTimeLabel = [JQXCustom creatLabel:CGRectMake(phoneView.width - 140, 0, 130, phoneView.height) backColor:[UIColor clearColor] text:@"8月31日 22:00" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(12) textAlignment:NSTextAlignmentRight numOnLines:1];
    [timeView addSubview:self.shopTimeLabel];


    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(10,timeView.bottom - 5 , SCREEN_WIDTH - 20, 60 *2)];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentView.width, 1)];
    lineView.backgroundColor = RGB_COLOR(248, 248, 248);
    [contentView addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 60, contentView.width, 1)];
    lineView1.backgroundColor = RGB_COLOR(248, 248, 248);
    [contentView addSubview:lineView1];
    
    UILabel *peopleTSLabel = [JQXCustom creatLabel:CGRectMake(20, 0, 80, 60) backColor:[UIColor clearColor] text:@"用餐人数" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:1];
    [contentView addSubview:peopleTSLabel];
    
    self.peopleLabel = [JQXCustom creatLabel:CGRectMake(contentView.width - 110, 0, 100, 60) backColor:[UIColor clearColor] text:@"6人" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentRight numOnLines:1];
    [contentView addSubview:self.peopleLabel];
    
    UILabel *tableTSLabel = [JQXCustom creatLabel:CGRectMake(20, 60, 80, 60) backColor:[UIColor clearColor] text:@"餐位名称" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:1];
    [contentView addSubview:tableTSLabel];
    
    self.tableLabel = [JQXCustom creatLabel:CGRectMake(contentView.width - (contentView.width - 110) - 10, 60, contentView.width - 110, 60) backColor:[UIColor clearColor] text:@"包间1玫瑰间" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(12) textAlignment:NSTextAlignmentRight numOnLines:1];
    
    [contentView addSubview:self.tableLabel];

    //合计
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(10, contentView.bottom - 5, SCREEN_WIDTH - 20, 55)];
    self.bottomView.backgroundColor = RGB_COLOR(248, 248, 248);
    self.bottomView.layer.cornerRadius = 8;
    self.bottomView.layer.masksToBounds = YES;
    [self addSubview:self.bottomView];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bottomView.width, 5)];
    lineView2.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:lineView2];
    
    self.allPriceLabel = [JQXCustom creatLabel:CGRectMake(10, 5, 200, 50) backColor:[UIColor clearColor] text:@"" textColor:BACKGROUNGCOLOR font:Font(15) textAlignment:NSTextAlignmentLeft numOnLines:1];
    [self.bottomView addSubview:self.allPriceLabel];
    
    self.haveButton = [JQXCustom creatButton:CGRectMake(self.bottomView.width - SCALE_WIDTH(100), 15 , SCALE_WIDTH(90), 30) backColor:BACKGROUNGCOLOR text:@"接单" textColor:[UIColor whiteColor] font:Font(13) addTarget:self Action:@selector(HaveAction)];
    self.haveButton.layer.cornerRadius = 8;
    self.haveButton.layer.masksToBounds = YES;
    [self.bottomView addSubview:self.haveButton];
    
    
    self.cancleButton = [JQXCustom creatButton:CGRectMake(self.haveButton.left - SCALE_WIDTH(100), 15, SCALE_WIDTH(90), 30) backColor:[UIColor whiteColor] text:@"取消订单" textColor:[UIColor blackColor] font:Font(13) addTarget:self Action:@selector(CancleAction)];
    self.cancleButton.layer.cornerRadius = 8;
    self.cancleButton.layer.masksToBounds = YES;
    self.cancleButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.cancleButton.layer.borderWidth = 1;
    self.cancleButton.hidden = YES;
    [self.bottomView addSubview:self.cancleButton];
    
    

    self.messageButton = [JQXCustom creatButton:CGRectMake(self.bottomView.width - 110, 15 , 100, 30) backColor:BACKGROUNGCOLOR text:@"查看评价信息" textColor:[UIColor whiteColor] font:Font(13) addTarget:self Action:@selector(MessageAction)];
    self.messageButton.layer.cornerRadius = 8;
    self.messageButton.layer.masksToBounds = YES;
    [self.bottomView addSubview:self.messageButton];
    
}

- (void)setDataDic:(NSDictionary *)dic index:(NSInteger)index
{
    self.mainDic = dic;
    
    NSString *imgStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"memberHeadImage"])];
    [self.img sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"yudingguanli_huiyuan"]];
    
    self.phoneLabel.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"memberTelPhone"])];
    self.shopTimeLabel.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"hopeServiceDate"])];
    self.peopleLabel.text = [NSString stringWithFormat:@"%@人",NULL_TO_NIL(dic[@"num"])];
    
    CGFloat monery = [[NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"subscriptionMoney"])] floatValue];
    NSString *moneryStr = [NSString stringWithFormat:@"合计：¥%.2f",monery];
     self.allPriceLabel.attributedText = [self String:moneryStr RangeString:@"合计：" style:@"合计"];
    NSArray *contentArray = dic[@"seats"];
    NSString * contentStr = @"";
    if(contentArray.count != 0){
        NSDictionary *dict = [contentArray objectAtIndex:0];
//         contentStr = [NSString stringWithFormat:@"%@  预计时长%@分钟 %@",contentStr,NULL_TO_NIL(dict[@"hopetime"]),NULL_TO_NIL(dict[@"dishName"])];
        contentStr = [NSString stringWithFormat:@"%@  %@",contentStr,NULL_TO_NIL(dict[@"dishName"])];
    }
    self.tableLabel.attributedText = [self String:contentStr RangeString:@"" style:@"餐位名称"];
    
    if([dic[@"status"] intValue] == 1){
        
        self.styleLabel.text = @"待确认";
        self.haveButton.hidden = NO;
        self.cancleButton.hidden = NO;
        self.messageButton.hidden = YES;
        
    }else if ([dic[@"status"] intValue] == 2){
        
        self.styleLabel.text = @"已确认";
        self.haveButton.hidden = YES;
        self.cancleButton.hidden = YES;
        self.messageButton.hidden = YES;
        
    }else if([dic[@"status"] intValue] == 3){
        
        self.styleLabel.text = @"已评价";
        self.haveButton.hidden = YES;
        self.cancleButton.hidden = YES;
        self.messageButton.hidden = NO;
    }else if ([dic[@"status"] intValue] == 7){//交易取消

        self.styleLabel.text = @"交易取消";
        self.haveButton.hidden = YES;
        self.cancleButton.hidden = YES;
        self.messageButton.hidden = YES;
        
    }
    
    
    
}
#pragma mark - 接单按钮
- (void)HaveAction
{
    self.haveButton.userInteractionEnabled = NO;
    [self.cellDelegate AdvanceTableViewCell:self.mainDic];
}

- (void)CancleAction
{
    self.cancleButton.userInteractionEnabled = NO;
    [self.cellDelegate AdvanceCancleTableViewCell:self.mainDic];
}

#pragma mark - 查看评价按钮
- (void)MessageAction
{
    [self.cellDelegate MessageTableViewCell:self.mainDic];
}

- (NSMutableAttributedString *)String:(NSString *)String RangeString:(NSString *)RangeString style:(NSString *)styleStr
{
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:String];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:RangeString];
    if([styleStr isEqualToString:@"餐位名称"]){
        [hintString addAttribute:NSForegroundColorAttributeName value: [UIColor blackColor] range:range1];
        [hintString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range1];
    }else{
        [hintString addAttribute:NSForegroundColorAttributeName value: [UIColor blackColor] range:range1];
    }
    
    
    
    return hintString;
}

- (NSDictionary *)mainDic
{
    if(!_mainDic){
        _mainDic = [NSDictionary dictionary];
    }
    return _mainDic;
}
- (void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
