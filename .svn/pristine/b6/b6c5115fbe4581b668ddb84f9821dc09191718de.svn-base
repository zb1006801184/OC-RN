//
//  JQXFindViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/24.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "JQXFindViewController.h"
#import "JKCountDownButton.h"
@interface JQXFindViewController ()

@property (nonatomic,strong)UITextField *phoneText;
@property (nonatomic,strong)UITextField *pwdText;
@property (nonatomic,strong)UITextField *pwdAgainText;
@property (nonatomic,strong)UITextField *codeText;
@property (nonatomic,strong)JKCountDownButton *numButton;

@end

@implementation JQXFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"找回密码" isBack:YES];
    [self setUI];
}
- (void)setUI
{
   
    //手机号
    UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(30, TOPALLHeight + 20, SCREEN_WIDTH - 60, 45)];
    phoneView.layer.borderWidth = 1;
    phoneView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.view addSubview:phoneView];
    
    UILabel *tsPLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, phoneView.height)];
    tsPLabel.text = @"登录账号";
    tsPLabel.font = [UIFont systemFontOfSize:14];
    [phoneView addSubview:tsPLabel];
    
    self.phoneText = [[UITextField alloc]initWithFrame:CGRectMake(tsPLabel.right + 10, 0, phoneView.width - tsPLabel.width - 30, phoneView.height)];
    self.phoneText.textAlignment = NSTextAlignmentRight;
    self.phoneText.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneText.placeholder = @"请点击输入您的登录帐号";
    self.phoneText.font = [UIFont systemFontOfSize:13];
    [phoneView addSubview:self.phoneText];

    
    //新密码
    UIView *pwdView = [[UIView alloc]initWithFrame:CGRectMake(30, phoneView.bottom + 10, SCREEN_WIDTH - 60, 45)];
    pwdView.layer.borderWidth = 1;
    pwdView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.view addSubview:pwdView];
    
    UILabel *tsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, pwdView.height)];
    tsLabel.text = @"新密码";
    tsLabel.font = [UIFont systemFontOfSize:14];
    [pwdView addSubview:tsLabel];
    
    self.pwdText = [[UITextField alloc]initWithFrame:CGRectMake(tsLabel.right + 10, 0, pwdView.width - tsLabel.width - 30, pwdView.height)];
    self.pwdText.textAlignment = NSTextAlignmentRight;
    self.pwdText.secureTextEntry = YES;
    self.pwdText.placeholder = @"请点击输入新密码";
    self.pwdText.font = [UIFont systemFontOfSize:13];
    [pwdView addSubview:self.pwdText];
    
    //确认密码
    UIView *againView = [[UIView alloc]initWithFrame:CGRectMake(30, pwdView.bottom + 10, SCREEN_WIDTH - 60, 45)];
    againView.layer.borderWidth = 1;
    againView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.view addSubview:againView];
    
    UILabel *tsLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, againView.height)];
    tsLabel2.text = @"确认密码";
    tsLabel2.font = [UIFont systemFontOfSize:14];
    [againView addSubview:tsLabel2];
    
    self.pwdAgainText = [[UITextField alloc]initWithFrame:CGRectMake(tsLabel.right + 10, 0, againView.width - tsLabel2.width - 30, againView.height)];
    self.pwdAgainText.textAlignment = NSTextAlignmentRight;
    self.pwdAgainText.font = [UIFont systemFontOfSize:13];
    self.pwdAgainText.secureTextEntry = YES;
    self.pwdAgainText.placeholder = @"请再次输入新密码";
    [againView addSubview:self.pwdAgainText];
    
    //验证码
    UIView *codeView = [[UIView alloc]initWithFrame:CGRectMake(30, againView.bottom + 10, SCREEN_WIDTH - 150, 45)];
    codeView.layer.borderWidth = 1;
    codeView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.view addSubview:codeView];
    
    self.codeText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, codeView.width - 20, againView.height)];
    self.codeText.keyboardType = UIKeyboardTypeNumberPad;
    self.codeText.font = [UIFont systemFontOfSize:13];
    self.codeText.placeholder = @"请输入手机验证码";
    [codeView addSubview:self.codeText];
    
    self.numButton = [[JKCountDownButton alloc]initWithFrame:CGRectMake(codeView.right + 10, againView.bottom + 12.5 , againView.width - codeView.width - 10, 40)];
    self.numButton.backgroundColor = BACKGROUNGCOLOR;
    self.numButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.numButton.layer.masksToBounds = YES;
    self.numButton.layer.cornerRadius = 5;
    [self.numButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.numButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.numButton addTarget:self action:@selector(numAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.numButton];
    
    
    UIButton *sumbitButton = [[UIButton alloc]initWithFrame:CGRectMake(60, codeView.bottom + 20 , SCREEN_WIDTH - 120, 40)];
    sumbitButton.backgroundColor = BACKGROUNGCOLOR;
    sumbitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    sumbitButton.layer.masksToBounds = YES;
    sumbitButton.layer.cornerRadius = 5;
    [sumbitButton setTitle:@"立即找回" forState:UIControlStateNormal];
    [sumbitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sumbitButton addTarget:self action:@selector(sumbitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sumbitButton];
    

//    UILabel *tsLable = [JQXCustom creatLabel:CGRectMake(sumbitButton.left, sumbitButton.bottom + 5, sumbitButton.width/2, 20) backColor:[UIColor clearColor] text:@"返回登录界面" textColor:BACKGROUNGCOLOR font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft numOnLines:1];
//    [self.view addSubview:tsLable];
//
//    UIButton *registerButton = [JQXCustom creatButton:CGRectMake(tsLable.left, sumbitButton.bottom + 5, sumbitButton.width/2, 30) backColor:[UIColor clearColor] text:@"" textColor:[UIColor clearColor] font:[UIFont systemFontOfSize:12] addTarget:self Action:@selector(PopAction)];
//    [self.view addSubview:registerButton];
    
}
#pragma mark  - 短信验证码
- (void)numAction:(JKCountDownButton *)sender
{
    [self.view endEditing:YES];
    
    if(self.phoneText.text.length == 11 ||self.phoneText.text.length == 13){
        
        NSString *url = [NSString stringWithFormat:@"%@/%@/%@/%@",http_CodeURL,self.phoneText.text,@"Fr170001",@"2"];
        
        [QJGlobalControl sendGETWithUrl:url parameters:nil success:^(id data) {
            if([data[@"code"]integerValue] == 200){
                [ALToastView toastInView:self.view withText:@"发送验证码成功"];
                
                sender.enabled = NO;
                
                [sender startWithSecond:60];

                [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                    
                    sender.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f];
                    sender.layer.borderColor = [UIColor lightGrayColor].CGColor;
                    NSString *title = [NSString stringWithFormat:@"%d秒",second];
                    [countDownButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    return title;
                    
                }];
                
                [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                    
                    sender.backgroundColor = BACKGROUNGCOLOR;
                    countDownButton.enabled = YES;
                    
                    [countDownButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                
                    return @"重新获取";
                    
                }];
                
            }else{
            
                [ALToastView toastInView:self.view withText:data[@"message"]];
            }
        } fail:^(NSError *error) {
             [ALToastView toastInView:self.view withText:@"请求失败"];
        }];
        
    }else{
        [ALToastView toastInView:self.view withText:@"请输入正确登录帐号"];
    }
    
    
}
#pragma mark - 立即找回
- (void)sumbitAction
{
    [self.view endEditing:YES];
    
    if(self.phoneText.text.length == 0 || self.codeText.text.length == 0 || self.pwdText.text.length == 0 ||self.pwdAgainText.text.length == 0){
        
        [ALToastView toastInView:self.view withText:@"信息不完整"];

    }else{
        
        if([self checkPassword:self.pwdText.text] == 1 && [self checkPassword:self.pwdAgainText.text] == 1 ){
            
            [ALToastView toastInView:self.view withText:@"密码不能输入特殊字符"];
            
        }else{
            
            [self FindPwdData];
        }
   
    }
}


