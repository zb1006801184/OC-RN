//
//  PayStyleViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "PayStyleViewController.h"
#import "PasswordAlertView.h"
#import "PaySuccessViewController.h"//支付成功
#import "PayCodeView.h"
#import "PayRechargeViewController.h"//充值
#define kDotSize CGSizeMake (10, 10) //密码点的大小
#define kDotCount 6  //密码个数
#define K_Field_Height 50  //每一个输入框的高度
@interface PayStyleViewController ()<UITextFieldDelegate>{
    
    int btnIndex;
    
    NSInteger typ;
    UIImageView *moneryImage;
    UIImageView *jifenImage;
    UIImageView *quckImage;
    UIButton *moneryBtn;
    UIButton *jifenBtn;
    UIButton *quckBtn;

    //验证码
    NSString *VerifyCode;
    //支付码
    NSString *PayCode;

    
}

@property (nonatomic,strong)NSString *httpStr;
@property (nonatomic,strong)UITextField *textFiled;
@property (nonatomic,strong)UIButton *payBtn;
@property (nonatomic,strong)NSMutableArray *dotArray; //用于存放黑色的点点
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIView *zheView;
@property (nonatomic,strong)UILabel *tsLabel;
@property (nonatomic,strong)UIView *markView;//遮罩试图


@end

@implementation PayStyleViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setNavBarWithTitle:@"选择支付方式" isBack:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    if([self.styleStr isEqualToString:@"余额充足"]){
         [self creatBtnView];
        
    }else{
    
        [self creatBtnNOView];
    }

    self.zheView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT/2)];
    self.zheView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.zheView.hidden = YES;
    [self.view addSubview:self.zheView];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HiddenTap:)];
    [self.zheView addGestureRecognizer:singleTap];
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    if(SCREEN_WIDTH < 375){
        [self.bgView setHeight:SCREEN_HEIGHT/2 +70];
        [self.bgView setTop:SCREEN_HEIGHT/2 - 70];
    }
    self.bgView.hidden = YES;
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    self.tsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 30)];
    self.tsLabel.textColor = [UIColor lightGrayColor];
    self.tsLabel.font = [UIFont systemFontOfSize:15];
    self.tsLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgView addSubview:self.tsLabel];
    
    [self.bgView addSubview:self.textField];
    [self initPwdTextField];
    typ = 1;
    
    //门店区域取消按钮点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CancleActon:) name:@"CodeCancle" object:nil];
    
}

- (void)CancleActon:(NSNotification *)notif
{
    [self.markView removeFromSuperview];
}

-(void)creatBtnView{
    
    CGFloat yPos =  30 + 64;
    
//    NSString *availableIntegral = [[NSUserDefaults standardUserDefaults]objectForKey:AvailableIntegral];
    NSString *moneryStr = [NSString stringWithFormat:@"现金支付(可用余额%@)",self.YuMonery];
//    NSString *availableIntegralStr = [NSString stringWithFormat:@"积分支付(可用积分%@)",availableIntegral];
    
//    moneryImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, yPos + 10, 20, 20)];
//    moneryImage.image = [UIImage imageNamed:@"radio_checked"];
//    [self.view addSubview:moneryImage];
    
    moneryBtn = [[UIButton alloc]initWithFrame:CGRectMake( 10, yPos, 40, 40)];
    [moneryBtn setImage:[UIImage imageNamed:@"radio_checked"] forState:UIControlStateNormal];
    //    [moneryBtn setImage:[UIImage imageNamed:@"radio_checked"] forState:UIControlStateNormal];
//    moneryBtn.tag = 101;
//    [moneryBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moneryBtn];
    UILabel *moneryLabel = [[UILabel alloc]initWithFrame:CGRectMake( 70, yPos, SCREEN_WIDTH - 80, 40)];
    moneryLabel.attributedText = [self String:moneryStr RangeString:[NSString stringWithFormat:@"%@",self.YuMonery]];
    moneryLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:moneryLabel];
