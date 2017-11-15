//
//  PayCodeView.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/28.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "PayCodeView.h"

@implementation PayCodeView

- (instancetype)initWithFrame:(CGRect)frame imgUrl:(NSString *)url monery:(NSString *)moneryStr
{
    
    if([super initWithFrame:frame]){
        
        UILabel *moneryLabel = [JQXCustom creatLabel:CGRectMake(0, 0, self.width, 40) backColor:[UIColor clearColor] text:moneryStr textColor:BACKGROUNGCOLOR font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter numOnLines:1];
        [self addSubview:moneryLabel];
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - (self.width - SCALE_WIDTH(130)))/2, moneryLabel.bottom + 10, self.width - SCALE_WIDTH(130), self.width - SCALE_WIDTH(130))];
        [imgView sd_setImageWithURL:[NSURL URLWithString:url]];
        [self addSubview: imgView];
        
        UIButton *button = [JQXCustom creatButton:CGRectMake(imgView.left, imgView.bottom + 20,  imgView.width, 40) backColor:BACKGROUNGCOLOR text:@"取消" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14] addTarget:self Action:@selector(buttonAction)];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5;
        
        [self addSubview:button];
        
        
    }
    return self;
}
- (void)buttonAction
{
     [[NSNotificationCenter defaultCenter] postNotificationName:@"CodeCancle" object:nil userInfo:nil];
}

@end
