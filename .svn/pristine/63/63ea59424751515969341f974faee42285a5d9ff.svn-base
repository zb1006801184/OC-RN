//
//  PaySumbitViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "PaySumbitViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "JKCountDownButton.h"
@interface PaySumbitViewController ()<UITextFieldDelegate>
{
    NSString *realName;
    NSString *bankName;
    NSString *bankcard;
}
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *mainScrollView;
@property (nonatomic,strong)UITextField * moneryText;
@property (nonatomic,strong)UITextField *codeText;
@property (nonatomic,strong)JKCountDownButton *numButton;
@property (nonatomic,strong)UIView *markView;
@property (nonatomic,strong)NSDictionary *mainDic;
@end

@implementation PaySumbitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"余额提现" isBack:YES];
    self.view.backgroundColor = BACKGrayColor;

    [self setBankDetails];
    
    [self.markView removeFromSuperview];

}
#pragma mark - 获取银行卡信息
- (void)setBankDetails
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendGETWithUrl:httpBankListURL parameters:nil success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"🍉：%@",data);
        if([data[@"code"]integerValue] == 200){
            self.mainDic = data[@"data"];
            [self setUI:data[@"data"]];
        }else{
           [ALToastView toastInView:self.view withText:data[@"message"]];
            dispatch_time_t delayTime = dispatch_time
            (DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
            
            dispatch_after
            (delayTime, dispatch_get_main_queue(),
             ^{
                 [self.navigationController popViewControllerAnimated:YES];
                 
             }
             );
        }
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];

}
- (void)setUI:(NSDictionary *)dic
{
    
    [self.mainScrollView removeFromSuperview];
    self.mainScrollView = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    [self.view addSubview:self.mainScrollView];
    
    NSString *monery = [NSString stringWithFormat:@"%@元",self.moneryStr];
    realName = [NSString stringWithFormat:@"%@",dic[@"ownerName"]];
    
    NSString *hiddenStr = [NSString stringWithFormat:@"*%@",[realName substringFromIndex:1]];
    
    bankName = [NSString stringWithFormat:@"%@",dic[@"bankName"]];
    bankcard = [NSString stringWithFormat:@"%@",dic[@"cardNo"]];
    NSString * IDCardStr = bankcard;
    if(IDCardStr.length > 0){
       IDCardStr = [NSString stringWithFormat:@"%@**********%@",[bankcard substringToIndex:4],[bankcard substringFromIndex:12]];
    }
    
    
    NSArray *titleArray = @[@"可提现金额：",@"账户名称：",@"所属银行：",@"银行卡号："];
    NSArray *titleArray1 = @[monery,hiddenStr,bankName,IDCardStr];
    for (int i = 0; i < titleArray.count; i ++) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,(i + 1) *10 + i * 45, SCREEN_WIDTH, 45)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.mainScrollView addSubview:bgView];
        
        
        UILabel *tsLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 80, bgView.height)];
        tsLabel1.font = [UIFont systemFontOfSize:13];
        tsLabel1.textAlignment = NSTextAlignmentCenter;
        tsLabel1.text = titleArray[i];
        [bgView addSubview:tsLabel1];
        
        UILabel *tsLabel2= [[UILabel alloc]initWithFrame:CGRectMake(tsLabel1.right, 0, SCREEN_WIDTH - 120 , bgView.height)];
        tsLabel2.font = [UIFont systemFontOfSize:13];
        tsLabel2.textAlignment = NSTextAlignmentLeft;
        tsLabel2.text = titleArray1[i];
        [bgView addSubview:tsLabel2];
        
    }
    UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 45*4+10*5, SCREEN_WIDTH, SCREEN_HEIGHT-45*4+10*5)];
    bigView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:bigView];
    


    UIView *phoneview =[[UIView alloc]initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH-40, SCALE_HEIGHT(50))];
    phoneview.backgroundColor = [UIColor whiteColor];
    phoneview.layer.borderWidth = 1.5;
    phoneview.layer.borderColor = BACKGrayColor.CGColor;
    [bigView addSubview:phoneview];
    
    UILabel *phoneTsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, phoneview.height)];
    phoneTsLabel.text = @"手机号";
    phoneTsLabel.font = [UIFont systemFontOfSize:16];
    phoneTsLabel.textAlignment = NSTextAlignmentLeft;
    [phoneview addSubview:phoneTsLabel];
    
    //    手机号
    
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults]objectForKey:LoginPhone];
    
    if(phoneStr.length == 11 || phoneStr.length == 13){
        
        if(phoneStr.length == 13){
            phoneStr = [NSString stringWithFormat:@"%@",[phoneStr substringToIndex:11]];
        }
        
        phoneStr = [NSString stringWithFormat:@"%@****%@",[phoneStr substringToIndex:3],[phoneStr substringFromIndex:7]];
    }
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, phoneview.width - 10, phoneview.height)];
    phoneLabel.text = [NSString stringWithFormat:@"%@",phoneStr];
    phoneLabel.font = [UIFont systemFontOfSize:13];
    phoneLabel.textAlignment = NSTextAlignmentRight;
    [phoneview addSubview:phoneLabel];
    
    
    UIView *view1 =[[UIView alloc]initWithFrame:CGRectMake(20, phoneview.bottom + 10, SCREEN_WIDTH-40, SCALE_HEIGHT(50))];
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.borderWidth = 1.5;
    view1.layer.borderColor = BACKGrayColor.CGColor;
    [bigView addSubview:view1];
    
    self.moneryText = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, view1.width - 120, SCALE_HEIGHT(50))];
    self.moneryText.keyboardType = UIKeyboardTypeNumberPad;
    self.moneryText .placeholder = @"请点击输入金额";
    self.moneryText.font = [UIFont systemFontOfSize:13];
    self.moneryText.textAlignment = NSTextAlignmentRight;
    self.moneryText.delegate = self;
    [view1 addSubview:self.moneryText];
    
    UILabel *tsLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, SCALE_HEIGHT(50))];
    tsLabel3.text = @"提现金额";
    tsLabel3.font = [UIFont systemFontOfSize:16];
    tsLabel3.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:tsLabel3];
    
    
    //验证码
    UIView *codeView = [[UIView alloc]initWithFrame:CGRectMake(20, view1.bottom + 10, SCREEN_WIDTH - 150, SCALE_HEIGHT(50))];
    codeView.layer.borderWidth = 1.5;
    codeView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [bigView addSubview:codeView];
    
    self.codeText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, codeView.width - 20, codeView.height)];
    self.codeText.keyboardType = UIKeyboardTypeNumberPad;
    self.codeText.font = [UIFont systemFontOfSize:13];
    self.codeText.placeholder = @"请输入手机验证码";
    self.codeText.delegate = self;
    [codeView addSubview:self.codeText];
    
    self.numButton = [[JKCountDownButton alloc]initWithFrame:CGRectMake(codeView.right + 10, view1.bottom + 12.5 , view1.width - codeView.width - 10, 40)];
    self.numButton.backgroundColor = BACKGROUNGCOLOR;
    self.numButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.numButton.layer.masksToBounds = YES;
    self.numButton.layer.cornerRadius = 5;
    [self.numButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.numButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.numButton addTarget:self action:@selector(numAction:) forControlEvents:UIControlEventTouchUpInside];
    [bigView addSubview:self.numButton];
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(40,codeView.bottom+20, SCREEN_WIDTH-80, SCALE_HEIGHT(40))];
    button.backgroundColor = BACKGROUNGCOLOR;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"提交申请" forState:UIControlStateNormal];
    [button.layer setCornerRadius:5.0];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bigView addSubview:button];
}