//    yPos += 40;
//    
//    jifenImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, yPos + 10, 20, 20)];
//    jifenImage.image = [UIImage imageNamed:@"radio_unchecked"];
//    [self.view addSubview:jifenImage];
//    
//    jifenBtn = [[UIButton alloc]initWithFrame:CGRectMake( 0, yPos, SCREEN_WIDTH, 40)];
//    //    [jifenBtn setImage:[UIImage imageNamed:@"radio_unchecked"] forState:UIControlStateNormal];
//    jifenBtn.tag = 102;
//    [jifenBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:jifenBtn];
//    UILabel *jifenLabel = [[UILabel alloc]initWithFrame:CGRectMake( 70, yPos, SCREEN_WIDTH - 80, 40)];
//    jifenLabel.attributedText = [self String:availableIntegralStr RangeString:[NSString stringWithFormat:@"%@",availableIntegral]];
//    jifenLabel.font = [UIFont systemFontOfSize:15];
//    [self.view addSubview:jifenLabel];
//    
//    
//    yPos += 40;
//    
//    quckImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, yPos + 10, 20, 20)];
//    quckImage.image = [UIImage imageNamed:@"radio_unchecked"];
//    [self.view addSubview:quckImage];
//    
//    quckBtn = [[UIButton alloc]initWithFrame:CGRectMake( 0, yPos, SCREEN_WIDTH, 40)];
//
//    quckBtn.tag = 103;
//    [quckBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:quckBtn];
//    UILabel *quckLabel = [[UILabel alloc]initWithFrame:CGRectMake( 70, yPos, SCREEN_WIDTH - 80, 40)];
//    quckLabel.text = @"快捷支付";
//    quckLabel.font = [UIFont systemFontOfSize:15];
//    [self.view addSubview:quckLabel];
//
//    
    yPos += 60;
    
    UIButton *payBtn = [[UIButton alloc]initWithFrame:CGRectMake(40,yPos, self.view.frame.size.width - 80, SCALE_HEIGHT(40))];
    payBtn.layer.masksToBounds = YES;
    payBtn.layer.cornerRadius = 5;
    [payBtn setTitle:@"支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payBtn.backgroundColor = BACKGROUNGCOLOR;
    [payBtn addTarget:self action:@selector(payClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
    self.payBtn = payBtn;
}
- (void)creatBtnNOView
{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 60)];
    topView.backgroundColor = BACKGrayColor;
    [self.view addSubview:topView];
    
    UILabel *tsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 40)];
    tsLabel.backgroundColor = [UIColor whiteColor];
    tsLabel.font = [UIFont systemFontOfSize:15];
    tsLabel.attributedText = [self String:@"   您的账户余额不足，立即充值" RangeString:@"立即充值"];
    [topView addSubview:tsLabel];
    
    UIButton *moneryButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, topView.width, topView.height)];
    [moneryButton setImage:[UIImage imageNamed:@"icon_un"] forState:UIControlStateNormal];
    [moneryButton addTarget:self action:@selector(moneryAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:moneryButton];
    
    CGFloat yPos =  topView.bottom;
    
//    NSString *availableIntegral = [[NSUserDefaults standardUserDefaults]objectForKey:AvailableIntegral];
    NSString *moneryStr = [NSString stringWithFormat:@"现金支付(可用余额%@)",self.YuMonery];
//    NSString *availableIntegralStr = [NSString stringWithFormat:@"积分支付(可用积分%@)",availableIntegral];
    
    moneryImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, yPos + 10, 20, 20)];
    moneryImage.image = [UIImage imageNamed:@"icon_un"];
    [self.view addSubview:moneryImage];
    
    moneryBtn = [[UIButton alloc]initWithFrame:CGRectMake( 0, yPos, SCREEN_WIDTH, 40)];
 
    [self.view addSubview:moneryBtn];
    UILabel *moneryLabel = [[UILabel alloc]initWithFrame:CGRectMake( 70, yPos, SCREEN_WIDTH - 80, 40)];
    moneryLabel.text = moneryStr;
    moneryLabel.textColor = [UIColor colorWithHexString:@"#bbbbbb"];
    moneryLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:moneryLabel];
    yPos += 40;
    
