//
//  JQXButton.m
//  UIButton
//
//  Created by 节庆霞 on 2017/7/7.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "JQXButton.h"

@implementation JQXButton

- (instancetype)initWithFrame:(CGRect)frame index:(int)indexPath
{
    if([super initWithFrame:frame]){
        
        self.btnImg = [[UIImageView alloc]init];
        if(indexPath == 0){
            self.btnImg.frame = CGRectMake((self.width - SCALE_WIDTH(30))/2, SCALE_HEIGHT(20),SCALE_WIDTH(30), SCALE_HEIGHT(42.5));
        }else if (indexPath == 1 ||indexPath == 2){
            self.btnImg.frame = CGRectMake((self.width - SCALE_WIDTH(30))/2, SCALE_HEIGHT(31),SCALE_WIDTH(30), SCALE_HEIGHT(22));
            
        }else if (indexPath == 3){
            self.btnImg.frame = CGRectMake((self.width - SCALE_WIDTH(30))/2, SCALE_HEIGHT(28),SCALE_WIDTH(30), SCALE_HEIGHT(28));
            
        }else if (indexPath == 4){
            self.btnImg.frame = CGRectMake((self.width - SCALE_WIDTH(30))/2, SCALE_HEIGHT(28),SCALE_WIDTH(30), SCALE_HEIGHT(30));
            
        }else if (indexPath == 5){
            self.btnImg.frame = CGRectMake((self.width - SCALE_WIDTH(28))/2, SCALE_HEIGHT(29),SCALE_WIDTH(27), SCALE_HEIGHT(30));
            
        }else if (indexPath == 6){
            self.btnImg.frame = CGRectMake((self.width - SCALE_WIDTH(35))/2, SCALE_HEIGHT(28),SCALE_WIDTH(35), SCALE_HEIGHT(27));
            
        }else if (indexPath == 7){
            self.btnImg.frame = CGRectMake((self.width - SCALE_WIDTH(27))/2, SCALE_HEIGHT(29),SCALE_WIDTH(27), SCALE_HEIGHT(30));
            
        }else if (indexPath == 8){
            self.btnImg.frame = CGRectMake((self.width - SCALE_WIDTH(30))/2, SCALE_HEIGHT(29),SCALE_WIDTH(30), SCALE_WIDTH(30));
        }
        [self addSubview:self.btnImg];
        
        self.btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height - 40, self.width, 30)];
        self.btnLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        self.btnLabel.font = [UIFont systemFontOfSize:17];
        self.btnLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.btnLabel];
        
        UIView *wlineView = [[UIView alloc]initWithFrame:CGRectMake(self.width - 1, 0, 1, self.height)];
        wlineView.backgroundColor = RGB_COLOR(242, 242, 242);
        [self addSubview:wlineView];
        
        UIView *hlineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 1, self.width , 1)];
        hlineView.backgroundColor = RGB_COLOR(242, 242, 242);
        [self addSubview:hlineView];
        
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame styleStr:(NSString *)str
{
    if([super initWithFrame:frame]){
        
        self.layer.cornerRadius = self.height/2;
        self.layer.borderColor = BACKGROUNGCOLOR.CGColor;
        self.layer.borderWidth = 1;
        
        self.btnStyleBtnLabel = [JQXCustom creatLabel:CGRectMake(0, 0, self.width, self.height) backColor:[UIColor clearColor] text:@"" textColor:BACKGROUNGCOLOR font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter numOnLines:0];
        [self addSubview:self.btnStyleBtnLabel];
        
        self.btnImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - 15, -10 , 20, 20)];
        self.btnImg.image = [UIImage imageNamed:@"icon_delete"];
        [self addSubview:self.btnImg];
        
    }
    return self;
    
}
@end
