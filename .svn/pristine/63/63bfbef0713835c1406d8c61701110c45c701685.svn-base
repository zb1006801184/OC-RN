//
//  OnMoneryViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "OnMoneryViewController.h"
#import "PayStyleViewController.h"
#import "PayCodeViewController.h"
@interface OnMoneryViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *textFild;

@property(nonatomic,strong)NSString *jifen;

@property(nonatomic,strong)UIButton *loginBtn;
@end

@implementation OnMoneryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"输入消费总额" isBack:YES];
    [self creatMainView];
}

-(void)creatMainView{
    
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:MemberPhone];
    
//    NSString *jifen = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:AvailableIntegral]];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 84, SCREEN_WIDTH - 40, 30)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    
    NSString *hiddenStr = str;
    if( str.length == 11 ||  str.length == 13){
        hiddenStr = [NSString stringWithFormat:@"%@****%@",[ str substringToIndex:3],[ str substringFromIndex:7]];
    }
    NSString *allStr = [NSString stringWithFormat:@"会员%@",hiddenStr];
//    NSMutableAttributedString *strOne = [[NSMutableAttributedString alloc]initWithString:allStr];
//    NSRange start = [allStr rangeOfString:@"分"];
//    [strOne addAttribute:NSForegroundColorAttributeName value:BACKGROUNGCOLOR range:NSMakeRange(start.location + 1, jifen.length)];
    
    titleLabel.text = allStr;
    
    [self.view addSubview:titleLabel];
    
    
    UIView *bkView = [[UIView alloc]init];
    bkView.frame = CGRectMake(20, titleLabel.bottom + 20, SCREEN_WIDTH - 40, SCALE_HEIGHT(50));
    bkView.backgroundColor = [UIColor whiteColor];
    bkView.layer.borderWidth = 1.5;
    bkView.layer.borderColor = BACKGrayColor.CGColor;
    [self.view addSubview:bkView];
    
    
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, bkView.height)];
    leftLabel. text = @"消费总额";
    leftLabel.font = [UIFont systemFontOfSize:14];
    leftLabel.textColor = [UIColor blackColor];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    [bkView addSubview:leftLabel];
    
    
    UITextField *rightTextField = [[UITextField alloc]initWithFrame:CGRectMake(90, 0, bkView.width - 100, SCALE_HEIGHT(50))];
    rightTextField.placeholder = @"点击输入金额";
    rightTextField.tag = 100;
    rightTextField.textAlignment = NSTextAlignmentRight;
    rightTextField.font = [UIFont systemFontOfSize:14];
    rightTextField.keyboardType = UIKeyboardTypeDecimalPad;
    rightTextField.delegate = self;
    [bkView addSubview:rightTextField];
    self.textFild = rightTextField;
    [self.textFild addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, bkView.bottom + 30, self.view.frame.size.width - 80, SCALE_HEIGHT(40))];
    if([self.styleStr isEqualToString:@"线上付"]){
        [loginBtn setTitle:@"确定" forState:UIControlStateNormal];
    }else{
        [loginBtn setTitle:@"支付" forState:UIControlStateNormal];
    }
    
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 5;
    loginBtn.backgroundColor = BACKGROUNGCOLOR;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    self.loginBtn = loginBtn;
    
    
}
#pragma - mark 防爆点击
-(void)changeButtonStatus{
    
    self.loginBtn.enabled =YES;
    
}

#pragma mark - 确定按钮
-(void)sureClick: (UIButton *)btn{
    
    [self.textFild resignFirstResponder];
    
    self.loginBtn.enabled =NO;
    
    [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:2.0f];//防止重复点击
    
    
    if ([self.textFild.text floatValue] <= 0) {
        
        [ALToastView toastInView:self.view withText:@"请输入大于0的金额"];
        
    }else{
        if([self.styleStr isEqualToString:@"线下付"]){
            
            NSString *url = httpCreatYuMonery;
            [JHHJView showLoadingOnTheKeyWindowWithType:2];
            [QJGlobalControl sendPOSTWithUrl:url parameters:nil success:^(id data) {
                
                [JHHJView hideLoading];
                NSLog(@"获取到的数据为：%@",data);
                
                NSString *result=[NSString stringWithFormat:@"%@",data[@"code"]];
                
                if ([result isEqual:@"200"]) {
                    
                    NSString *yuMonery = [NSString stringWithFormat:@"%@",data[@"data"][@"balance"]];
                    PayStyleViewController *ctrl = [[PayStyleViewController alloc]init];
                    ctrl.YuMonery = yuMonery;
                    ctrl.orderMonery = self.textFild.text;
                    ctrl.bindingPhone = self.proTelPhone;
                    NSString *scale = [[NSUserDefaults standardUserDefaults]objectForKey:ProfitRatio];
                    CGFloat scaleF = [scale floatValue];
                    
                    if([self.textFild.text floatValue] * scaleF > ([yuMonery floatValue] + 1000)){
                        
                        ctrl.styleStr = @"余额不足";
                    }else{
                        ctrl.styleStr = @"余额充足";
                    }
                    
                    [self.navigationController pushViewController:ctrl animated:YES];
                }
                
            } fail:^(NSError *error) {
                
                [JHHJView hideLoading];
                [ALToastView toastInView:self.view withText:@"请求失败"];
            }];
            
            
        }else{
            
            [JHHJView showLoadingOnTheKeyWindowWithType:2];
            
            
            NSString *memberPhone = [[NSUserDefaults standardUserDefaults]objectForKey:MemberPhone];
            NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:UserID];
            NSDictionary *params = @{@"memberPhone":memberPhone,@"merchantId":userID,@"orderMoney":self.textFild.text};
            
            [QJGlobalControl sendPOSTWithUrl:JQXHttp_SendOrder parameters:params success:^(id data) {
                [JHHJView hideLoading];
                NSLog(@"🍎 %@",data);
                if([data[@"code"]integerValue] == 200){
                    
                    [ALToastView toastInView:self.view withText:data[@"message"]];
                    
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
                [JHHJView hideLoading];
                [ALToastView toastInView:self.view withText:@"请求失败"];
            }];
            
        }
    }
    
}

-(void)backBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)TextChange:(UITextField *)textFiled
{
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textFiled.text options:0 range:NSMakeRange(0, textFiled.text.length) withTemplate:@""];
    
    
    if (![noEmojiStr isEqualToString:textFiled.text]) {
        
        textFiled.text = noEmojiStr;
        
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.textFild) {
        
        //禁止用户输入字母
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
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
    //不支持系统表情的输入
    if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    
    //限制峰值5万
    NSLog(@".第一次...%@",self.textFild.text);
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"..text.%@",text);
    if ([text floatValue] > 999999) {
        textField.text = @"999999";
        [self.textFild resignFirstResponder];
        [ALToastView toastInView:self.view withText:@"金额最大为999999元"];
    }
    
    return YES;
}

//编辑结束
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text floatValue] > 999999) {
        textField.text = @"999999";
    }
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
