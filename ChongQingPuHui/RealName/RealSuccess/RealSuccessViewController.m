//
//  RealSuccessViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "RealSuccessViewController.h"

@interface RealSuccessViewController ()

@end

@implementation RealSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"认证详情" isBack:NO];
    [self setLeftNavButton];
    self.view.backgroundColor = BACKGrayColor;
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, 180)];
    img.image = [UIImage imageNamed:@"jqxBGImg"];
    [self.view addSubview:img];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, img.height)];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"您已通过实名认证";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    NSArray *titleArr = @[@"真实姓名",@"身份证号"];
    
    NSString *nameStr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:RealName]];
    NSString *hiddenStr = nameStr;
    hiddenStr = [NSString stringWithFormat:@"*%@",[nameStr substringFromIndex:1]];

    
    NSString *iDStr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:idCardNo]];
    NSString *IDCardStr = iDStr;
    if(iDStr.length == 18){
        IDCardStr = [NSString stringWithFormat:@"%@**********%@",[iDStr substringToIndex:4],[iDStr substringFromIndex:14]];
    }
    
    NSArray *contentArray = @[hiddenStr,IDCardStr];
    for (int i = 0; i < titleArr.count; i ++) {
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, img.bottom + (i + 1)*10 +i *40, SCREEN_WIDTH, 40)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
        
        UILabel *tsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, bgView.height)];
        tsLabel.text = titleArr[i];
        tsLabel.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:tsLabel];
        
        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(tsLabel.right + 10, 0, SCREEN_WIDTH - tsLabel.width - 30, bgView.height)];
        contentLabel.text = contentArray[i];
        contentLabel.textAlignment = NSTextAlignmentRight;
        contentLabel.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:contentLabel];
        
    }

}
- (void)setLeftNavButton
{
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 11, 22, 22)];
    backImg.image = [UIImage imageNamed:@"nav_icon"];
    [self.navBarView addSubview:backImg];
    
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 44)];
    [backBut addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView addSubview:backBut];
}
- (void)backButtonAction
{
    if([self.styleStr isEqualToString:@"直接跳转认证详情"]){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
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
