//
//  RegisterMoneryViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/22.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "RegisterMoneryViewController.h"
#import "RegisterWebViewController.h"

@interface RegisterMoneryViewController ()
@property (nonatomic,strong)UITextField *phoneText;
@property (nonatomic,strong)UIButton *selectedButton;
@property (nonatomic,strong)UIButton *sumbitButton;
@property (nonatomic,strong)UIView *markView;
@end

@implementation RegisterMoneryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"申请商户" isBack:YES];
    
    
    UILabel *tsLable = [JQXCustom creatLabel:CGRectMake((SCREEN_WIDTH - 200)/2,64 + 150, 100, 40) backColor:[UIColor clearColor] text:@"我已阅读并同意" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter numOnLines:1];
    [self.view addSubview:tsLable];
    
    UIButton *serviceButton = [JQXCustom creatButton:CGRectMake(tsLable.right, 64 + 150 , 140, 40) backColor:[UIColor clearColor] text:@"《和火掌柜服务协议》" textColor:BACKGROUNGCOLOR font:[UIFont systemFontOfSize:13] addTarget:self Action:@selector(serviceAction)];
    [self.view addSubview:serviceButton];
//
    self.selectedButton = [JQXCustom creatButton:CGRectMake(tsLable.left - 40, 64 + 150 , 40, 40) backColor:[UIColor clearColor] text:@"" textColor:BACKGROUNGCOLOR font:[UIFont systemFontOfSize:13] addTarget:self Action:@selector(selectedAction:)];
    [self.selectedButton setImage:[UIImage imageNamed:@"ReService-s"] forState:UIControlStateNormal];
    self.selectedButton.tag = 100;
    [self.view addSubview:self.selectedButton];
    
    self.sumbitButton = [JQXCustom creatButton:CGRectMake(60, tsLable.bottom + 50 , SCREEN_WIDTH - 120, 40) backColor:BACKGROUNGCOLOR text:@"完成" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14] addTarget:self Action:@selector(sumbitAction)];
    
    self.sumbitButton.layer.masksToBounds = YES;
    self.sumbitButton.layer.cornerRadius = 5;
    
    [self.view addSubview:self.sumbitButton];
    
    
}
#pragma mark - 是否同意协议
- (void)selectedAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
            [self.selectedButton setImage:[UIImage imageNamed:@"ReService"] forState:UIControlStateNormal];
            self.selectedButton.tag = 101;
            break;
        case 101:
            [self.selectedButton setImage:[UIImage imageNamed:@"ReService-s"] forState:UIControlStateNormal];
            self.selectedButton.tag = 100;//tag == 100时同意服务协议
            break;
            
        default:
            break;
    }
}
#pragma mark - 注册协议
- (void)serviceAction
{
    RegisterWebViewController *vc = [[RegisterWebViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - 注册
- (void)ReginsterActionData
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendPOSTWithUrl:http_ShopRegisterURL parameters:self.registerDic success:^(id data) {
        [JHHJView hideLoading];
        //        NSLog(@"🍊🍊🍊 ========%@",data);
        if([data[@"code"] integerValue] == 200){
            [ALToastView toastInView:self.view withText:@"在24小时内，会有业务员上门审核"];

            [self TSMarkView];

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
- (NSMutableDictionary *)registerDic
{
    if(!_registerDic){
        _registerDic = [NSMutableDictionary dictionary];
    }
    return _registerDic;
}
#pragma mark - 完成按钮点击事件
- (void)sumbitAction
{
    if(self.selectedButton.tag == 100){
        self.sumbitButton.userInteractionEnabled = NO;
        [self ReginsterActionData];
    }
    
}
#pragma mark - 提示View创建
- (void)TSMarkView
{
    self.markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.markView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    [self.view addSubview:self.markView];
    
    UIView *tsView = [[UIView alloc]initWithFrame:CGRectMake(30, SCALE_HEIGHT(150), SCREEN_WIDTH - 60, SCALE_HEIGHT(150))];

    tsView.backgroundColor = [UIColor whiteColor];
    [self.markView addSubview:tsView];
    
    UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(30, 20, tsView.width - 60, 15) backColor:[UIColor clearColor] text:@"您的登录账号为：" textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentLeft numOnLines:0];
    [tsView addSubview:tsLabel];
    
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults]objectForKey:LoginRegistphone];
    UILabel *telPhone = [JQXCustom creatLabel:CGRectMake(30, tsLabel.bottom + 20, tsView.width - 60, 15) backColor:[UIColor clearColor] text:phoneStr textColor:[UIColor colorWithHexString:@"#888889"] font:Font(15) textAlignment:NSTextAlignmentCenter numOnLines:0];
    [tsView addSubview:telPhone];
    
    UILabel *tsLabel2 = [JQXCustom creatLabel:CGRectMake(30, telPhone.bottom + 10, tsView.width - 60, 15) backColor:[UIColor clearColor] text:@"[请牢记]" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(15) textAlignment:NSTextAlignmentCenter numOnLines:0];
    [tsView addSubview:tsLabel2];
    
    
    UIButton *sureButton = [JQXCustom creatButton:CGRectMake((tsView.width - 80)/2, tsLabel2.bottom + 30, 80, 40) backColor:BACKGROUNGCOLOR text:@"确定" textColor:[UIColor whiteColor] font:Font(13) addTarget:self Action:@selector(SureAction)];
    sureButton.layer.masksToBounds = YES;
    sureButton.layer.cornerRadius = 8;
    [tsView addSubview:sureButton];
    [tsView setHeight:sureButton.bottom + 20];
    
}
#pragma mark - 确定按钮点击事件
- (void)SureAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