- (void)FindPwdData
{
    if([self.pwdText.text isEqualToString:self.pwdAgainText.text]){
        
        NSDictionary *params = @{@"merchantPhone":self.phoneText.text,@"password":self.pwdText.text,@"verificationCode":self.codeText.text,@"type":@"Fr10002"};
        
        [QJGlobalControl sendPOSTWithUrl:http_FindPwdURL parameters:params success:^(id data) {
            NSLog(@"data == %@",data);
            if([data[@"code"]integerValue] == 200){
                
                [ALToastView toastInView:self.view withText:@"找回密码成功"];
                
                dispatch_time_t delayTime = dispatch_time
                (DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
                
                dispatch_after
                (delayTime, dispatch_get_main_queue(),
                 ^{
                     [self.navigationController popViewControllerAnimated:YES];
                     
                 }
                 );
                
            }else{
                [ALToastView toastInView:self.view withText:data[@"message"]];
            }
        } fail:^(NSError *error) {
            [ALToastView toastInView:self.view withText:@"请求失败"];
        }];
        
    }else{
        [ALToastView toastInView:self.view withText:@"两次密码不一致"];
    }

}
#pragma mark - 返回登录界面
- (void)PopAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 判断密码
- (BOOL)checkPassword:(NSString *) password
{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:password]) {
        return YES;
    }
    return NO;
    
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
