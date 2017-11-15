//
//  BindingPhoneViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/10/17.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "BindingPhoneViewController.h"
#import "OnMoneryViewController.h"
@interface BindingPhoneViewController ()
@property (nonatomic,strong)UITextField *phoneText;
@end

@implementation BindingPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"绑定手机号" isBack:YES];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(20, 94, SCREENSIZE.width - 40, SCALE_HEIGHT(50))];
    bgView.layer.borderColor= BACKGrayColor.CGColor;
    bgView.layer.borderWidth = 1.5;
    [self.view addSubview:bgView];
    
    self.phoneText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, bgView.width - 10, bgView.height)];
    self.phoneText.placeholder = @"请输入绑定手机号";
    self.phoneText.font = [UIFont systemFontOfSize:14];
    self.phoneText.keyboardType = UIKeyboardTypeNumberPad;
    [bgView addSubview:self.phoneText];
    
    if([self.styleStr isEqualToString:@"不是会员"]){
        NSString *tsStr = @"注：该手机号还不是平台用户";
        CGFloat tsH = [tsStr CallateLabelSizeHeight:[UIFont systemFontOfSize:12] lineWidth:SCREEN_WIDTH - 40];
        UILabel *tsLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, bgView.bottom + 10, SCREEN_WIDTH - 40, tsH)];
        tsLabel.text = tsStr;
        tsLabel.font = [UIFont systemFontOfSize:13];
        tsLabel.textColor = BACKGROUNGCOLOR;
        tsLabel.numberOfLines = NSTextAlignmentLeft;
        [self.view addSubview:tsLabel];
    }
    
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, bgView.bottom + 50, self.view.frame.size.width - 80, SCALE_HEIGHT(40))];
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 5;
    loginBtn.backgroundColor = BACKGROUNGCOLOR;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}
#pragma mark - 下一步
- (void)sureClick
{
    [self.view endEditing:YES];
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
//    NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:MemberPhone];
    NSDictionary *params = @{@"memberPhone":self.phoneText.text};
    
    [QJGlobalControl sendPOSTWithUrl:JQXBindingPhone parameters:params success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"] integerValue] == 200){
            OnMoneryViewController *ctrl = [[OnMoneryViewController alloc]init];
            ctrl.proTelPhone = self.phoneText.text;
            ctrl.styleStr = @"线下付";
            [self.navigationController pushViewController:ctrl animated:YES];
        }else{
    
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
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
