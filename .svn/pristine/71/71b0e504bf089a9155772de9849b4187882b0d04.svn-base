//
//  JQXAlertView.m
//  PuHuiVip
//
//  Created by 节庆霞 on 2017/5/12.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "JQXAlertView.h"

#define kContentViewWidth 280.0f

#define kBaseTag 1000

#define textfont 15.0f

#define kSCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define kSCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

@interface JQXAlertView (){
    
    UIView *contentView;
    
}

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *leftTitle;

@property (nonatomic, copy) NSString *rightTitle;

@property (nonatomic,copy) void (^dialogViewCompleteHandle)(NSInteger);

@end



@implementation JQXAlertView

-(id)initWithMessage:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle {
    
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        
        
        
        self.message = message;
        self.leftTitle = leftButtonTitle;
        self.rightTitle = rightButtonTitle;
        
        self.frame = [UIScreen mainScreen].bounds;
        
        [self setup];
    }
    
    return self;
    
    
    
    
}


-(void)setup{
    
    //内容视图
    contentView = [[UIView alloc]init];
    contentView.clipsToBounds = YES;
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView.layer setCornerRadius:5.0f];
    
    
    //消息体
    UIFont *msgFont = [UIFont systemFontOfSize:textfont];
    _msgLabel = [[UILabel alloc]init];
    _msgLabel.backgroundColor = [UIColor clearColor];
    _msgLabel.font = msgFont;
    _msgLabel.textColor = [self DefineColorString:@"#333333"];
    _msgLabel.text = _message;
    _msgLabel.numberOfLines = 0;
    
    _msgLabel.frame = CGRectMake(10, 30, kContentViewWidth - 20,[_message CallateLabelSizeHeight:msgFont lineWidth: kContentViewWidth - 20]);
    
    if ( [_message CallatelabelSizeWidth:_msgLabel.font lineHeight:30] <= kContentViewWidth - 20 ) {
        _msgLabel.textAlignment = NSTextAlignmentCenter;
    }else{
        _msgLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    [contentView addSubview:_msgLabel];
    
    
    float buttonwidth = 100;
    float buttonheight = 35;
    float buttonTap = (kContentViewWidth - 2 *buttonwidth) / 3;
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:_leftTitle forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:textfont];
    [button1 setBackgroundColor:[UIColor whiteColor]];
    [button1 setTitleColor:[self DefineColorString:@"#888888"] forState:UIControlStateNormal];
    button1.frame = CGRectMake(buttonTap, _msgLabel.bottom + 25, buttonwidth, buttonheight);
    button1.clipsToBounds=YES;
    [button1.layer setCornerRadius:10.0]; //设置矩圆角半径
    [button1.layer setBorderWidth:1];   //边框宽度
    button1.layer.borderColor = [[self DefineColorString:@"#dddddd"] CGColor];
    button1.tag = kBaseTag + 0;
    [button1 addTarget:self action:@selector(buttonActionClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:button1];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:_rightTitle forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:textfont];
    [button2 setBackgroundColor:BACKGROUNGCOLOR];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button2.clipsToBounds=YES;
    [button2.layer setCornerRadius:10.0]; //设置矩圆角半径
    button2.frame = CGRectMake(button1.right + buttonTap, button1.top, buttonwidth , buttonheight);
    button2.tag = kBaseTag + 1;
    [button2 addTarget:self action:@selector(buttonActionClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:button2];
    
    contentView.frame = CGRectMake((kSCREEN_WIDTH - kContentViewWidth)  / 2, (kSCREEN_HEIGHT -  button1.bottom + 15) / 2 , kContentViewWidth, button1.bottom + 15);
    [self addSubview:contentView];
    
}


-(void)showWithCompletion:(void (^)(NSInteger))completeBlock
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    [self showInView:keyWindow completion:completeBlock];
}

-(void)showInView:(UIView *)baseView completion:(void (^)(NSInteger))completeBlock
{
    self.dialogViewCompleteHandle = completeBlock;
    
    [baseView addSubview:self];
    
    contentView.alpha = 0;
    contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3f animations:^{
        contentView.alpha = 1.0;
        contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    
    
}


/**
 *  关闭视图
 */
-(void)closeView
{
    [UIView animateWithDuration:0.3f animations:^{
        contentView.alpha = 0;
        contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)buttonActionClick:(UIButton *)button{
    
    NSInteger selIndex = button.tag - kBaseTag;
    
    if(_dialogViewCompleteHandle)
    {
        _dialogViewCompleteHandle(selIndex);
    }
    
    [self closeView];
    
    
    
}


-(UIColor *)DefineColorString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 charactersif ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appearsif ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

//设置按钮的背景颜色
- (UIImage *)imageWithColor:(NSString *)colorStr size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[self DefineColorString:colorStr] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*Aleart使用
 JQXAlertView *alert = [[JQXAlertView alloc]initWithMessage:@"你是二🐶么你是二🐶么你是二🐶么你是二🐶么你是二🐶么你是二🐶么你是二🐶么你是二🐶么你是二🐶么你是二🐶么你是二🐶么" leftButtonTitle:@"是的" rightButtonTitle:@"我现在是了"];
 
 
 [alert showWithCompletion:^(NSInteger selectIndex) {
 if (selectIndex == 0) {
 NSLog(@"我是左边按钮");
 
 }else{
 NSLog(@"我是右边按钮");

 }
 }];
 

 
 
 */


@end
