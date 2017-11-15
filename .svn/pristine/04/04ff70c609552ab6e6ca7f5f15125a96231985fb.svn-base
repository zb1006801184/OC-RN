//
//  FindLoginViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/9/25.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "FindLoginViewController.h"
#import "ReserveView.h"
#import "JKCountDownButton.h"
@interface FindLoginViewController ()
@property (nonatomic,strong)UITextField *phoneText;
@property (nonatomic,strong)UITextField *codeText;
@property (nonatomic,strong)JKCountDownButton *numButton;
@property (nonatomic,strong)UIView *markView;
@property (nonatomic,strong)NSArray *shopArray;
@end

@implementation FindLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"找回账号" isBack:YES];
    //手机号
    RegisterView *phoneView = [[RegisterView alloc]initWithFrame:CGRectMake(20, TOPALLHeight + 20, SCREEN_WIDTH - 40, 45)];
    phoneView.tsLabel.text = @"手机号";
    [self.view addSubview:phoneView];
    
    self.phoneText = [JQXCustom creatTextFiled:CGRectMake(90, 0, phoneView.width - 90 - 10, phoneView.height) placeholder:@"请点击输入您的手机号"];
    self.phoneText.textAlignment = NSTextAlignmentRight;
    self.phoneText.keyboardType = UIKeyboardTypeNumberPad;
    [phoneView addSubview:self.phoneText];
    
    //验证码
    UIView *codeView = [[UIView alloc]initWithFrame:CGRectMake(20, phoneView.bottom + 10, SCREEN_WIDTH - 150, 45)];
    codeView.layer.borderWidth = 1;
    codeView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.view addSubview:codeView];
    
    self.codeText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, codeView.width - 20, phoneView.height)];
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
    
    
    UIButton *sumbitButton = [JQXCustom creatButton:CGRectMake(60, codeView.bottom + 20 , SCREEN_WIDTH - 120, 40) backColor:BACKGROUNGCOLOR text:@"立即找回" textColor:[UIColor whiteColor] font:Font(15) addTarget:self Action:@selector(sumbitAction)];
    sumbitButton.layer.masksToBounds = YES;
    sumbitButton.layer.cornerRadius = 5;

    [self.view addSubview:sumbitButton];
    
}

#pragma mark  - 短信验证码
- (void)numAction:(JKCountDownButton *)sender
{
    [self.view endEditing:YES];
    
    if(self.phoneText.text.length == 11){
        
        NSString *url = [NSString stringWithFormat:@"%@/%@/%@",JQXHttp_PayOnCode,self.phoneText.text,@"5"];
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
        
        
        
    }else{
        [ALToastView toastInView:self.view withText:@"请输入正确手机号"];
    }
    
    
}
#pragma mark - 立即找回
- (void)sumbitAction
{
    [self.view endEditing:YES];
    
    if(self.phoneText.text.length == 0 || self.codeText.text.length == 0){

        [ALToastView toastInView:self.view withText:@"信息不完整，请填充"];

    }else{
        //注册的账号
        
        [JHHJView showLoadingOnTheKeyWindowWithType:2];
        NSDictionary *params = @{@"merchantPhone":self.phoneText.text,@"verificationCode":self.codeText.text};
        [QJGlobalControl sendPOSTWithUrl:JQXHttp_PhoneCount parameters:params success:^(id data) {
            [JHHJView hideLoading];
            if([data[@"code"]integerValue] == 200){
//                NSString *registphone = [NSString stringWithFormat:@"%@",data[@"data"][@"registphone"]];
//                [[NSUserDefaults standardUserDefaults]setObject:registphone forKey:LoginRegistphone];
//                [[NSUserDefaults standardUserDefaults]synchronize];
                
                self.shopArray = data[@"data"];
                
                [self setMarkUI];
                
            }else{
                
                [ALToastView toastInView:self.view withText:data[@"message"]];
            }
        } fail:^(NSError *error) {
            [JHHJView hideLoading];
            [ALToastView toastInView:self.view withText:@"请求失败"];
        }];
        
    }
}

- (void)setMarkUI
{
    
    self.markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.markView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    [self.view addSubview:self.markView];

    UIView *tsView = [[UIView alloc]initWithFrame:CGRectMake(30, SCALE_HEIGHT(150), SCREEN_WIDTH - 60, SCALE_HEIGHT(150))];
    tsView.backgroundColor = [UIColor whiteColor];
    [self.markView addSubview:tsView];

    UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(15, 0, tsView.width - 30, 50) backColor:[UIColor clearColor] text:@"您已注册的账号" textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentCenter numOnLines:0];
    [tsView addSubview:tsLabel];

    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, tsLabel.bottom, tsView.width, 100)];
    scrollView.layer.borderWidth = 1;
    scrollView.layer.borderColor = RGB_COLOR(221, 221, 221).CGColor;
    scrollView.contentSize = CGSizeMake(tsView.width - 60, 50 *self.shopArray.count);
    [tsView addSubview:scrollView];


    UIButton *sureButton = [JQXCustom creatButton:CGRectMake((tsView.width - 80)/2, scrollView.bottom + 10, 80, 40) backColor:BACKGROUNGCOLOR text:@"确定" textColor:[UIColor whiteColor] font:Font(13) addTarget:self Action:@selector(SureAction)];
    sureButton.layer.masksToBounds = YES;
    sureButton.layer.cornerRadius = 8;
    [tsView addSubview:sureButton];


    for (int i = 0; i < self.shopArray.count; i ++) {
        NSDictionary *dic = [self.shopArray objectAtIndex:i];
        UIView *smallView = [[UIView alloc]initWithFrame:CGRectMake(0, i *50, scrollView.width, 50)];
        [scrollView addSubview:smallView];

        NSString *telStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"telPhone"])];
        UILabel *telLabel = [JQXCustom creatLabel:CGRectMake(50, 0, scrollView.width - 35, 50) backColor:[UIColor clearColor] text:telStr textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:0];
        [smallView addSubview:telLabel];

        NSString *companyStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"merchantName"])];
        UILabel *companyLabel = [JQXCustom creatLabel:CGRectMake(scrollView.width - 90, 0, 90, 50) backColor:[UIColor clearColor] text:companyStr textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:0];
        [smallView addSubview:companyLabel];
        if(i != self.shopArray.count - 1){
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, smallView.width, 1)];
            lineView.backgroundColor = RGB_COLOR(221, 221, 221);
            [smallView addSubview:lineView];
        }
        
    }

    [tsView setHeight:sureButton.bottom + 10];

    
}
#pragma mark - 确定按钮点击事件
- (void)SureAction
{
    [self.markView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)shopArray
{
    if(!_shopArray){
        _shopArray = [NSArray array];
    }
    return _shopArray;
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
