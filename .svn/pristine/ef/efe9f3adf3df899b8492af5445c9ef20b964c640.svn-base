//
//  EditBankViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "EditBankViewController.h"

@interface EditBankViewController ()
@property (nonatomic,strong)UITextField *cardText;
@property (nonatomic,strong)UITextField *bankText;
@end

@implementation EditBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"编辑银行卡" isBack:YES];
    
    UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 60)];
    bigView.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f];
    [self.view addSubview:bigView];
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 40)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [bigView addSubview:whiteView];
    
    //账号
    UILabel *telLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, whiteView.width, whiteView.height)];
    NSString *realName = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:RealName]];
    NSString *hiddenStr = realName;
    hiddenStr = [NSString stringWithFormat:@"*%@",[realName substringFromIndex:1]];
    

    
    telLabel.text = [NSString stringWithFormat:@"账户：%@",hiddenStr];
    telLabel.font = [UIFont systemFontOfSize:14];
    [whiteView addSubview:telLabel];
    
    //银行卡号
    UIView *pwdView = [[UIView alloc]initWithFrame:CGRectMake(30, bigView.bottom + 10, SCREEN_WIDTH - 60, 45)];
    pwdView.layer.borderWidth = 1.5;
    pwdView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.view addSubview:pwdView];
    
    UILabel *tsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, pwdView.height)];
    tsLabel.text = @"银行卡号";
    tsLabel.font = [UIFont systemFontOfSize:14];
    [pwdView addSubview:tsLabel];
    
    self.cardText = [[UITextField alloc]initWithFrame:CGRectMake(tsLabel.right + 10, 0, pwdView.width - tsLabel.width - 30, pwdView.height)];
    self.cardText.textAlignment = NSTextAlignmentRight;
    self.cardText.placeholder = @"请点击输入您的银行卡号";
    [self.cardText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    self.cardText.keyboardType = UIKeyboardTypeNumberPad;
    self.cardText.font = [UIFont systemFontOfSize:13];
    [pwdView addSubview:self.cardText];
    
    //所属银行
    UIView *againView = [[UIView alloc]initWithFrame:CGRectMake(30, pwdView.bottom + 10, SCREEN_WIDTH - 60, 45)];
    againView.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f];
    [self.view addSubview:againView];
    
    UILabel *tsLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, againView.height)];
    tsLabel2.text = @"所属银行";
    tsLabel2.font = [UIFont systemFontOfSize:14];
    [againView addSubview:tsLabel2];
    
    self.bankText = [[UITextField alloc]initWithFrame:CGRectMake(tsLabel.right + 10, 0, againView.width - tsLabel2.width - 30, againView.height)];
    self.bankText.userInteractionEnabled = NO;
    self.bankText.textAlignment = NSTextAlignmentRight;
    self.bankText.textColor = [UIColor whiteColor];
    self.bankText.font = [UIFont systemFontOfSize:13];
    self.bankText.text = @"自动获取";
    [againView addSubview:self.bankText];
    
    
    UIButton *sumbitButton = [[UIButton alloc]initWithFrame:CGRectMake(60, againView.bottom + 20 , SCREEN_WIDTH - 120, 40)];
    sumbitButton.backgroundColor = BACKGROUNGCOLOR;
    sumbitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    sumbitButton.layer.masksToBounds = YES;
    sumbitButton.layer.cornerRadius = 5;
    [sumbitButton setTitle:@"绑     定" forState:UIControlStateNormal];
    [sumbitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sumbitButton addTarget:self action:@selector(sumbitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sumbitButton];
    
}
- (void)TextChange:(UITextField *)textFiled
{
    if (textFiled == self.cardText) {
        
        if(self.cardText.text.length == 7){
            [self GetBackNameData];
            
        }else if (self.cardText.text.length == 0){
            self.bankText.text  = @"自动获取";
        }
    }
}

#pragma mark - 修改
- (void)sumbitAction
{
    [self.cardText resignFirstResponder];
    
    if(self.cardText.text.length <= 14 &&[self.bankText.text isEqualToString:@"自动获取"]){
        
        [ALToastView toastInView:self.view withText:@"请输入正确银行卡号"];
        
    }else{
        NSString *nameStr = [[NSUserDefaults standardUserDefaults]objectForKey:RealName];
        NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:UserID];
        NSString *bankName =  self.bankText.text;
        NSString *bankID = self.cardText.text;
        NSString *telStr = [[NSUserDefaults standardUserDefaults]objectForKey:LoginPhone];
        NSDictionary *params = @{@"ownerName":nameStr,@"bankName":bankName,@"cardNo":bankID,@"telPhone":telStr,@"operator":self.type,@"userId":userID};
        [JHHJView showLoadingOnTheKeyWindowWithType:2];
        
        [QJGlobalControl sendPOSTWithUrl:httpBankURL parameters:params success:^(id data) {
            NSLog(@"data === %@",data);
            [JHHJView hideLoading];
            if([data[@"code"]integerValue] == 200){
                
                [ALToastView toastInView:self.view withText:@"绑定成功"];
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

#pragma mark - 根据银行卡号码获取银行卡信息
- (void)GetBackNameData
{
    NSDictionary *dic = @{@"cardNo":self.cardText.text};
    [QJGlobalControl sendPOSTWithUrl:httpBankName parameters:dic success:^(id data) {
        if([data[@"code"]integerValue] == 200){
            NSLog(@"data  ======  %@",data);
            self.bankText.text  = [NSString stringWithFormat:@"%@",data[@"data"][@"bankName"]];
        }else{
            [self.cardText resignFirstResponder];
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];

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
