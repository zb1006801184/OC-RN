//
//  OFFCodeViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "OFFCodeViewController.h"
#import "LBXScanWrapper.h"
#import "OFFMoneryViewController.h"
#import "OrderViewController.h"
@interface OFFCodeViewController ()
//@property (nonatomic,strong)NSString *signStr;
//@property (nonatomic,strong)NSString *userIDStr;
@end

@implementation OFFCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"收款" isBack:YES];
    [self getSign];
}

- (void)getSign
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userID = [NSString stringWithFormat:@"%@",[user objectForKey:UserID]];
    NSDictionary *params = @{@"userId":userID};
    [QJGlobalControl sendGETWithUrl:getOnlySign parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"🍉 %@",data);
        if([data[@"code"]integerValue] == 200){
            NSDictionary *dic = data[@"data"];
            NSString *sign = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"sign"])];
            NSString *userIDStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"userId"])];

            [self setUISignStr:sign userIDStr:userIDStr];
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}
- (void)setUISignStr:(NSString *)signStr userIDStr:(NSString *)userIDstr
{
    UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 22)];
    bottomLabel. text = @"会员扫一扫，向我付款";
    bottomLabel.font = [UIFont systemFontOfSize:13];
    bottomLabel.textColor = [UIColor blackColor];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bottomLabel];
    
    UIImageView *codeImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2, bottomLabel.bottom + 10, 200, 200)];
    [self.view addSubview:codeImage];
    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *shopID = [NSString stringWithFormat:@"%@",[user objectForKey:LoginId]];
//    NSString *userID = [NSString stringWithFormat:@"%@",[user objectForKey:UserID]];
    NSMutableDictionary *messageDic = [NSMutableDictionary dictionary];
    
//    [messageDic setObject:shopID forKey:@"shopID"];
    [messageDic setObject:userIDstr forKey:@"userId"];
    [messageDic setObject:signStr forKey:@"sign"];
//    [messageDic setObject:@"" forKey:@"money"];
    
    NSData *dataFriends = [NSJSONSerialization dataWithJSONObject:messageDic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:dataFriends
                            
                                                 encoding:NSUTF8StringEncoding];
    
    
    UIImage *cimage = [LBXScanWrapper createQRWithString:jsonString size:CGSizeMake(200, 200)];
    
    codeImage.image = cimage;
    
    
//    UIButton *setBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2, codeImage.bottom, 100, 40)];
//    setBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    [setBtn setTitle:@"设置金额" forState:UIControlStateNormal];
//    [setBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [setBtn addTarget:self action:@selector(setMoneryAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:setBtn];
    
    
    UIButton *orderBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, codeImage.bottom, 100, 40)];//CGRectMake(setBtn.right, codeImage.bottom, 100, 40)
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [orderBtn setTitle:@"订单记录" forState:UIControlStateNormal];
    [orderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(orderAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:orderBtn];
    
    //    [self cheakPayState];
}

//#pragma mark - 查询是否付款成功
- (void)cheakPayState{
    
//    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0/*延迟执行时间*/ * NSEC_PER_SEC));
//    
//    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//        
//        NSString *url = [NSString stringWithFormat:@"%@/%@",getPayStyle,self.signStr];
//        [QJGlobalControl sendGETWithUrl:url parameters:nil success:^(id data) {
//            [JHHJView hideLoading];
//            NSLog(@"🍉 %@",data);
//            if([data[@"code"]integerValue] == 200){
//                NSString *dataStr = [NSString stringWithFormat:@"%@",data[@"data"]];
//                if([dataStr intValue] == 2){
//                    PaySureController *ctrl = [[PaySureController alloc]init];
//                    [self creatNav:ctrl title:@"支付成功"];
//                    [self.navigationController pushViewController:ctrl animated:YES];
//                    
//                }else if([dataStr intValue] == 3){
//                    [ALToastView toastInView:self.view withText:data[@"message"]];
//                    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
//                    
//                    dispatch_after
//                    (delayTime, dispatch_get_main_queue(),
//                     ^{
//                         [self.navigationController popToRootViewControllerAnimated:YES];
//                         
//                         
//                     }
//                     );
//                    
//                }else{
//                    
//                    [self cheakPayState];
//                    
//                    
//                }
//                
//            }else{
//                [self cheakPayState];
//            }
//            
//            
//        } fail:^(NSError *error) {
//            NSLog(@"是否付款成功：%@",error);
//            [self cheakPayState];
//        }];
//        
//        
//        
//    });
//    
    
    
}

#pragma mark - 设置金额
- (void)setMoneryAction
{
    OFFMoneryViewController *vipVC = [[OFFMoneryViewController alloc]init];
    
    [self.navigationController pushViewController:vipVC animated:YES];
}
- (void)orderAction
{
    //订单记录
    OrderViewController *ctrl = [[OrderViewController alloc]init];
    
    [self.navigationController pushViewController:ctrl animated:YES];
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
