//
//  JQXChangePhotoCell.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/10/22.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "JQXChangePhotoCell.h"

@implementation JQXChangePhotoCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if([super initWithFrame:frame]){
        [self addSubview:self.headerImage];
    }
    return self;
}
- (void)setDataDic:(NSDictionary *)dic
{
    
}
- (UIImageView *)headerImage
{
    if(!_headerImage){
        _headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 50)/4, (SCREEN_WIDTH - 50)/4)];
        _headerImage.userInteractionEnabled = YES;
        _headerImage.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _headerImage;
}
@end
