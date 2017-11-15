//
//  RealNameViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "RealNameViewController.h"
#import "RealSuccessViewController.h"
@interface RealNameViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *nameText;
@property (nonatomic,strong)UITextField *idCordText;
@end

@implementation RealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"实名认证" isBack:YES];
    UIView *lineVeiw = [[UIView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, 10)];
    lineVeiw.backgroundColor = BACKGrayColor;
    [self.view addSubview:lineVeiw];
    
    //真实姓名
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(30, lineVeiw.bottom + 10, SCREEN_WIDTH - 60, 45)];
    nameView.layer.borderWidth = 1.5;
    nameView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.view addSubview:nameView];
    
    UILabel *tsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, nameView.height)];
    tsLabel.text = @"真实姓名";
    tsLabel.font = [UIFont systemFontOfSize:14];
    [nameView addSubview:tsLabel];
    
    self.nameText = [[UITextField alloc]initWithFrame:CGRectMake(tsLabel.right + 10, 0, nameView.width - tsLabel.width - 30, nameView.height)];
    self.nameText.textAlignment = NSTextAlignmentRight;
    self.nameText.font = [UIFont systemFontOfSize:13];
    self.nameText.delegate = self;
    self.nameText.placeholder = @"请输入您的姓名";
    [self.nameText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [nameView addSubview:self.nameText];
    
    
    //身份证号码
    UIView *idCordView = [[UIView alloc]initWithFrame:CGRectMake(30, nameView.bottom + 10, SCREEN_WIDTH - 60, 45)];
    idCordView.layer.borderWidth = 1.5;
    idCordView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.view addSubview:idCordView];
    
    UILabel *tsLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, idCordView.height)];
    tsLabel1.text = @"身份证号码";
    tsLabel1.font = [UIFont systemFontOfSize:14];
    [idCordView addSubview:tsLabel1];
    
    self.idCordText = [[UITextField alloc]initWithFrame:CGRectMake(tsLabel1.right + 10, 0, idCordView.width - tsLabel1.width - 30, idCordView.height)];
    self.idCordText.textAlignment = NSTextAlignmentRight;
    self.idCordText.font = [UIFont systemFontOfSize:13];
    self.idCordText.placeholder = @"请点击输入您的身份证号";
    self.idCordText.delegate = self;
    [self.idCordText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [idCordView addSubview:self.idCordText];
    
    UIButton *sumbitButton = [[UIButton alloc]initWithFrame:CGRectMake(60, idCordView.bottom + 20 , SCREEN_WIDTH - 120, 40)];
    sumbitButton.backgroundColor = BACKGROUNGCOLOR;
    sumbitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    sumbitButton.layer.masksToBounds = YES;
    sumbitButton.layer.cornerRadius = 5;
    [sumbitButton setTitle:@"提交认证" forState:UIControlStateNormal];
    [sumbitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sumbitButton addTarget:self action:@selector(sumbitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sumbitButton];

}
#pragma mark - 提交
- (void)sumbitAction
{
    [self.nameText resignFirstResponder];
    [self.idCordText resignFirstResponder];
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    if(self.idCordText.text.length == 0 || self.nameText.text.length == 0){
        
        [ALToastView toastInView:self.view withText:@"信息不全，请补充"];
        
    }else{
        //判断有特殊字符
        BOOL special = [QJGlobalControl isIncludeSpecialCharact:self.nameText.text];
        if(special){
            [ALToastView toastInView:self.view withText:@"不可以输入特殊字符"];
        }else{
            NSString *phoneStr = [[NSUserDefaults standardUserDefaults]objectForKey:LoginPhone];
            NSDictionary *params = @{@"realName":self.nameText.text,@"telPhone":phoneStr,@"idCardNo":self.idCordText.text};
            [QJGlobalControl sendPOSTWithUrl:httpRealName parameters:params success:^(id data) {
                [JHHJView hideLoading];
                NSLog(@"data == %@",data);
                if([data[@"code"]integerValue] == 200){
                    [ALToastView toastInView:self.view withText:data[@"message"]];
                    
                    [self YESorNoNealName];
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


#pragma mark - 校验实名认证
- (void)YESorNoNealName
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendGETWithUrl:httpYESorNOName parameters:nil success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data === %@",data);
        if([data[@"code"]integerValue] == 200){
            /*
             bankCardInfoId = "<null>";
             idCardNo = "<null>";
             isAuth = 0;
             ownerName = "<null>";
             
             
             bankCardInfoId = 11;
             idCardNo = 230281199105143722;
             isAuth = 1;
             ownerName = "\U9648\U6653\U4f1f";
             
             */
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:data[@"data"][@"bankCardInfoId"] forKey:bankCardInfoId];
            [user setObject:data[@"data"][@"idCardNo"] forKey:idCardNo];
            [user setObject:data[@"data"][@"ownerName"] forKey:RealName];
            [user synchronize];
            //认证成功
            RealSuccessViewController *success = [[RealSuccessViewController alloc]init];
            success.styleStr = @"直接跳转认证详情";
            [self.navigationController pushViewController:success animated:YES];
            
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
}

//不能输入表情
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if(textField == self.idCordText){
        //禁止用户输入字母
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789xX"];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c]) {
                return NO;
            }
        }
    }
    
    
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
