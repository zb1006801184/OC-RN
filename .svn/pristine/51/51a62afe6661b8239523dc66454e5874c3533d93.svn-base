//
//  BindingPhoneSuccessController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/10/17.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "BindingPhoneSuccessController.h"
#import "OnMoneryViewController.h"
@interface BindingPhoneSuccessController ()

@end

@implementation BindingPhoneSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"绑定手机号" isBack:YES];
    
    UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(20, self.navBarView.bottom, SCREEN_WIDTH - 40, 40) backColor:[UIColor clearColor] text:@"已绑定手机号" textColor:[UIColor blackColor] font:Font(18) textAlignment:NSTextAlignmentLeft numOnLines:1];
    [self.view addSubview:tsLabel];
    
    NSString *str = self.proTelPhone;
    if(str.length == 11 || str.length == 13){
        str = [NSString stringWithFormat:@"%@****%@",[str substringToIndex:3],[str substringFromIndex:7]];
    }
    
    UILabel *phoneLabel = [JQXCustom creatLabel:CGRectMake(20, tsLabel.bottom, SCREEN_WIDTH - 40, 20) backColor:[UIColor clearColor] text:str textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentLeft numOnLines:1];
    [self.view addSubview:phoneLabel];
    
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, phoneLabel.bottom + 50, self.view.frame.size.width - 80, SCALE_HEIGHT(40))];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.layer.masksToBounds = YES;
    nextBtn.layer.cornerRadius = 5;
    nextBtn.backgroundColor = BACKGROUNGCOLOR;
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
}
- (void)nextAction{
    
    OnMoneryViewController *vc = [[OnMoneryViewController alloc]init];
    vc.styleStr = @"线下付";
    vc.proTelPhone = self.proTelPhone;
    [self.navigationController pushViewController:vc animated:YES];
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
