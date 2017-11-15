//
//  PayCodeViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/31.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "PayCodeViewController.h"
#import "MoneryCodeViewController.h"
#import "PhoneViewController.h"
#import "OFFCodeViewController.h"
@interface PayCodeViewController ()
{
    int type;
}
@end

@implementation PayCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"选择支付方式" isBack:YES];
    type = 1;
    
    NSArray *titleArr = @[@"和火扫码付",@"远程支付"];
    for (int i = 0; i <2; i ++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 64 + 30 + i*40 + i *10, 40, 40)];
        [button setImage:[UIImage imageNamed:@"radio_unchecked"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"radio_checked"] forState:UIControlStateSelected];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        if(i == 0){
            button.selected = YES;
        }
        [self.view addSubview:button];
        
        UILabel *label = [JQXCustom creatLabel:CGRectMake(button.right, 64 + 30 + i*40 + i *10, 120, 40) backColor:[UIColor clearColor] text:titleArr[i] textColor:[UIColor blackColor] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:1];
        [self.view addSubview:label];
        
        
    }
    
    UIButton *payBtn = [[UIButton alloc]initWithFrame:CGRectMake(40,64 + 150, self.view.frame.size.width - 80, SCALE_HEIGHT(40))];
    payBtn.layer.masksToBounds = YES;
    payBtn.layer.cornerRadius = 5;
    [payBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payBtn.backgroundColor = BACKGROUNGCOLOR;
    [payBtn addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
}


- (void)buttonAction:(UIButton *)sender{
    UIButton *button = [UIButton new];
    
    for (int i = 0; i < 2; i++) {
        
        button = [self.view viewWithTag:100 + i];
        
        if (button.tag == sender.tag) {
            
            button.selected = YES;
            
        }else{
            
            button.selected = NO;
            
        }
        
        
    }
    
    NSLog(@"%ld",sender.tag);
    switch (sender.tag) {
        case 100:
             type = 1;
            break;
        case 101:
             type = 2;
            break;
            
        default:
            break;
    }


}

#pragma mark- 支付
-(void)payClick
{
    if(type == 1){ //快捷支付
        OFFCodeViewController *codeVC = [[OFFCodeViewController alloc]init];
        [self.navigationController pushViewController:codeVC animated:YES];
        
    }else{//远程支付
        
        PhoneViewController *phoneVC = [[PhoneViewController alloc]init];
        phoneVC.styleStr = @"远程支付";
        [self.navigationController pushViewController:phoneVC animated:YES];
        

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
