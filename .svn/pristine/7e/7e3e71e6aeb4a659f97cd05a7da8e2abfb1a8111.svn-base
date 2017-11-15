//
//  LoginPwdViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "LoginPwdViewController.h"
#import "JKCountDownButton.h"
#import "LoginController.h"
@interface LoginPwdViewController ()<UITextFieldDelegate>
{
    NSString *type;//短信类型
}
@property (nonatomic,strong)UITextField *pwdText;
@property (nonatomic,strong)UITextField *pwdAgainText;
@property (nonatomic,strong)UITextField *codeText;
@property (nonatomic,strong)JKCountDownButton *numButton;
@end

@implementation LoginPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:self.styleStr isBack:YES];
    /*
     **
     *  styleStr 有两种状态 修改支付密码，修改登录密码
     **
     */
    
    
    type = @"";
    
    if([self.styleStr isEqualToString:@"设置支付密码"]){
       
        type = @"2";//设置支付密码
        
    }else if ([self.styleStr isEqualToString:@"修改支付密码"]){
        
       type = @"3";//修改支付密码
        
        
    }else if ([self.styleStr isEqualToString:@"修改登录密码"]){
        type = @"1";
    }
    
    UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, 60)];
    bigView.backgroundColor = BACKGrayColor;
    [self.view addSubview:bigView];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 40)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [bigView addSubview:whiteView];
    
    //账号
    UILabel *telLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, whiteView.width, whiteView.height)];
    NSString *telStr = [[NSUserDefaults standardUserDefaults]objectForKey:LoginPhone];
    if(telStr.length == 11 || telStr.length == 13){
        telStr = [NSString stringWithFormat:@"%@****%@",[telStr substringToIndex:3],[telStr substringFromIndex:7]];
    }
    telLabel.text = [NSString stringWithFormat:@"账户：%@",telStr];
    telLabel.font = [UIFont systemFontOfSize:14];
    [whiteView addSubview:telLabel];
    
    //新密码
    UIView *pwdView = [[UIView alloc]initWithFrame:CGRectMake(30, bigView.bottom + 10, SCREEN_WIDTH - 60, 45)];
    pwdView.layer.borderWidth = 1.5;
    pwdView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.view addSubview:pwdView];
    
    UILabel *tsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, pwdView.height)];
    tsLabel.text = @"新密码";
    tsLabel.font = [UIFont systemFontOfSize:14];
    [pwdView addSubview:tsLabel];
    
    self.pwdText = [[UITextField alloc]initWithFrame:CGRectMake(tsLabel.right + 10, 0, pwdView.width - tsLabel.width - 30, pwdView.height)];
    self.pwdText.textAlignment = NSTextAlignmentRight;
    self.pwdText.secureTextEntry = YES;
    self.pwdText.delegate = self;
    self.pwdText.placeholder = @"请点击输入新密码";
    self.pwdText.font = [UIFont systemFontOfSize:13];
    [pwdView addSubview:self.pwdText];
    
    //确认密码
    UIView *againView = [[UIView alloc]initWithFrame:CGRectMake(30, pwdView.bottom + 10, SCREEN_WIDTH - 60, 45)];
    againView.layer.borderWidth = 1.5;
    againView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.view addSubview:againView];
    
    UILabel *tsLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, againView.height)];
    tsLabel2.text = @"确认密码";
    tsLabel2.font = [UIFont systemFontOfSize:14];
    [againView addSubview:tsLabel2];
    
    self.pwdAgainText = [[UITextField alloc]initWithFrame:CGRectMake(tsLabel.right + 10, 0, againView.width - tsLabel2.width - 30, againView.height)];
    self.pwdAgainText.textAlignment = NSTextAlignmentRight;
    self.pwdAgainText.secureTextEntry = YES;
    self.pwdAgainText.delegate = self;
    self.pwdAgainText.font = [UIFont systemFontOfSize:13];
    self.pwdAgainText.placeholder = @"请再次输入新密码";
    [againView addSubview:self.pwdAgainText];
    
    self.pwdText.keyboardType = UIKeyboardTypeNumberPad;
    self.pwdAgainText.keyboardType = UIKeyboardTypeNumberPad;
    [self.pwdText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwdAgainText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    
    //验证码
    UIView *codeView = [[UIView alloc]initWithFrame:CGRectMake(30, againView.bottom + 10, SCREEN_WIDTH - 150, 45)];
    codeView.layer.borderWidth = 1.5;
    codeView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.view addSubview:codeView];
    
    self.codeText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, codeView.width - 20, againView.height)];
    self.codeText.keyboardType = UIKeyboardTypeNumberPad;
    self.codeText.font = [UIFont systemFontOfSize:13];
    self.codeText.placeholder = @"请输入手机验证码";
    self.codeText.delegate = self;
    [self.codeText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
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
    [sumbitButton setTitle:@"修     改" forState:UIControlStateNormal];
    [sumbitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sumbitButton addTarget:self action:@selector(sumbitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sumbitButton];
    
   
    
}

#pragma mark  - 短信验证码
- (void)numAction:(JKCountDownButton *)sender
{
    [self.view endEditing:YES];
    
    NSString *telStr = [[NSUserDefaults standardUserDefaults]objectForKey:LoginPhone];
    
//    NSDictionary *params = @{@"phone":telStr,@"type":type};
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@",JQXHttp_PayOnCode,telStr,type];
    [QJGlobalControl sendPOSTWithUrl:url parameters:nil success:^(id data) {
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
    
    
}

#pragma mark - 修改
- (void)sumbitAction
{
    [self.view endEditing:YES];
    
    if(self.pwdText.text.length == 0 && self.pwdAgainText.text.length == 0 && self.codeText.text.length == 0){
        [ALToastView toastInView:self.view withText:@"信息不全，请补充"];
    }else{
        if(![self.pwdText.text isEqualToString:self.pwdAgainText.text]){
            [ALToastView toastInView:self.view withText:@"两次密码不一致，请重新输入"];
        }else{
            //判断全是空格
            if([[self.pwdText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0 || [[self.pwdAgainText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0 || [[self.codeText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0){
                [ALToastView toastInView:self.view withText:@"请输入正确信息"];
            }else{
                BOOL special = [QJGlobalControl isIncludeSpecialCharact:self.pwdText.text];
                BOOL special1 = [QJGlobalControl isIncludeSpecialCharact:self.pwdAgainText.text];
                BOOL special2 = [QJGlobalControl isIncludeSpecialCharact:self.codeText.text];
                
                if(special ||special1 ||special2){
                    [ALToastView toastInView:self.view withText:@"不可以输入特殊字符"];
                }else{
                    [self setUpdatePwd];
                }
            }
        }
    }
    

}
#pragma mark - 请求数据
- (void)setUpdatePwd
{
    NSString *telStr = [[NSUserDefaults standardUserDefaults]objectForKey:LoginPhone];
    NSString *url = @"";
    NSDictionary *params = [NSDictionary dictionary];
    if([self.styleStr isEqualToString:@"修改登录密码"]){
        if(self.pwdText.text.length >= 6 && self.pwdText.text.length <= 16){
            url = http_FindPwdURL;
            params = @{@"merchantPhone":telStr,@"password":self.pwdText.text,@"verificationCode":self.codeText.text,@"type":@"Fr170002"};
            
        }else{
            [ALToastView toastInView:self.view withText:@"请输入6~16位登录密码"];
            return;
        }
        
    }else{
        if(self.pwdText.text.length != 6 && self.pwdAgainText.text.length != 6){
            [ALToastView toastInView:self.view withText:@"请输入6位支付密码"];
            return;
        }else{
            if([self.payPwdStr isEqualToString:@"设置了支付密码"]){
                url = http_UpdatePayPwd;
            }else{
                url = http_SetPayPwd;
            }
            
            
            params = @{@"merchantPhone":telStr,@"password":self.pwdText.text,@"verificationCode":self.codeText.text,@"type":@"Fr170002"};
        }
    }
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendPOSTWithUrl:url parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data ====%@",data);
        if([data[@"code"]integerValue] == 200){
            [ALToastView toastInView:self.view withText:data[@"message"]];
            if([self.styleStr isEqualToString:@"修改登录密码"]){
                
                
                dispatch_time_t delayTime = dispatch_time
                (DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
                
                dispatch_after
                (delayTime, dispatch_get_main_queue(),
                 ^{
                     LoginController *mainVC = [[LoginController alloc]init];
                     UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainVC];
                     [self presentViewController:nav animated:YES completion:nil];
                     
                 }
                 );
                
            }else{
                dispatch_time_t delayTime = dispatch_time
                (DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
                
                dispatch_after
                (delayTime, dispatch_get_main_queue(),
                 ^{
                     [self.navigationController popViewControllerAnimated:YES];
                     
                 }
                 );
            }
            
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}
- (void)TextChange:(UITextField *)textFiled
{
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textFiled.text options:0 range:NSMakeRange(0, textFiled.text.length) withTemplate:@""];
    
    
    if (![noEmojiStr isEqualToString:textFiled.text]) {
        
        textFiled.text = noEmojiStr;
        
    }
    if([self.styleStr isEqualToString:@"修改支付密码"] ||[self.styleStr isEqualToString:@"设置支付密码"]){
        if(textFiled == self.pwdText || textFiled == self.pwdAgainText){
            if(textFiled.text.length >6){
                [self.view endEditing:YES];
                NSString *str = textFiled.text;
                textFiled.text = [str substringToIndex:6];
                [ALToastView toastInView:self.view withText:@"支付密码只能输入6位"];
            }
        }
    }
}


//不能输入表情
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //不支持系统表情的输入
    if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    return YES;
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
