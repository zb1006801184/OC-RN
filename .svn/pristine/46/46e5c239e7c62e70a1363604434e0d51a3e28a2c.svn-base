//
//  LoginController.m
//  ChongQingPuHui
//
//  Created by 易商通 on 17/3/13.
//  Copyright © 2017年 重庆普惠有限公司. All rights reserved.
//

#import "LoginController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "RegisterPhoneViewController.h"
#import "JQXFindViewController.h"
#import "FindLoginViewController.h"//忘记登录账号
#define TagIndex    10000

@interface LoginController ()
@property (nonatomic,strong)UIImageView *BGimageView;
@property (nonatomic,strong)NSString *phoneStr;
@property (nonatomic,strong)NSString *pwdStr;
@end

@implementation LoginController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setMainUI];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setMainUI];

}
- (void)backButtonAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setMainUI{
    if([self.styleStr isEqualToString:@"修改了登录密码"]){
        [ALToastView toastInView:self.view withText:@"手机号码或者登录密码错误"];
    }
    [self.BGimageView removeFromSuperview];
    //大的背景图
    self.BGimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.BGimageView.backgroundColor = [UIColor whiteColor];
    self.BGimageView.userInteractionEnabled = YES;
    [self.view addSubview:self.BGimageView];
    
    //标题图片
    UIImageView *Loginimage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - SCALE_WIDTH(95) / 2, SCALE_HEIGHT(80), SCALE_WIDTH(95), SCALE_WIDTH(95))];
    Loginimage.image = [UIImage imageNamed:@"LoginImg"];
    [self.BGimageView addSubview:Loginimage];
    
    
    NSArray *placeImageArray = @[@"login_icon_user",@"login_icon_prd"];
    NSArray *placeholderArray = @[@"请输入您的用户名",@"请输入您的密码"];
    
    for (int i = 0; i < placeholderArray.count; i++) {
        
        UIView *bkView = [[UIView alloc]initWithFrame:CGRectMake(50, Loginimage.bottom + 80+i*60, SCREEN_WIDTH - 100, 45)];
        bkView.layer.masksToBounds = YES;
        bkView.layer.cornerRadius = 10;
        bkView.backgroundColor = [UIColor colorWithRed:0.96f green:0.92f blue:0.92f alpha:0.80f];
        [self.BGimageView addSubview:bkView];
        
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, (bkView.height - 23)/2, 20, 23)];
        imageView.image = [UIImage imageNamed:placeImageArray[i]];
        [bkView addSubview:imageView];
        
        UITextField *photoField= [[UITextField alloc]initWithFrame:CGRectMake(imageView.right + 20, 0, bkView.width - 60, bkView.height)];
        photoField.tag = i + TagIndex;
        photoField.placeholder = placeholderArray[i];
        photoField.font = [UIFont systemFontOfSize:14];
        photoField.textColor = [UIColor lightGrayColor];
        [bkView addSubview:photoField];
        
        if(i == 1){
            
            photoField.secureTextEntry = YES;
        }else{
            
            NSString *phoneStr = [[NSUserDefaults standardUserDefaults]objectForKey: LoginPhone];
            photoField.text = phoneStr;
            photoField.keyboardType = UIKeyboardTypeNumberPad;
        }
        
        
    }
    
    //登录按钮
    
    UIButton *loginBtn = [JQXCustom creatButton:CGRectMake(50, Loginimage.bottom + 50+2*60 + 30, SCREEN_WIDTH - 100, 45) backColor:[UIColor colorWithHexString:@"#1a191e"] text:@"登录" textColor:[UIColor whiteColor] font:Font(15) addTarget:self Action:@selector(loinBtnClick:)];
    loginBtn.layer.cornerRadius = 10;
    [self.BGimageView addSubview:loginBtn];
    
