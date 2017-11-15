//
//  OFFMoneryViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "OFFMoneryViewController.h"
#import "MoneryCodeViewController.h"//付款二维码
@interface OFFMoneryViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *rightTextField;

@end

@implementation OFFMoneryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"输入付款金额" isBack:YES];
    [self setUI];
}

- (void)setUI{
    
    UIView *bkView = [[UIView alloc]init];
    bkView.frame = CGRectMake(20, 84, SCREEN_WIDTH - 40, SCALE_HEIGHT(50));
    bkView.backgroundColor = [UIColor whiteColor];
    bkView.layer.masksToBounds=YES;
    bkView.layer.borderWidth = 1.5;
    bkView.layer.borderColor = BACKGrayColor.CGColor;
    [self.view addSubview:bkView];
    
    
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, SCALE_HEIGHT(50))];
    leftLabel. text = @"付款总额";
    leftLabel.font = [UIFont systemFontOfSize:14];
    leftLabel.textColor = [UIColor blackColor];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    [bkView addSubview:leftLabel];
    
    
    self.rightTextField = [[UITextField alloc]initWithFrame:CGRectMake(90, 0, bkView.frame.size.width - 100, SCALE_HEIGHT(50))];
    self.rightTextField.placeholder = @"点击输入金额";
    self.rightTextField.delegate = self;
    self.rightTextField.tag = 100;
    self.rightTextField.textAlignment = NSTextAlignmentRight;
    self.rightTextField.font = [UIFont systemFontOfSize:14];
    self.rightTextField.keyboardType = UIKeyboardTypeDecimalPad;//UIKeyboardTypeDecimalPad带小数点
//    [self.rightTextField addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [bkView addSubview:self.rightTextField];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, bkView.bottom + 20, self.view.frame.size.width - 80, SCALE_HEIGHT(40))];
    [loginBtn setTitle:@"确定" forState:UIControlStateNormal];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 5;
    loginBtn.backgroundColor = BACKGROUNGCOLOR;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}
#pragma mark - 确定按钮
- (void)sureClick
{
    [self.rightTextField resignFirstResponder];
    
    if([self.rightTextField.text floatValue] == 0 || self.rightTextField.text.length == 0){
        [ALToastView toastInView:self.view withText:@"请输入正确金额"];
    }else{
        

        [JHHJView showLoadingOnTheKeyWindowWithType:2];
        [QJGlobalControl sendGETWithUrl:getOnlySign parameters:nil success:^(id data) {
            [JHHJView hideLoading];
            NSLog(@"🍉 %@",data);
            if([data[@"code"]integerValue] == 200){
                NSString *str = [NSString stringWithFormat:@"%@",data[@"data"]];
                
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSString *shopID = [NSString stringWithFormat:@"%@",[user objectForKey:LoginId]];
                MoneryCodeViewController *codeVC = [[MoneryCodeViewController alloc]init];
                codeVC.moneryStr = self.rightTextField.text;
                codeVC.signStr = str;
                codeVC.orderStr = shopID;
                [self.navigationController pushViewController:codeVC animated:YES];
            }else{
                [ALToastView toastInView:self.view withText:data[@"message"]];
            }

        } fail:^(NSError *error) {
            [JHHJView hideLoading];
            [ALToastView toastInView:self.view withText:@"请求失败"];

        }];
        
        
        
    }
      
        
}
#pragma mark - 限制
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.rightTextField) {
        
        
        NSScanner      *scanner    = [NSScanner scannerWithString:string];
        NSCharacterSet *numbers;
        NSRange         pointRange = [textField.text rangeOfString:@"."];
        
        if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) )
        {
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        }
        else
        {
            numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
        }
        
        if ( [textField.text isEqualToString:@""] && [string isEqualToString:@"."] )
        {
            return NO;
        }
        
        if ( range.location > 9  )
        {
            return NO;
        }
        
        short remain = 2;
        
        NSString *tempStr = [textField.text stringByAppendingString:string];
        NSUInteger strlen = [tempStr length];
        if(pointRange.length > 0 && pointRange.location > 0){ //判断输入框内是否含有“.”。
            if([string isEqualToString:@"."]){ //当输入框内已经含有“.”时，如果再输入“.”则被视为无效。
                return NO;
            }
            if(strlen > 0 && (strlen - pointRange.location) > remain+1){ //当输入框内已经含有“.”，当字符串长度减去小数点前面的字符串长度大于需要要保留的小数点位数，则视当次输入无效。
                return NO;
            }
            
        }
        
        NSRange zeroRange = [textField.text rangeOfString:@"0"];
        if(zeroRange.length == 1 && zeroRange.location == 0){ //判断输入框第一个字符是否为“0”
            if(![string isEqualToString:@"0"] && ![string isEqualToString:@"."] && [textField.text length] == 1){ //当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
                textField.text = string;
                return NO;
            }else{
                if(pointRange.length == 0 && pointRange.location > 0){ //当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
                    if([string isEqualToString:@"0"]){
                        return NO;
                    }
                }
            }
        }
        
        
        NSString *buffer;
        if ( ![scanner scanCharactersFromSet:numbers intoString:&buffer] && ([string length] != 0) )
        {
            return NO;
        }
        
    }
    //限制峰值5万
//    NSLog(@".第一次...%@",self.pricTextFild.text);
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"..text.%@",text);
    if ([text floatValue] > 999999) {
        textField.text = @"999999";
        [self.rightTextField resignFirstResponder];
        [ALToastView toastInView:self.view withText:@"最大金额为999999元"];
    }
    
    return YES;
}

//编辑结束
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text floatValue] > 999999) {
        textField.text = @"999999";
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
