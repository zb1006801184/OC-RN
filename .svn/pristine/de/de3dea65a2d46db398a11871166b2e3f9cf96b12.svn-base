//
//  SetUpViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "SetUpViewController.h"
#import "LoginPwdViewController.h"
@interface SetUpViewController ()

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"设置" isBack:YES];
    self.view.backgroundColor = BACKGrayColor;
    NSArray *titleArray = @[@"登录密码",@"支付密码"];
    for (int i = 0; i < titleArray.count; i ++) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,self.navBarView.bottom + (i + 1) *10 + i * 45, SCREEN_WIDTH, 45)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
        
        
        UILabel *tsLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, bgView.height)];
        tsLabel.font = [UIFont systemFontOfSize:13];
        tsLabel.textAlignment = NSTextAlignmentLeft;
        tsLabel.text = titleArray[i];
        [bgView addSubview:tsLabel];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 13.5, 18, 18)];
        img.image = [UIImage imageNamed:@"me_more"];
        [bgView addSubview:img];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, bgView.width, bgView.height)];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];
        
        
    }

}

- (void)buttonAction:(UIButton *)sender
{
    if(sender.tag == 100){//登录密码
        LoginPwdViewController *loginVC = [[LoginPwdViewController alloc]init];
        loginVC.styleStr = @"修改登录密码";
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }else if (sender.tag == 101){//支付密码
        [self YesORNoPayPWD];
        
    }
}
//判断是否设置过支付密码
- (void)YesORNoPayPWD
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendGETWithUrl:http_YESORNOPayPwd parameters:nil success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"%@",data);
        LoginPwdViewController *loginVC = [[LoginPwdViewController alloc]init];
        
        
        if([data[@"code"]integerValue] == 200){
            loginVC.payPwdStr = @"设置了支付密码";
            loginVC.styleStr = @"修改支付密码";
        }else{
            loginVC.payPwdStr = @"未设置支付密码";
            loginVC.styleStr = @"设置支付密码";
        }
        [self.navigationController pushViewController:loginVC animated:YES];
        
        
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
