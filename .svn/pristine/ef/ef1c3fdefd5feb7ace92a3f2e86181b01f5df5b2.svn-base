//
//  OrderCell.m
//  ChongQingPuHui
//
//  Created by 易商通 on 17/3/10.
//  Copyright © 2017年 重庆普惠有限公司. All rights reserved.
//

#import "OrderCell.h"
#import "DateTimeModel.h"
@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"OrderCell";
    OrderCell *cell=[[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    cell.backgroundColor=[UIColor whiteColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)setDataArray:(OrderRecModel *)dataArray{
    
    CGFloat wPos,fontPos;
    if (SCREEN_WIDTH < 375) {
        wPos = self.frame.size.width / 4;
        fontPos = 13;
    }else if(SCREEN_WIDTH == 375){
        wPos = self.frame.size.width / 4 + 20;
        fontPos = 15;
    }else{
        wPos = self.frame.size.width / 3;
        fontPos = 15;
    }
    
    NSString *payType = [NSString stringWithFormat:@"%@",dataArray.payType];//1.现金支付，2.积分支付
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10,SCREENSIZE.width/3, 50)];
    timeLabel.text = [NSString stringWithFormat:@"%@",dataArray.payDate];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.numberOfLines = 2;
    timeLabel.font = [UIFont systemFontOfSize:fontPos];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:timeLabel];
    

    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENSIZE.width/3, 10, SCREENSIZE.width/3, 30)];
    if ([payType isEqual:@"1"]) {
        moneyLabel.text =[NSString stringWithFormat:@"%@分",dataArray.totalPrice];
    }else{
        moneyLabel.text =[NSString stringWithFormat:@"%@元",dataArray.totalPrice];
    }
    moneyLabel.textColor = [UIColor blackColor];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.font = [UIFont boldSystemFontOfSize:fontPos + 2];
    [self addSubview:moneyLabel];

    NSString *hiddenStr = [NSString stringWithFormat:@"%@",dataArray.memberPhone];
    NSString *phoneStr = @"";
    if(hiddenStr.length == 11 || hiddenStr.length == 13){
        phoneStr = [NSString stringWithFormat:@"%@****%@",[hiddenStr substringToIndex:3],[hiddenStr substringFromIndex:7]];
    }
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENSIZE.width/3, 40, SCREENSIZE.width/3, 30)];
    phoneLabel.text = phoneStr;
    phoneLabel.textColor = [UIColor lightGrayColor];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.font = [UIFont systemFontOfSize:fontPos];
    [self addSubview:phoneLabel];

    
    
    UILabel *payStyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENSIZE.width/3*2, 10, SCREENSIZE.width/3, 50)];
    if ([payType isEqual:@"0"]) {
        payStyLabel.text = @"现金支付";
    }else if([payType isEqual:@"1"]){
        payStyLabel.text = @"积分支付";
    }else if([payType isEqual:@"2"]){
        payStyLabel.text = @"支付宝支付";
    }else if([payType isEqual:@"8"]){
        payStyLabel.text = @"快捷支付";
    }else if([payType isEqual:@"9"]){
        payStyLabel.text = @"远程支付";
    }
    //0现金 1积分 2支付宝 3 微信
    payStyLabel.textColor = [UIColor lightGrayColor];
    payStyLabel.font = [UIFont systemFontOfSize:fontPos + 1];
    payStyLabel.numberOfLines = 2;
    payStyLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:payStyLabel];
    
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH,10)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:lineView];
    

}
//- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
//{
//    // 格式化时间
//    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    
//    // 毫秒值转化为秒
//    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
//    NSString* dateString = [formatter stringFromDate:date];
//    return dateString;
//}


@end