//    jifenImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, yPos + 10, 20, 20)];
//    jifenImage.image = [UIImage imageNamed:@"radio_checked"];
//    [self.view addSubview:jifenImage];
//    
//    jifenBtn = [[UIButton alloc]initWithFrame:CGRectMake( 0, yPos, SCREEN_WIDTH, 40)];
//    //    [jifenBtn setImage:[UIImage imageNamed:@"radio_unchecked"] forState:UIControlStateNormal];
//    jifenBtn.tag = 102;
//    [jifenBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:jifenBtn];
//    UILabel *jifenLabel = [[UILabel alloc]initWithFrame:CGRectMake( 70, yPos, SCREEN_WIDTH - 80, 40)];
//    jifenLabel.attributedText = [self String:availableIntegralStr RangeString:[NSString stringWithFormat:@"%@",availableIntegral]];
//    jifenLabel.font = [UIFont systemFontOfSize:15];
//    [self.view addSubview:jifenLabel];
//    
//    yPos += 40;
//    
//    quckImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, yPos + 10, 20, 20)];
//    quckImage.image = [UIImage imageNamed:@"radio_unchecked"];
//    [self.view addSubview:quckImage];
//    
//    quckBtn = [[UIButton alloc]initWithFrame:CGRectMake( 0, yPos, SCREEN_WIDTH, 40)];
//    
//    quckBtn.tag = 103;
//    [quckBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:quckBtn];
//    UILabel *quckLabel = [[UILabel alloc]initWithFrame:CGRectMake( 70, yPos, SCREEN_WIDTH - 80, 40)];
//    quckLabel.text = @"快捷支付";
//    quckLabel.font = [UIFont systemFontOfSize:15];
//    [self.view addSubview:quckLabel];
    
    
    yPos += 60;
    
    UIButton *payBtn = [[UIButton alloc]initWithFrame:CGRectMake(40,yPos, self.view.frame.size.width - 80, SCALE_HEIGHT(40))];
    payBtn.layer.masksToBounds = YES;
    payBtn.layer.cornerRadius = 5;
    [payBtn setTitle:@"支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payBtn.backgroundColor = BACKGROUNGCOLOR;
    [payBtn addTarget:self action:@selector(payClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
    self.payBtn = payBtn;
    
    
}
//-(void)btnClick:(UIButton *)sender{
//    
//    if([self.styleStr isEqualToString:@"余额充足"]){
//        switch (sender.tag) {
//            case 101:
//                //现金支付
//                moneryImage.image = [UIImage imageNamed:@"radio_checked"];
//                jifenImage.image = [UIImage imageNamed:@"radio_unchecked"];
//                quckImage.image = [UIImage imageNamed:@"radio_unchecked"];
//                typ = 1;
//                break;
//            case 102:
//                //积分支付
//                jifenImage.image = [UIImage imageNamed:@"radio_checked"];
//                moneryImage.image = [UIImage imageNamed:@"radio_unchecked"];
//                quckImage.image = [UIImage imageNamed:@"radio_unchecked"];
//                typ = 2;
//                break;
//            case 103:
//                //快捷支付
//                quckImage.image = [UIImage imageNamed:@"radio_checked"];
//                moneryImage.image = [UIImage imageNamed:@"radio_unchecked"];
//                jifenImage.image = [UIImage imageNamed:@"radio_unchecked"];
//                typ = 6;
//                break;
//            default:
//                break;
//        }
//    }else{
//        
//        switch (sender.tag) {
//            case 102:
//                //积分支付
//                jifenImage.image = [UIImage imageNamed:@"radio_checked"];
//                quckImage.image = [UIImage imageNamed:@"radio_unchecked"];
//                typ = 2;
//                break;
//            case 103:
//                //快捷支付
//                quckImage.image = [UIImage imageNamed:@"radio_checked"];
//                jifenImage.image = [UIImage imageNamed:@"radio_unchecked"];
//                typ = 6;
//                break;
//            default:
//                break;
//        }
//    }
//    
//    
//}

//支付
#pragma mark - 支付按钮点击事件
-(void)payClick:(UIButton *)btn{
    
    
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:2.0f];//防止重复点击
    [self YesORNoPayPWD];//判断是否设置过支付密码
    
//    self.textFiled.text = @"";
//    [self clearUpPassword];
//    if(typ == 1){
//        [self.textField becomeFirstResponder];
//        self.tsLabel.text = @"请输入支付密码";
//        self.zheView.hidden = NO;
//        self.bgView.hidden  = NO;
//    }
//    else if(typ == 2){
//        self.tsLabel.text = @"请输入验证码";
//        [self messageSetData];
//    }else{
//        [self payToText:@"快捷支付"];
//    }
    
    
}

#pragma mark - 判断是否设置过支付密码
- (void)YesORNoPayPWD
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendGETWithUrl:http_YESORNOPayPwd parameters:nil success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"%@",data);
    
        
        if([data[@"code"]integerValue] == 200){ //设置了支付密码
            
            self.textFiled.text = @"";
            [self clearUpPassword];
            if(typ == 1){
                [self.textField becomeFirstResponder];
                self.tsLabel.text = @"请输入支付密码";//请输入短信验证码
                self.zheView.hidden = NO;
                self.bgView.hidden  = NO;
//                [self sendToMemberPhone];//发送短信验证码
            }
            
        }else{//未设置支付密码
            
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}



