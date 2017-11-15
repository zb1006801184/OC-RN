//
//  BaseViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/14.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "BaseViewController.h"
#import "MainViewController.h"
@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setHidden:YES];
    
    self.merchantId = [[NSUserDefaults standardUserDefaults]objectForKey:LoginId];

    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)])
    {
        
        NSArray *list = self.navigationController.navigationBar.subviews;
        
        for (id obj in list)
        {
            
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
            {//10.0的系统字段不一样
                UIView *view =   (UIView*)obj;
                for (id obj2 in view.subviews) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]])
                    {
                        
                        UIImageView *image =  (UIImageView*)obj2;
                        image.hidden = YES;
                    }
                }
            }
        }
    }
    
    
}


- (void)setNavBarWithTitle:(NSString *)titleLab isBack:(BOOL)back {
    
    self.navBarView  = [[UIView alloc] initWithFrame:CGRectMake(0, STATUSBAHeight, SCREEN_WIDTH, NAVHeight)];
    self.navBarView.backgroundColor = BACKGROUNGCOLOR;
    
    [self.view addSubview:self.navBarView];
    
    UILabel *titlab = [[UILabel alloc] initWithFrame:CGRectMake(42, 0, SCREEN_WIDTH,NAVHeight)];
    titlab.font = [UIFont systemFontOfSize:14];
    titlab.textColor = [UIColor whiteColor];
    titlab.textAlignment = NSTextAlignmentLeft;
    titlab.text = titleLab;
    [self.navBarView addSubview:titlab];
    
    if (back == YES) {
        
        UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 11, 22, 22)];
        backImg.image = [UIImage imageNamed:@"nav_icon"];
        [self.navBarView addSubview:backImg];
        
        UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBut setFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, NAVHeight)];
        [backBut addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.navBarView addSubview:backBut];
        
    }
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
//    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [self.navBarView addSubview:lineView];
    
}

- (void)backButtonAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//点击空白收起键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    
    [theTextField resignFirstResponder];
    
    return YES;
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
