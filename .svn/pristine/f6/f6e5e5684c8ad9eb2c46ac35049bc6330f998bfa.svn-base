//
//  PaySuccessViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "PaySuccessViewController.h"

@interface PaySuccessViewController ()

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    UIImageView *mainImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 150)/2, 150, 150, 150)];
    mainImg.image = [UIImage imageNamed:@"orderpaysure"];
    [self.view addSubview:mainImg];
    
    NSString *allStr = [NSString stringWithFormat:@"已成功支付¥ %@",self.moneryStr];
    UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(0, mainImg.bottom + 10, SCREEN_WIDTH, 40) backColor:[UIColor clearColor] text:allStr textColor:BACKGROUNGCOLOR font:[UIFont systemFontOfSize:20] textAlignment:NSTextAlignmentCenter numOnLines:1];
    [self.view addSubview:tsLabel];
    
    UILabel *tsLabel2 = [JQXCustom creatLabel:CGRectMake(0, tsLabel.bottom, SCREEN_WIDTH, 40) backColor:[UIColor clearColor] text:@"页面跳转中..." textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter numOnLines:1];
    [self.view addSubview:tsLabel2];
    
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC));
    dispatch_after
    (delayTime, dispatch_get_main_queue(),
     ^{
         [self.navigationController popToRootViewControllerAnimated:YES];
         
     }
     );

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
