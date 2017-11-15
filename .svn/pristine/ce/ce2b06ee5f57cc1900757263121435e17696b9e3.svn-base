//
//  VoiceSettingViewController.m
//  ChongQingPuHui
//
//  Created by zll on 2017/11/1.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "VoiceSettingViewController.h"

@interface VoiceSettingViewController ()

@end

@implementation VoiceSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"语音提示" isBack:YES];
    self.view.backgroundColor = BACKGrayColor;
    NSArray *titleArray = @[@"预定订单语音提示",@"付款订单语音提示"];
    for (int i = 0; i < titleArray.count; i ++) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,self.navBarView.bottom + (i + 1) *10 + i * 45, SCREEN_WIDTH, 45)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
        
        
        UILabel *tsLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, bgView.height)];
        tsLabel.font = [UIFont systemFontOfSize:13];
        tsLabel.textAlignment = NSTextAlignmentLeft;
        tsLabel.text = titleArray[i];
        [bgView addSubview:tsLabel];
        
//        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 13.5, 18, 18)];
//        img.image = [UIImage imageNamed:@"me_more"];
//        [bgView addSubview:img];
//
//        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, bgView.width, bgView.height)];
//        button.tag = 100 + i;
//        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [bgView addSubview:button];

        
        UISwitch *Sw = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 65, 6, 30,33 )];
        Sw.tag = 100 + i;
        Sw.onTintColor = BACKGROUNGCOLOR;
//        [ZLLModelTool setNormol:@"no" forkey:@"yuding"];
//        [ZLLModelTool setNormol:@"yes" forkey:@"fukuan"];

        if (i == 0) {
            if ([[ZLLModelTool getNormolWithKey:@"yuding"] isEqualToString:@"yes"]) {
                Sw.on = YES;

            }else{
                Sw.on = NO;

            }
        }else{
            if ([[ZLLModelTool getNormolWithKey:@"fukuan"] isEqualToString:@"yes"]) {
                Sw.on = YES;
                
            }else{
                Sw.on = NO;
                
            }
        }
        [bgView addSubview:Sw];
        [Sw addTarget:self action:@selector(swClick:) forControlEvents:UIControlEventValueChanged];
        
    }
    
}
-(void) swClick:(UISwitch *)sender{
    if (sender.tag == 100) {//预定订单语音提示
        if (sender.on == YES) {
            [ZLLModelTool setNormol:@"yes" forkey:@"yuding"];

        }else{
            [ZLLModelTool setNormol:@"no" forkey:@"yuding"];

        }
    }else  if (sender.tag == 101) {//付款订单语音提示
        if (sender.on == YES) {
            [ZLLModelTool setNormol:@"yes" forkey:@"fukuan"];
            
        }else{
            [ZLLModelTool setNormol:@"no" forkey:@"fukuan"];
            
        }
        
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