#pragma mark  - 短信验证码
- (void)numAction:(JKCountDownButton *)sender
{
    [self.view endEditing:YES];
    
    NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:LoginPhone];

    
    if(phone.length == 13){
        phone = [NSString stringWithFormat:@"%@",[phone substringToIndex:11]];
    }
    
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSDictionary *params = @{@"phone":phone};
    [QJGlobalControl sendPOSTWithUrl:JQXMoneyCode_HaveMoney parameters:params success:^(id data) {
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
    
    
}

#pragma mark - 提现
- (void)buttonAction:(UIButton *)sender{
   
    [self.view endEditing:YES];

    NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:LoginPhone];
    
    
    if(phone.length == 13){
        phone = [NSString stringWithFormat:@"%@",[phone substringToIndex:11]];
    }
    
    
    NSInteger allMonery = [self.moneryStr integerValue];
    NSInteger monery = [self.moneryText.text integerValue];
    NSNumber *longNumber = [NSNumber numberWithInteger:monery];
    if(monery < 20){

        [ALToastView toastInView:self.view withText:@"单笔金额不得小于20元"];

    }else if (monery > allMonery){

        [ALToastView toastInView:self.view withText:@"单笔金额不得大于可提现金额"];

    }else{
        if(self.codeText.text.length == 6){
            [JHHJView showLoadingOnTheKeyWindowWithType:2];
            
            NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:UserID];
            NSDictionary *params = @{@"receiver":realName,@"bankNo":bankcard,@"bankName":bankName,@"drawCashScore":longNumber,@"userId":userID,@"telPhone":phone,@"code":self.codeText.text};
            
            [QJGlobalControl sendPOSTWithUrl:httpBankOFMonery parameters:params success:^(id data) {
                
                [JHHJView hideLoading];
                NSLog(@"🍉：%@",data);
                
                if([data[@"code"]integerValue] == 200){
                    
                    [self setMarkViewUI];
                    
                }else{
                    
                    [ALToastView toastInView:self.view withText:data[@"message"]];
                }
                
            } fail:^(NSError *error) {
                [JHHJView hideLoading];
                [ALToastView toastInView:self.view withText:@"请求失败"];
            }];
        }else{
            [ALToastView toastInView:self.view withText:@"请输入6位验证码"];
        }

    }

}
- (void)setMarkViewUI
{
    self.markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.markView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.7];
    [self.view addSubview:self.markView];
    
    UIView *tsView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 180)/2, 180, 180, 120)];
    tsView.backgroundColor = [UIColor whiteColor];
    [self.markView addSubview:tsView];
   
    UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(0, 20, tsView.width, 40) backColor:[UIColor clearColor] text:@"您的申请已受理，\n我们将尽快审核。" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter numOnLines:0];
    [tsView addSubview:tsLabel];
    
    UIButton *canclebutton = [[UIButton alloc]initWithFrame:CGRectMake(tsView.width - 20, 0, 20, 20)];
    [canclebutton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [canclebutton addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [tsView addSubview:canclebutton];
    
    
    UIButton *surebutton = [JQXCustom creatButton:CGRectMake((tsView.width - 100)/2, tsView.height - 40, 100, 30) backColor:BACKGROUNGCOLOR text:@"确定" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:13] addTarget:self Action:@selector(sureAction)];
    surebutton.layer.masksToBounds = YES;
    surebutton.layer.cornerRadius = 8;
    [tsView addSubview:surebutton];
    
}
#pragma mark - 取消按钮点击事件
- (void)cancleAction
{
    [self.markView removeFromSuperview];
    [self creatOneClassShopindex:1];
    
}
#pragma mark - 确定按钮点击事件
- (void)sureAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 获取余额
-(void)creatOneClassShopindex:(NSInteger )index{
    
    NSString *url = httpYUOrderListByMerchantPhone;
    NSDictionary *params = @{@"pageNum":[NSString stringWithFormat:@"%ld",(long)index],@"pageSize":@10};
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendPOSTWithUrl:url parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSString *result=[NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([result isEqual:@"200"]) {
            
            self.moneryStr = [NSString stringWithFormat:@"%@",data[@"data"][@"userBalance"]];
            [self setUI:self.mainDic];
            
        }else{
            
            NSString *msg = data[@"message"];
            
            [ALToastView toastInView:self.view withText:msg];
            
        }
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.moneryText || textField == self.codeText) {
        //不能输入表情
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
        
        NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textField.text options:0 range:NSMakeRange(0, textField.text.length) withTemplate:@""];
        
        
        if (![noEmojiStr isEqualToString:textField.text] || [[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
            
            textField.text = noEmojiStr;
            
        }
        
        
        //禁止用户输入字母
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c]) {
                return NO;
            }
        }
        
        
        NSScanner      *scanner    = [NSScanner scannerWithString:string];
        NSCharacterSet *numbers;
        NSRange         pointRange = [textField.text rangeOfString:@"."];
        
        if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) )
        {
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        }
        else
        {
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
        }
        
        if ( [textField.text isEqualToString:@""] && [string isEqualToString:@"."] )
        {
            return NO;
        }
        
        if ( range.location > 9  )
        {
            return NO;
        }
        
        short remain = 2;
        
        NSString *tempStr = [textField.text stringByAppendingString:string];
        NSUInteger strlen = [tempStr length];
        if(pointRange.length > 0 && pointRange.location > 0){ //判断输入框内是否含有“.”。
            if([string isEqualToString:@"."]){ //当输入框内已经含有“.”时，如果再输入“.”则被视为无效。
                return NO;
            }
            if(strlen > 0 && (strlen - pointRange.location) > remain+1){ //当输入框内已经含有“.”，当字符串长度减去小数点前面的字符串长度大于需要要保留的小数点位数，则视当次输入无效。
                return NO;
            }
            
        }
        
        NSRange zeroRange = [textField.text rangeOfString:@"0"];
        if(zeroRange.length == 1 && zeroRange.location == 0){ //判断输入框第一个字符是否为“0”
            if(![string isEqualToString:@"0"] && ![string isEqualToString:@"."] && [textField.text length] == 1){ //当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
                textField.text = string;
                return NO;
            }else{
                if(pointRange.length == 0 && pointRange.location > 0){ //当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
                    if([string isEqualToString:@"0"]){
                        return NO;
                    }
                }
            }
        }
        
        
        NSString *buffer;
        if ( ![scanner scanCharactersFromSet:numbers intoString:&buffer] && ([string length] != 0) )
        {
            return NO;
        }
        
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
