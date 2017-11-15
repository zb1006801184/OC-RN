//
//  MoneryCodeViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "MoneryCodeViewController.h"
#import "OrderViewController.h"
#import "LBXScanWrapper.h"
@interface MoneryCodeViewController ()

@end

@implementation MoneryCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"收款" isBack:YES];
    UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 22)];
    bottomLabel. text = @"会员扫一扫，向我付款";
    bottomLabel.font = [UIFont systemFontOfSize:13];
    bottomLabel.textColor = [UIColor blackColor];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bottomLabel];
    
    UIImageView *codeImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2, bottomLabel.bottom + 10, 200, 200)];
    [self.view addSubview:codeImage];
    
    NSMutableDictionary *messageDic = [NSMutableDictionary dictionary];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *userID = [NSString stringWithFormat:@"%@",[user objectForKey:UserID]];
    [messageDic setObject:self.moneryStr forKey:@"money"];
    [messageDic setObject:self.orderStr forKey:@"shopID"];
    [messageDic setObject:userID forKey:@"userId"];
    [messageDic setObject:self.signStr forKey:@"sign"];
    
    NSData *dataFriends = [NSJSONSerialization dataWithJSONObject:messageDic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:dataFriends
                            
                                                 encoding:NSUTF8StringEncoding];
    
    UIImage *cimage = [LBXScanWrapper createQRWithString:jsonString size:CGSizeMake(200, 200)];
    codeImage.image = cimage;
    
    UILabel *moneryLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, codeImage.bottom, SCREEN_WIDTH, 40)];
    moneryLabel. text = [NSString stringWithFormat:@"¥%@",self.moneryStr];
    moneryLabel.font = [UIFont systemFontOfSize:24];
    moneryLabel.textColor = BACKGROUNGCOLOR;
    moneryLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:moneryLabel];
    
    UIButton *cleanBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2, moneryLabel.bottom, 100, 40)];
    cleanBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [cleanBtn setTitle:@"清除金额" forState:UIControlStateNormal];
    [cleanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cleanBtn addTarget:self action:@selector(CleanAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cleanBtn];
    
    
    UIButton *orderBtn = [[UIButton alloc]initWithFrame:CGRectMake(cleanBtn.right, moneryLabel.bottom, 100, 40)];
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [orderBtn setTitle:@"订单记录" forState:UIControlStateNormal];
    [orderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(orderAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:orderBtn];
    
    //    [self cheakPayState];
    
}
#pragma mark - 查询是否付款成功
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
//                    [self cheakPayState];
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
- (void)CleanAction
{
    int index = (int)[[self.navigationController viewControllers]indexOfObject:self]; [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -2)] animated:YES];
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
