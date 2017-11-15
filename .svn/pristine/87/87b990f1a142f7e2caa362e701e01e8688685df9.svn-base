//
//  RegisterPhoneViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/22.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "RegisterPhoneViewController.h"
#import "RegisterView.h"
#import "JKCountDownButton.h"
#import "RegisterAddressViewController.h"
@interface RegisterPhoneViewController ()
@property (nonatomic,strong)UITextField *phoneText;//手机号
@property (nonatomic,strong)UITextField *codeText;//短信验证码
@property (nonatomic,strong)UITextField *pwdText;//密码
@property (nonatomic,strong)NSMutableDictionary *registerDic;
@property (nonatomic,strong)JKCountDownButton *numButton;//获取验证码按钮
@property (nonatomic,strong)UIView *markView;
@property (nonatomic,strong)NSArray *shopArray;
@property (nonatomic,strong)NSDictionary *mainDic;
@end

@implementation RegisterPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"申请商户" isBack:YES];
    
    //手机号
    RegisterView *phoneView = [[RegisterView alloc]initWithFrame:CGRectMake(20,TOPALLHeight + 20, SCREEN_WIDTH - 40, 45)];
    phoneView.tsLabel.text = @"手机号";
    [self.view addSubview:phoneView];
    
    self.phoneText = [JQXCustom creatTextFiled:CGRectMake(70, 0, phoneView.width - 90 - 10, phoneView.height) placeholder:@"请点击输入您的手机号(必填)"];
    self.phoneText.keyboardType = UIKeyboardTypeNumberPad;
    [phoneView addSubview:self.phoneText];
    
    //验证码
    UIView *codeView = [[UIView alloc]initWithFrame:CGRectMake(20, phoneView.bottom + 10, SCREEN_WIDTH - 150, 45)];
    codeView.layer.borderWidth = 1.5;
    codeView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.view addSubview:codeView];
    
    self.codeText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, codeView.width - 20, codeView.height)];
    self.codeText.keyboardType = UIKeyboardTypeNumberPad;
    self.codeText.font = [UIFont systemFontOfSize:13];
    self.codeText.placeholder = @"请输入手机验证码";
    [codeView addSubview:self.codeText];
    
    self.numButton = [[JKCountDownButton alloc]initWithFrame:CGRectMake(codeView.right + 10, phoneView.bottom + 12.5 , phoneView.width - codeView.width - 10, 40)];
    self.numButton.backgroundColor = BACKGROUNGCOLOR;
    self.numButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.numButton.layer.masksToBounds = YES;
    self.numButton.layer.cornerRadius = 5;
    [self.numButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.numButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.numButton addTarget:self action:@selector(numAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.numButton];
    
    //密码
    RegisterView *pwdView = [[RegisterView alloc]initWithFrame:CGRectMake(20,codeView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    pwdView.tsLabel.text = @"密码";
    [self.view addSubview:pwdView];
    
    self.pwdText = [JQXCustom creatTextFiled:CGRectMake(70, 0, phoneView.width - 90 - 10, phoneView.height) placeholder:@"请设置密码"];
//    self.pwdText.keyboardType = 
    self.pwdText.secureTextEntry = YES;
    [pwdView addSubview:self.pwdText];
    
    //前面小星星
    for (int i = 0; i < 3; i ++) {
        UILabel *xingLabel = [JQXCustom creatLabel:CGRectMake(0,64 + 20+ i *45 + i * 10, 20, 45) backColor:[UIColor clearColor] text:@"*" textColor:BACKGROUNGCOLOR font:Font(13) textAlignment:NSTextAlignmentCenter numOnLines:1];
        [self.view addSubview:xingLabel];
    }
    
    
    UIButton *sumbitButton = [JQXCustom creatButton:CGRectMake(60, pwdView.bottom + 50 , SCREEN_WIDTH - 120, 40) backColor:BACKGROUNGCOLOR text:@"下一步" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14] addTarget:self Action:@selector(sumbitAction)];
    sumbitButton.layer.masksToBounds = YES;
    sumbitButton.layer.cornerRadius = 5;
    
    [self.view addSubview:sumbitButton];

}

#pragma mark  - 短信验证码
- (void)numAction:(JKCountDownButton *)sender
{
    [self.view endEditing:YES];
    
    if(self.phoneText.text.length == 11){
        
        [JHHJView showLoadingOnTheKeyWindowWithType:2];
        NSString *url = [NSString stringWithFormat:@"%@/%@/%@/%@",http_CodeURL,self.phoneText.text,@"Fr170001",@"1"];
        [QJGlobalControl sendGETWithUrl:url parameters:nil success:^(id data) {
            [JHHJView hideLoading];
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
            [JHHJView hideLoading];
            [ALToastView toastInView:self.view withText:@"请求失败"];
        }];
        
        
        
    }else{
        [ALToastView toastInView:self.view withText:@"请输入正确手机号"];
    }
    
}
#pragma mark - 下一步
- (void)sumbitAction
{
    [self.view endEditing:YES];
    if(self.phoneText.text.length != 11 || self.codeText.text.length != 6 || self.pwdText.text.length == 0){
        [ALToastView toastInView:self.view withText:@"信息不全，请补充"];
    }else{

        if([self checkPassword:self.pwdText.text] == 1){
            [ALToastView toastInView:self.view withText:@"密码不能输入特殊字符"];

        }else{
            
            //验证手机号注册信息
            [JHHJView showLoadingOnTheKeyWindowWithType:2];
            NSDictionary *params = @{@"phone":self.phoneText.text};
            [QJGlobalControl sendPOSTWithUrl:JQXHttp_PhoneMessage parameters:params success:^(id data) {
                [JHHJView hideLoading];
                if([data[@"code"]integerValue] == 200){
                    NSDictionary *dic = data[@"data"];
                    if([dic isEqual:[NSNull null]]){ //初始化
                        [[NSUserDefaults standardUserDefaults]setObject:self.phoneText.text forKey:LoginRegistphone];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        [self NewShopAction];
                    }else{
                        NSString *registphone = [NSString stringWithFormat:@"%@",data[@"data"][@"registphone"]];
                        [[NSUserDefaults standardUserDefaults]setObject:registphone forKey:LoginRegistphone];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        self.shopArray = data[@"data"][@"list"];
                        self.mainDic = [self.shopArray objectAtIndex:0];
                        [self setMarkUI];
                    }
                    
                }else{
                    
                    [ALToastView toastInView:self.view withText:data[@"message"]];
                }
            } fail:^(NSError *error) {
                [JHHJView hideLoading];
                [ALToastView toastInView:self.view withText:@"请求失败"];
            }];
            
           

        }
    }

}
- (NSMutableDictionary *)registerDic
{
    if(!_registerDic){
        _registerDic = [NSMutableDictionary dictionary];
    }
    return _registerDic;
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
#pragma mark - 已经开通了店铺
- (void)setMarkUI{
    
    self.markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.markView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    [self.view addSubview:self.markView];
    
    UIView *tsView = [[UIView alloc]initWithFrame:CGRectMake(30, SCALE_HEIGHT(150), SCREEN_WIDTH - 60, SCALE_HEIGHT(150))];
    tsView.backgroundColor = [UIColor whiteColor];
    [self.markView addSubview:tsView];
    
    NSString *tsStr = @"您已经使用该手机开通了如下店铺账号，您可以使用如下账号直接登录或者开通新的店铺：";
    CGFloat tsH = [tsStr CallateLabelSizeHeight:Font(15) lineWidth:tsView.width - 30];
    UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(15, 20, tsView.width - 30, tsH) backColor:[UIColor clearColor] text:tsStr textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentLeft numOnLines:0];
    [tsView addSubview:tsLabel];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(30, tsLabel.bottom + 10, tsView.width - 60, 60)];
    scrollView.contentSize = CGSizeMake(tsView.width - 60, 30 *self.shopArray.count);
    [tsView addSubview:scrollView];
    
    
    UIButton *sureButton = [JQXCustom creatButton:CGRectMake((tsView.width - 80*2 - 40)/2, scrollView.bottom + 20, 80, 40) backColor:BACKGROUNGCOLOR text:@"去登录" textColor:[UIColor whiteColor] font:Font(13) addTarget:self Action:@selector(LoginAction)];
    sureButton.layer.masksToBounds = YES;
    sureButton.layer.cornerRadius = 8;
    [tsView addSubview:sureButton];
    
    UIButton *newShopButton = [JQXCustom creatButton:CGRectMake(sureButton.right + 40, scrollView.bottom + 20, 80, 40) backColor:BACKGROUNGCOLOR text:@"开通新店铺" textColor:[UIColor whiteColor] font:Font(13) addTarget:self Action:@selector(NewShopAction)];
    newShopButton.layer.masksToBounds = YES;
    newShopButton.layer.cornerRadius = 8;
    [tsView addSubview:newShopButton];
    
    for (int i = 0; i < self.shopArray.count; i ++) {
        NSDictionary *dic = [self.shopArray objectAtIndex:i];
        UIView *smallView = [[UIView alloc]initWithFrame:CGRectMake(0, i *30, scrollView.width, 30)];
        [scrollView addSubview:smallView];
        
        UIButton *button = [JQXCustom creatButton:CGRectMake(0, 0, 30, 30) backColor:[UIColor clearColor] text:@"" textColor:[UIColor whiteColor] font:Font(13) addTarget:self Action:@selector(buttonAction:)];
        button.tag = 100 + i;
        [button setImage:[UIImage imageNamed:@"radio_unchecked"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"radio_checked"] forState:UIControlStateSelected];
        [smallView addSubview:button];
        if(i == 0){
            button.selected = YES;
        }
        NSString *telStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"telPhone"])];
        UILabel *telLabel = [JQXCustom creatLabel:CGRectMake(button.right + 5, 0, scrollView.width - 35, 30) backColor:[UIColor clearColor] text:telStr textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:0];
        [smallView addSubview:telLabel];
        
        NSString *companyStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"merchantName"])];
        UILabel *companyLabel = [JQXCustom creatLabel:CGRectMake(scrollView.width - 90, 0, 90, 30) backColor:[UIColor clearColor] text:companyStr textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:0];
        [smallView addSubview:companyLabel];
        
    }
    
    
    [tsView setHeight:newShopButton.bottom + 20];
    
}
#pragma mark - 去登录
- (void)LoginAction
{
    [self.markView removeFromSuperview];
    NSString *telPhone = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.mainDic[@"telPhone"])];
    [[NSUserDefaults standardUserDefaults]setObject:telPhone forKey:LoginPhone];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}