#pragma mark - 生成中间的点点
- (void)initPwdTextField
{
    //每个密码输入框的宽度
    CGFloat width = (K_Field_Height*6) / kDotCount;
    
    //生成分割线
    for (int i = 0; i < kDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i + 1) * width, CGRectGetMinY(self.textField.frame), 1, K_Field_Height)];
        lineView.backgroundColor = RGB_COLOR(170, 170, 170);
        [self.bgView addSubview:lineView];
    }
    
    self.dotArray = [[NSMutableArray alloc] init];
    //生成中间的点
    for (int i = 0; i < kDotCount; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(self.textFiled.left +((self.textFiled.width/6)- kDotSize.width)/2 + i *kDotSize.width + i *(self.textFiled.width/6 - 10),self.tsLabel.bottom + 5 + (self.textFiled.height - kDotSize.width)/2, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //先隐藏
        [self.bgView addSubview:dotView];
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

#pragma mark - 监听输入的密码
- (void)textFieldDidChange:(UITextField *)textField
{
    VerifyCode = textField.text;

    NSLog(@"%@", textField.text);
    NSString *textID = textField.text;
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kDotCount) {
        NSLog(@"输入完毕");
        if (typ == 1 &&[self.tsLabel.text isEqual:@"请输入短信验证码"]) {
    
            [self clearUpPassword];
            self.zheView.hidden = NO;
            self.bgView.hidden  = NO;
            [self payCodeToText:textID];
            

        }else{
            
            [self clearUpPassword];
            self.zheView.hidden = NO;
            self.bgView.hidden  = NO;
            [self payToText:textID];//支付密码
            
            
//            [self payPassWordToText:textField.text];//支付密码
            
        }
    }
}

#pragma mark - init

- (UITextField *)textField
{
    if (!_textFiled) {
        _textFiled = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - K_Field_Height *6)/2, self.tsLabel.bottom + 5, K_Field_Height *6, K_Field_Height)];
        _textFiled.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        _textFiled.textColor = [UIColor whiteColor];
        //输入框光标的颜色为白色
        _textFiled.tintColor = [UIColor whiteColor];
        _textFiled.delegate = self;
        _textFiled.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textFiled.keyboardType = UIKeyboardTypeNumberPad;
        _textFiled.layer.borderColor = [RGB_COLOR(170, 170, 170) CGColor];
        _textFiled.layer.borderWidth = 1;
        [_textFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textFiled;
}
- (void)HiddenTap:(UITapGestureRecognizer *)tap
{
    self.zheView.hidden = YES;
    self.bgView.hidden  = YES;
    [self.textFiled resignFirstResponder];
}
-(void)changeButtonStatus{
    
    self.payBtn.enabled =YES;
}

#pragma mark - 支付密码
-(void)payToText:(NSString *)text{
    
    NSString *url = @"";
    NSDictionary *params = @{};
    NSString *memberId = [[NSUserDefaults standardUserDefaults]objectForKey:MemberId];
    NSString *memberPhone = [[NSUserDefaults standardUserDefaults]objectForKey:MemberPhone];
    if(memberId.length == 0){
        memberId = @"";
    }
    if(typ == 1){
        url = httpPayTyp1NextMonery;//现金支付
        params = @{@"payType":@"0",@"memberId":memberId,@"payPassWord":text,@"orderMoney":self.orderMonery,@"memberPhone":memberPhone};//@"proTelPhone":self.bindingPhone
    }
//    else if(typ == 2){
//        url = httpPayTyp1NextJifen;//积分支付
//        params = @{@"payType":@"1",@"memberId":memberId,@"verificationCode":text,@"orderMoney":self.orderMonery,@"memberPhone":memberPhone};
//    }else{
//        url = httpPayTyp1NextJifen;//快捷支付
//        params = @{@"payType":@"6",@"memberId":memberId,@"orderMoney":self.orderMonery,@"memberPhone":memberPhone};
//    }
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendPOSTWithUrl:url parameters:params success:^(id data) {
        [JHHJView hideLoading];
         [self.textFiled resignFirstResponder];
        if ([data[@"code"]integerValue] == 200) {
            
//            if(typ == 6){
//                [self quckPay:data[@"data"]];
//                
//            }else{
                PaySuccessViewController *ctrl = [[PaySuccessViewController alloc]init];
                ctrl.moneryStr = self.orderMonery;
                [self.navigationController pushViewController:ctrl animated:YES];
//            }
            
//            self.tsLabel.text = @"请输入支付密码";
//            [ALToastView toastInView:self.bgView withText:@"验证成功，请输入支付密码"];
            
        }else{
            [self.textFiled resignFirstResponder];
            NSString *msg = data[@"message"];
            [ALToastView toastInView:self.bgView withText:msg];
            
        }
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [self.textFiled resignFirstResponder];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];

}

