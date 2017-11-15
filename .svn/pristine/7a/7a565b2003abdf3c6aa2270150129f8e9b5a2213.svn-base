//
//  ActivationViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/26.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "ActivationViewController.h"
#define kDotSize CGSizeMake (10, 10) //密码点的大小
#define kDotCount 6  //密码个数
#define K_Field_Height 35  //每一个输入框的高度
@interface ActivationViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)UITextField *textFiled;
@property (nonatomic,strong)NSMutableArray *dotArray; //用于存放黑色的点点


@end

@implementation ActivationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"激活码" isBack:YES];
    [self clearUpPassword];
    [self.view addSubview:self.textFiled];
    [self.textField becomeFirstResponder];
    [self initPwdTextField];
    
    UILabel *tsLable = [JQXCustom creatLabel:CGRectMake(0,64 + 100, SCREEN_WIDTH, 40) backColor:[UIColor clearColor] text:@"您的账户暂未激活，请输入激活码" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter numOnLines:1];
    [self.view addSubview:tsLable];
    
    UIButton *sumbitButton = [JQXCustom creatButton:CGRectMake((SCREEN_WIDTH - 35 *4)/2, self.textFiled.bottom + 50 , 35 *4, 35) backColor:BACKGROUNGCOLOR text:@"确定" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14] addTarget:self Action:@selector(sumbitAction)];
    sumbitButton.layer.masksToBounds = YES;
    sumbitButton.layer.cornerRadius = 5;
    
    [self.view addSubview:sumbitButton];
    
}
#pragma mark - block
- (void)codeText:(ActivationCodeBlock)block
{
    self.myBlock = block;
}
#pragma mark - 确定按钮点击事件
- (void)sumbitAction
{
    [self.view endEditing:YES];
    if(self.textFiled.text.length != 6){
        
        [ALToastView toastInView:self.view withText:@"请输入6位激活码"];
        
    }else{
        [JHHJView showLoadingOnTheKeyWindowWithType:2];
        

        NSDictionary *params = @{@"cdKey":self.textFiled.text,@"merchantId":self.merchantId};
        
        [QJGlobalControl sendPOSTWithUrl:JQXHttp_IsCdKey parameters:params success:^(id data) {
            [JHHJView hideLoading];
            if([data[@"code"]integerValue] == 200){
                if(self.myBlock !=nil){
                    
                    self.myBlock(self.textFiled.text);
                }
                
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
                [ALToastView toastInView:self.view withText:data[@"message"]];
            }
        } fail:^(NSError *error) {
            [JHHJView hideLoading];
            [ALToastView toastInView:self.view withText:@"请求失败"];
        }];
    }
}
#pragma mark - 输入框的分割线以及生成的点
- (void)initPwdTextField
{
    //每个密码输入框的宽度
    CGFloat width = (35*6) / kDotCount;
    
    //生成分割线
    for (int i = 0; i < kDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i + 1) * width, CGRectGetMinY(self.textField.frame), 1, K_Field_Height)];
        lineView.backgroundColor = RGB_COLOR(170, 170, 170);
        [self.view addSubview:lineView];
    }
    
    self.dotArray = [[NSMutableArray alloc] init];
    //生成中间的点
    for (int i = 0; i < kDotCount; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(self.textFiled.left +((self.textFiled.width/6)- kDotSize.width)/2 + i *kDotSize.width + i *(self.textFiled.width/6 - 10),64 + 150 + (self.textFiled.height - kDotSize.width)/2, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //先隐藏
        [self.view addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.dotArray addObject:dotView];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"变化%@", string);
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    }
    else if(textField.text.length >= kDotCount) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}


/**
 *  清除密码
 */
- (void)clearUpPassword
{
    self.textField.text = @"";
    [self textFieldDidChange:self.textField];
}
/**
 *  重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField
{
    
    NSLog(@"%@", textField.text);
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kDotCount) {
        NSLog(@"输入完毕");
    }
}

- (UITextField *)textField
{
    if (!_textFiled) {
        _textFiled = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 35*6)/2, 64 + 150, 35*6, K_Field_Height)];
        _textFiled.backgroundColor = RGB_COLOR(233, 233, 233);
        //输入的文字颜色为白色
        _textFiled.textColor = RGB_COLOR(233, 233, 233);
        //输入框光标的颜色为白色
        _textFiled.tintColor = RGB_COLOR(233, 233, 233);
        _textFiled.delegate = self;
        _textFiled.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textFiled.keyboardType = UIKeyboardTypeNumberPad;
        _textFiled.layer.borderColor = [RGB_COLOR(170, 170, 170) CGColor];
        _textFiled.layer.borderWidth = 1;
        [_textFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textFiled;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