#pragma mark - 开通新店铺
- (void)NewShopAction
{
    [self.markView removeFromSuperview];
    NSString *phoneText = [[NSUserDefaults standardUserDefaults] objectForKey:LoginRegistphone];
    [self.registerDic setValue:phoneText forKey:@"telPhone"];
    [self.registerDic setValue:self.codeText.text forKey:@"verificationCode"];
    [self.registerDic setValue:self.pwdText.text forKey:@"password"];

    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSDictionary *params = @{@"telPhone":self.phoneText.text,@"verificationCode":self.codeText.text,@"password":self.pwdText.text};
    [QJGlobalControl sendPOSTWithUrl:JQXHttp_RegisterPhone parameters:params success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"]integerValue] == 1){
            RegisterAddressViewController *vc = [[RegisterAddressViewController alloc]init];
            vc.registerDic = self.registerDic;
            [self.navigationController pushViewController:vc animated:YES];

        }else{

            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];


}
- (void)buttonAction:(UIButton *)sender
{
    
    UIButton *button = [UIButton new];
    
    for (int i = 0; i < self.shopArray.count; i++) {
        
        button = [self.view viewWithTag:100 + i];
        
        if (button.tag == sender.tag) {
            
            button.selected = YES;
            
        }else{
            
            button.selected = NO;
            
        }
        
        
    }
    self.mainDic = [self.shopArray objectAtIndex:sender.tag - 100];
    NSString *registphone = [NSString stringWithFormat:@"%@",self.mainDic[@"telPhone"]];
    [[NSUserDefaults standardUserDefaults]setObject:registphone forKey:LoginRegistphone];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}
- (NSArray *)shopArray
{
    if(!_shopArray){
        _shopArray  = [NSArray array];
    }
    return _shopArray;
}
- (NSDictionary *)mainDic
{
    if(!_mainDic){
        _mainDic = [NSDictionary dictionary];
    }
    return _mainDic;
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
