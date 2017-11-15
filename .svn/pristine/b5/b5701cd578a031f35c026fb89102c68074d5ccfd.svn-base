//
//  ShopAddressCell.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/25.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "ShopAddressCell.h"

@implementation ShopAddressCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.titleLabel = [JQXCustom creatLabel:CGRectMake(20, 10, SCREEN_WIDTH - 80, 20) backColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft numOnLines:1];
        [self addSubview:self.titleLabel];
        
        self.contentLabel = [JQXCustom creatLabel:CGRectMake(20, self.titleLabel.bottom, SCREEN_WIDTH - 80, 20) backColor:[UIColor clearColor] text:@"" textColor:[UIColor colorWithHexString:@"#999999"] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft numOnLines:1];
        [self addSubview:self.contentLabel];
        
        self.sureImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 15, 30, 30)];
        self.sureImg.image = [UIImage imageNamed:@"orderpaysure"];
        self.sureImg.hidden = YES;
        [self addSubview:self.sureImg];
        
    }
    return self;
}
- (void)sureImgHidden:(NSInteger)index selected:(NSInteger)selectedIndex

{
    if(index == selectedIndex){
        self.sureImg.hidden = NO;
    }else{
        self.sureImg.hidden = YES;
    }
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
