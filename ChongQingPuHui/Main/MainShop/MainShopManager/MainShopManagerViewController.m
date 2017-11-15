//
//  MainShopManagerViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/9/26.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "MainShopManagerViewController.h"
#import "JKCountDownButton.h"
#import "JQXAlertView.h"
@interface MainShopManagerViewController ()<UITextFieldDelegate>
{
    NSString *sumbitStr;
}
@property (nonatomic,strong)UITextField *managerText;
@property (nonatomic,strong)UITextField *phoneText;
@property (nonatomic,strong)UITextField *codeText;
@property (nonatomic,strong)UIButton *sumbitButton;
@property (nonatomic,strong)JKCountDownButton *numButton;
@end

@implementation MainShopManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"店面经理" isBack:YES];
    //店面经理
    RegisterView *managerView = [[RegisterView alloc]initWithFrame:CGRectMake(20, self.navBarView.bottom + 30, SCREEN_WIDTH - 40, 45)];
    managerView.tsLabel.text = @"店面经理";
    [self.view addSubview:managerView];
    
    self.managerText = [JQXCustom creatTextFiled:CGRectMake(90, 0, managerView.width - 90 - 10, managerView.height) placeholder:@"请输入店面经理名称"];
    self.managerText.textAlignment = NSTextAlignmentRight;
    
    [self.managerText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [managerView addSubview:self.managerText];
    
    //手机号
    RegisterView *phoneView = [[RegisterView alloc]initWithFrame:CGRectMake(20, managerView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    phoneView.tsLabel.text = @"手机号码";
    [self.view addSubview:phoneView];
    
    self.phoneText = [JQXCustom creatTextFiled:CGRectMake(90, 0, managerView.width - 90 - 10, phoneView.height) placeholder:@"请输入店面经理手机号码"];
    self.phoneText.textAlignment = NSTextAlignmentRight;
    self.phoneText.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneText.delegate = self;
    [phoneView addSubview:self.phoneText];
    
    CGFloat y = 0;
//    0审核中 1已审核 2审核失败 3.初始化
    if([self.styleStr isEqualToString:@"2"] || [self.styleStr isEqualToString:@"3"]){//审核失败或者初始状态
        //验证码
        UIView *codeView = [[UIView alloc]initWithFrame:CGRectMake(20, phoneView.bottom + 10, SCREEN_WIDTH - 150, 45)];
        codeView.layer.borderWidth = 1;
        codeView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
        [self.view addSubview:codeView];
        
        self.codeText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, codeView.width - 20, codeView.height)];
        self.codeText.keyboardType = UIKeyboardTypeNumberPad;
        self.codeText.font = [UIFont systemFontOfSize:13];
        self.codeText.placeholder = @"请输入手机验证码";
        self.codeText.delegate = self;
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
        
        
        UILabel *tsLabel1 = [JQXCustom creatLabel:CGRectMake(20, codeView.bottom + 10, SCREEN_WIDTH - 40, 30) backColor:[UIColor clearColor] text:@"注：该店面经理必须是和火会员" textColor:BACKGROUNGCOLOR font:Font(12) textAlignment:NSTextAlignmentLeft numOnLines:1];
        [self.view addSubview:tsLabel1];
        
//        if([self.styleStr isEqualToString:@"2"]){
//            UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(20, codeView.bottom, SCREEN_WIDTH - 40, 30) backColor:[UIColor clearColor] text:@"注：此账号还不是快火会员，请先注册" textColor:[UIColor blackColor] font:Font(12) textAlignment:NSTextAlignmentRight numOnLines:1];
//            [self.view addSubview:tsLabel];
//
//        }
        
        y = codeView.bottom + 50;

    }else{
        y = phoneView.bottom + 20;
        NSString *memberName = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.mainDic[@"memberName"])];
        self.managerText.text = memberName;
        NSString *phoneStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.mainDic[@"telPhone"])];
        self.phoneText.text = phoneStr;
    }
    
    self.sumbitButton = [JQXCustom creatButton:CGRectMake(60, y , SCREEN_WIDTH - 120, 40) backColor:BACKGROUNGCOLOR text:@"提交" textColor:[UIColor whiteColor] font:Font(15) addTarget:self Action:@selector(sumbitAction)];
    self.sumbitButton.layer.masksToBounds = YES;
    self.sumbitButton.layer.cornerRadius = 5;
    [self.view addSubview:self.sumbitButton];

    if([self.styleStr isEqualToString:@"0"]){//0 审核中
        self.managerText.userInteractionEnabled = NO;
        self.phoneText.userInteractionEnabled = NO;
        self.sumbitButton.backgroundColor = RGB_COLOR(221, 221, 221);
        self.sumbitButton.userInteractionEnabled = NO;
        sumbitStr = @"审核";
        
    }else if ([self.styleStr isEqualToString:@"1"]){ //1.已审核
        self.managerText.userInteractionEnabled = NO;
        self.phoneText.userInteractionEnabled = NO;
        [self.sumbitButton setTitle:@"解聘" forState:UIControlStateNormal];
        sumbitStr = @"解聘";
    }
    
}
#pragma mark - 提交按钮点击事件
- (void)sumbitAction
{
    [self.view endEditing:YES];
    
    self.sumbitButton.userInteractionEnabled = NO;
    
    if([sumbitStr isEqualToString:@"解聘"]){
        
        JQXAlertView *alert = [[JQXAlertView alloc]initWithMessage:@"确认要解聘该店面经理吗？" leftButtonTitle:@"取消" rightButtonTitle:@"确定"];
        
        
        [alert showWithCompletion:^(NSInteger selectIndex) {
            if (selectIndex == 0) {
                
                
            }else{
                 [self DismissalData];
                
            }
        }];
        
        
       
    }else{
        if(self.phoneText.text.length != 11 || self.codeText.text.length == 0 ||self.managerText.text.length == 0){
            self.sumbitButton.userInteractionEnabled = YES;
            if(self.phoneText.text.length != 11){
                [ALToastView toastInView:self.view withText:@"请输入正确手机号"];
            }else{
                [ALToastView toastInView:self.view withText:@"信息不全，请补充"];
            }
        }else{
            
            BOOL special = [QJGlobalControl isIncludeSpecialCharact:self.managerText.text];
            if(special){
                [ALToastView toastInView:self.view withText:@"不可以输入特殊字符"];
            }else{
                
                [JHHJView showLoadingOnTheKeyWindowWithType:2];
                NSDictionary *params = @{@"name":self.managerText.text,@"phone":self.phoneText.text,@"code":self.codeText.text,@"merchantId":self.merchantId};
                
                [QJGlobalControl sendPOSTWithUrl:JQXHttp_ShopManagerNew parameters:params success:^(id data) {
                    [JHHJView hideLoading];
                    if([data[@"code"] integerValue] == 200){
                        [ALToastView toastInView:self.view withText:data[@"message"]];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"JQXEditShopMessage" object:nil userInfo:nil];
                        dispatch_time_t delayTime = dispatch_time
                        (DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
                        
                        dispatch_after
                        (delayTime, dispatch_get_main_queue(),
                         ^{
                             
                             [self.navigationController popViewControllerAnimated:YES];
                         }
                         );
                        
                        
                    }else{
                        self.sumbitButton.userInteractionEnabled = YES;
                        [ALToastView toastInView:self.view withText:data[@"message"]];
                    }
                    
                } fail:^(NSError *error) {
                    [JHHJView hideLoading];
                    self.sumbitButton.userInteractionEnabled = YES;
                    [ALToastView toastInView:self.view withText:@"请求失败"];
                }];
            }
            
        }
    }
}
#pragma mark - 解聘网络请求
- (void)DismissalData
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSString *stroeManagerId = [NSString stringWithFormat:@"%@",self.mainDic[@"id"]];
    NSDictionary *params = @{@"stroeManagerId":stroeManagerId};
    
    [QJGlobalControl sendPOSTWithUrl:JQXHttp_ShopManagerDismissal parameters:params success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"] integerValue] == 200){
            [ALToastView toastInView:self.view withText:data[@"message"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"JQXEditShopMessage" object:nil userInfo:nil];
            dispatch_time_t delayTime = dispatch_time
            (DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
            
            dispatch_after
            (delayTime, dispatch_get_main_queue(),
             ^{
                 
                 [self.navigationController popViewControllerAnimated:YES];
             }
             );
            
        }else{
            self.sumbitButton.userInteractionEnabled = YES;
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        self.sumbitButton.userInteractionEnabled = YES;
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
    
}

#pragma mark  - 短信验证码
- (void)numAction:(JKCountDownButton *)sender
{
    [self.view endEditing:YES];

    if(self.phoneText.text.length == 11){
        
       [JHHJView showLoadingOnTheKeyWindowWithType:2];
        NSDictionary *params = @{@"phone":self.phoneText.text};
        [QJGlobalControl sendPOSTWithUrl:JQXHttp_ShopManagerCode parameters:params success:^(id data) {
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


- (void)TextChange:(UITextField *)textFiled
{
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textFiled.text options:0 range:NSMakeRange(0, textFiled.text.length) withTemplate:@""];
    
    
    if (![noEmojiStr isEqualToString:textFiled.text]) {
        
        textFiled.text = noEmojiStr;
        
    }
}
//不能输入表情
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if(textField == self.codeText || textField == self.phoneText){
        //禁止用户输入字母
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c]) {
                return NO;
            }
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