#pragma mark - 校验验证码
- (void)payCodeToText:(NSString *)payStr
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:MemberPhone];
    NSDictionary *params = @{@"phone":phone,@"code":payStr};
    [QJGlobalControl sendPOSTWithUrl:JQXHttp_PayOnCodeYES parameters:params success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"] integerValue] == 200){
            self.tsLabel.text = @"请输入支付密码";
            self.textFiled.text = @"";
            
        }else{
            [self.textFiled resignFirstResponder];
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [self.textFiled resignFirstResponder];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}
#pragma mark - 发送验证码
- (void)sendToMemberPhone
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:MemberPhone];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@",JQXHttp_PayOnCode,phone,@"4"];
    
    [QJGlobalControl sendPOSTWithUrl:url parameters:nil success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"] integerValue] == 200){
            
        }else{
            [self.textFiled resignFirstResponder];
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [self.textFiled resignFirstResponder];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];

    
}

#pragma mark - 快捷支付
- (void)quckPay:(NSDictionary *)dic
{
    
    NSString *userName = [[NSUserDefaults standardUserDefaults]objectForKey:UserName];
    NSString *body = [NSString stringWithFormat:@"%@%@",dic[@"orderNo"],userName];
    NSDictionary *params = @{@"orderNo":dic[@"orderNo"],@"body": body,@"money":self.orderMonery};
    [JHHJView showLoadingOnTheKeyWindowWithType:2];

 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    
    [manager POST:http_QuckPay parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [JHHJView hideLoading];
         NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if([data[@"code"]integerValue] == 200){
            [self payCodeView:data[@"data"]];
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];

    }];
    
    
    
    
}
#pragma mark - 快捷支付页面搭建
- (void)payCodeView:(NSDictionary *)dic
{
    NSString *imgUrl = [NSString stringWithFormat:@"%@",dic[@"code_img_url"]];
    [self.markView removeFromSuperview];
    self.markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.markView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.7];
    [self.view addSubview:self.markView];
    NSString *moneryStr = [NSString stringWithFormat:@"支付金额：%@",self.orderMonery];
    PayCodeView *payVC = [[PayCodeView alloc]initWithFrame:CGRectMake(20, 150, SCREEN_WIDTH - 40, SCREEN_WIDTH - 40) imgUrl:imgUrl monery:moneryStr];
    payVC.backgroundColor = [UIColor whiteColor];
    [self.markView addSubview:payVC];
    
    
    
}
- (void)messageSetData
{
    NSString *url = httpPayTyp1;
    NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:MemberPhone];
    NSDictionary *params = @{@"memberPhone":phone};
    
    [QJGlobalControl sendPOSTWithUrl:url parameters:params success:^(id data) {
        if([data[@"code"]integerValue] == 200){
            [ALToastView toastInView:self.view withText:@"短信验证码发送成功"];
            [self.textField becomeFirstResponder];
            self.zheView.hidden = NO;
            self.bgView.hidden = NO;
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        
        [ALToastView toastInView:self.bgView withText:@"短信验证码发送失败"];
    }];
}
- (void)moneryAction
{
    PayRechargeViewController *payVC = [[PayRechargeViewController alloc]init];
    [self.navigationController pushViewController:payVC animated:YES];
}

- (NSMutableAttributedString *)String:(NSString *)String RangeString:(NSString *)RangeString
{
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:String];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:RangeString];
    [hintString addAttribute:NSForegroundColorAttributeName value:BACKGROUNGCOLOR range:range1];
    
    return hintString;
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
