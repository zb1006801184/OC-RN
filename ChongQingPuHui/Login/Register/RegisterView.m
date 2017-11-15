//
//  RegisterView.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/24.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if([super initWithFrame:frame]){
        
    
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
        
        self.tsLabel = [JQXCustom creatLabel:CGRectMake(10, 0, 80, self.height) backColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
        
        [self addSubview:self.tsLabel];
        
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame lineStr:(NSString *)line
{
    if([super initWithFrame:frame]){
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(self.width - SCALE_WIDTH(30), 0, 1, self.height)];
        lineView.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f];
        [self addSubview:lineView];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - SCALE_WIDTH(30)+(SCALE_WIDTH(30) - 10)/2, (self.height - 10)/2, 10, 10)];
        img.image = [UIImage imageNamed:@"arrow"];
        [self addSubview:img];
        
        self.jButton = [JQXCustom creatButton:CGRectMake(0, 0, self.width, self.height) backColor:[UIColor clearColor] text:@"" textColor:[UIColor clearColor] font:[UIFont systemFontOfSize:12] addTarget:nil Action:nil];
        [self addSubview:self.jButton];
        

        
        
    }
    return self;
}

@end
