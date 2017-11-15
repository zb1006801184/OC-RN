//
//  OrderButton.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/22.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "OrderButton.h"

@implementation OrderButton
#define kTitleRatio 0.4
- (instancetype)initWithFrame:(CGRect)frame
{
    if([super initWithFrame:frame]){
        self.titleLabel.font  = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor colorWithHexString:@"#888889"] forState:UIControlStateNormal];
        [self setTitleColor:BACKGROUNGCOLOR forState:UIControlStateSelected];
    }
    return self;
}
#pragma mark - 调整内部ImageView的frame --
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageX = 20;
    CGFloat imageY = 0;
    CGFloat imageWidth = contentRect.size.width - 40;
    CGFloat imageHeight = contentRect.size.height * (1 - kTitleRatio);
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}
#pragma mark - 调整内部UIlable的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight + 10;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}



@end
