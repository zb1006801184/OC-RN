//
//  ReserveView.m
//  ChongQingPuHui
//
//  Created by 易商通 on 17/3/10.
//  Copyright © 2017年 重庆普惠有限公司. All rights reserved.
//

#import "ReserveView.h"

@implementation ReserveView


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {

        CGFloat wPos,xPos,fontPos;
        if (SCREEN_WIDTH < 375) {
            wPos = self.frame.size.width / 4;
            xPos = 40;
            fontPos = 13;

        }else if(SCREEN_WIDTH == 375){
            wPos = self.frame.size.width / 4;
            xPos = 60;
            fontPos = 15;
        }else{
            wPos = self.frame.size.width / 4;
            xPos = 60;
            fontPos = 15;

        }
        
        
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10,SCREENSIZE.width/3, 50)];
        timeLabel.text =@"02 - 28 14:30";
        timeLabel.textColor = [UIColor lightGrayColor];
        timeLabel.numberOfLines = 2;
        timeLabel.font = [UIFont systemFontOfSize:fontPos];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENSIZE.width/3, 10, SCREENSIZE.width/3, 50)];
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        moneyLabel.text =@"-16:00";
        moneyLabel.textColor = [UIColor blackColor];
        moneyLabel.font = [UIFont boldSystemFontOfSize:fontPos + 1];
        [self addSubview:moneyLabel];
        self.moneyLabel = moneyLabel;
        
        
//        UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(35 + wPos, 40, wPos + 30, 30)];
//        phoneLabel.text =@"134******6854";
//        phoneLabel.textColor = [UIColor lightGrayColor];
//        phoneLabel.font = [UIFont systemFontOfSize:fontPos];
//        [self addSubview:phoneLabel];
//        self.phoneLabel = phoneLabel;
        
        
        UILabel *payStyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENSIZE.width/3 * 2, 10, SCREENSIZE.width/3, 50)];
        payStyLabel.text =@"现金支付";
        payStyLabel.textColor = [UIColor lightGrayColor];
        payStyLabel.font = [UIFont systemFontOfSize:fontPos + 1];
        payStyLabel.numberOfLines = 2;
        payStyLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:payStyLabel];
        self.payStyLabel = payStyLabel;
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 79, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f];
        [self addSubview:lineView];

        
    }
    
    return self;
    
}





@end