//    //注册
//    UILabel *tsLable = [JQXCustom creatLabel:CGRectMake(loginBtn.left, loginBtn.bottom + 5, loginBtn.width/2 + 50, 20) backColor:[UIColor clearColor] text:@"还不是商户？立即注册" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft numOnLines:1];
//    tsLable.attributedText = [self String:tsLable.text RangeString:@"立即注册"];
//    [self.BGimageView addSubview:tsLable];
//
//    UIButton *registerButton = [JQXCustom creatButton:CGRectMake(tsLable.left, loginBtn.bottom + 5, loginBtn.width/2 + 50, 30) backColor:[UIColor clearColor] text:@"" textColor:[UIColor clearColor] font:[UIFont systemFontOfSize:12] addTarget:self Action:@selector(registerAction)];
//    [self.BGimageView addSubview:registerButton];
    
    //忘记登录密码
    UILabel *tsLable3 = [JQXCustom creatLabel:CGRectMake(loginBtn.left, SCREEN_HEIGHT - 60, loginBtn.width/2, 20) backColor:[UIColor clearColor] text:@"忘记登录账号" textColor:[UIColor colorWithHexString:@"#888889"] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft numOnLines:1];
    [self.BGimageView addSubview:tsLable3];
    
    UIButton *findLoginButton = [JQXCustom creatButton:CGRectMake(loginBtn.left, SCREEN_HEIGHT - 70, loginBtn.width/2, 30) backColor:[UIColor clearColor] text:@"" textColor:[UIColor clearColor] font:[UIFont systemFontOfSize:12] addTarget:self Action:@selector(FindLoginAction)];
    [self.BGimageView addSubview:findLoginButton];
    
    //忘记密码
    UILabel *tsLable2 = [JQXCustom creatLabel:CGRectMake(loginBtn.right - loginBtn.width/2, SCREEN_HEIGHT - 60, loginBtn.width/2, 20) backColor:[UIColor clearColor] text:@"忘记密码" textColor:[UIColor colorWithHexString:@"#888889"] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentRight numOnLines:1];
    [self.BGimageView addSubview:tsLable2];
    
    UIButton *findButton = [JQXCustom creatButton:CGRectMake(loginBtn.right - loginBtn.width/2, SCREEN_HEIGHT - 70, loginBtn.width/2, 30) backColor:[UIColor clearColor] text:@"" textColor:[UIColor clearColor] font:[UIFont systemFontOfSize:12] addTarget:self Action:@selector(FindAction)];
    [self.BGimageView addSubview:findButton];
    
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, 30, 30)];
    backImg.image = [UIImage imageNamed:@"JQXbackquan"];
    [self.BGimageView addSubview:backImg];
    
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setFrame:CGRectMake(0, 10, 60, 60)];
    [backBut addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.BGimageView addSubview:backBut];
}
#pragma mark - 登录请求数据
- (void)getLoginData
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    NSDictionary *params = @{@"telphone":self.phoneStr,@"password":self.pwdStr};
    
    
    [QJGlobalControl sendPOSTWithUrl:httpLogin parameters:params success:^(id data) {
        
        [JHHJView hideLoading];
        
        NSLog(@"🍉🍉🍉 %@",data);
        NSString *strrr = data[@"token"];
        [[NSUserDefaults standardUserDefaults]setObject:strrr forKey:LoginToken];
        [[NSUserDefaults standardUserDefaults]synchronize];
        NSString *result=[NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([result isEqual:@"200"]) {
            
            NSString *phone = data[@"data"][@"telphone"];
            NSString *loginID = data[@"data"][@"id"];
            NSString *token = data[@"data"][@"token"];
            NSString *userID = data[@"data"][@"userId"];
            NSString *userName = data[@"data"][@"userName"];
            NSString *profitRatio = data[@"data"][@"profitRatio"];
            NSString *iscdKey = [NSString stringWithFormat:@"%@",NULL_TO_NIL(data[@"data"][@"isCdKey"])];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:LoginStyle];
            [[NSUserDefaults standardUserDefaults]setObject:phone forKey:LoginPhone];
            [[NSUserDefaults standardUserDefaults]setObject:self.pwdStr forKey:LoginPassWord];
            [[NSUserDefaults standardUserDefaults]setObject:loginID forKey:LoginId];
            [[NSUserDefaults standardUserDefaults]setObject:token forKey:LoginToken];
            [[NSUserDefaults standardUserDefaults]setObject:userID forKey:UserID];
            [[NSUserDefaults standardUserDefaults]setObject:userName forKey:UserName];
            [[NSUserDefaults standardUserDefaults]setObject:profitRatio forKey:ProfitRatio];
            [[NSUserDefaults standardUserDefaults]setObject:iscdKey forKey:IsCdKey];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            AppDelegate * app = (AppDelegate*)[UIApplication sharedApplication].delegate;
            [app setHomeRoot];
            
            NSString *aliasStr = [NSString stringWithFormat:@"%@_1",phone];
            [JPUSHService setAlias:aliasStr callbackSelector:nil object:nil];
            //针对某一个特定的用户推送
            
            
        }else{
            
            [ALToastView toastInView:self.view withText:data[@"message"]];
            
        }

        
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];

   

}

#pragma mark - 登录按钮点击事件
-(void)loinBtnClick:(UIButton *)btn{

    [self.view endEditing:YES];
    UITextField *phone = (UITextField *)[self.view viewWithTag:TagIndex];
    UITextField *password = (UITextField *)[self.view viewWithTag:TagIndex + 1];
    if(phone.text.length == 0 ||password.text.length == 0){
        
        [ALToastView toastInView:self.view withText:@"手机号或密码不能为空"];
        
    }else{
        
        self.phoneStr = phone.text;
        self.pwdStr = password.text;
        
        if([self checkPassword:self.pwdStr] == 1){
            [ALToastView toastInView:self.view withText:@"密码不能输入特殊字符"];
            
        }else{
            
            [self getLoginData];
        }
        
        
        
    }
    
}
#pragma mark - 注册按钮点击事件
- (void)registerAction
{
    RegisterPhoneViewController *registerVC = [[RegisterPhoneViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
}
#pragma mark - 忘记密码点击事件
- (void)FindAction
{
    JQXFindViewController *findVC = [[JQXFindViewController alloc]init];
    [self.navigationController pushViewController:findVC animated:YES];
}
#pragma mark - 忘记登录账号点击事件
- (void)FindLoginAction
{
    FindLoginViewController *findVC = [[FindLoginViewController alloc]init];
    [self.navigationController pushViewController:findVC animated:YES];
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


- (NSMutableAttributedString *)String:(NSString *)String RangeString:(NSString *)RangeString
{
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:String];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:RangeString];
    [hintString addAttribute:NSForegroundColorAttributeName value:BACKGROUNGCOLOR range:range1];
    
    return hintString;
}

@end
