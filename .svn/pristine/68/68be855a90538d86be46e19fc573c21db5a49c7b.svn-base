//
//  AddClassViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/27.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "AddClassViewController.h"

@interface AddClassViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *detailsText;
@end

@implementation AddClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:self.styleStr isBack:YES];
    self.view.backgroundColor = RGB_COLOR(239, 239, 239);
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, 50)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(10, 0, 90, bgView.height) backColor:[UIColor clearColor] text:self.styleStr textColor:[UIColor blackColor] font:Font(13) textAlignment:NSTextAlignmentCenter numOnLines:1];
    [bgView addSubview:tsLabel];
    
    UIView *detailsView = [[UIView alloc]initWithFrame:CGRectMake(tsLabel.right + 10, (bgView.height -  SCALE_HEIGHT(30))/2, SCREEN_WIDTH - tsLabel.width - 90, SCALE_HEIGHT(30))];
    detailsView.layer.borderWidth = 1;
    detailsView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    detailsView.layer.cornerRadius = 5;
    [bgView addSubview:detailsView];
    
    self.detailsText = [JQXCustom creatTextFiled:CGRectMake(10, 0, detailsView.width - 20, detailsView.height) placeholder:@"请输入新的分类"];
    [self.detailsText becomeFirstResponder];
    self.detailsText.delegate = self;
    self.detailsText.textAlignment = NSTextAlignmentLeft;
    [detailsView addSubview:self.detailsText];
    [self.detailsText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];

    if([self.styleStr isEqualToString:@"编辑商品分类"]||[self.styleStr isEqualToString:@"编辑餐位分类"]){
        self.detailsText.text = self.classStr;
    }
    [self setNAVRight];
}

- (void)setNAVRight
{
    UIButton *finashButton = [JQXCustom creatButton:CGRectMake(SCREEN_WIDTH - 60, 0, 60, 44) backColor:[UIColor clearColor]  text:@"完成" textColor:[UIColor whiteColor] font:Font(14) addTarget:self Action:@selector(finashAction)];
    [self.navBarView addSubview:finashButton];

}
#pragma mark - 完成
- (void)finashAction
{
    [self.view endEditing:YES];
    //判断是否全是空格 或者没输入
    if([[self.detailsText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0){
        
        [ALToastView toastInView:self.view withText:@"请输入正确分类名称"];
        
    }else{
        if([self.styleStr isEqualToString:@"编辑商品分类"]||[self.styleStr isEqualToString:@"编辑餐位分类"]){
            //编辑分类
            [JHHJView showLoadingOnTheKeyWindowWithType:2];
            
            NSDictionary *params = @{@"id":self.idStr,@"typeName":self.detailsText.text};
            [QJGlobalControl sendGETWithUrl:JQXHttp_EditClass parameters:params success:^(id data) {
                [JHHJView hideLoading];
                NSLog(@"data =====   %@",data);
                if([data[@"code"] integerValue] == 200){
                    
                    [ALToastView toastInView:self.view withText:@"修改分类成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else{
                    [ALToastView toastInView:self.view withText:data[@"message"]];
                    
                }
                
                
            } fail:^(NSError *error) {
                [JHHJView hideLoading];
                [ALToastView toastInView:self.view withText:@"请求失败"];
            }];

            
        }else{
            //添加分类
            [JHHJView showLoadingOnTheKeyWindowWithType:2];
            
            NSString *type = [NSString stringWithFormat:@""];
            if([self.styleStr isEqualToString:@"添加商品分类"]){
                type = @"0";
            }else{
                type = @"1";
            }
            NSDictionary *params = @{@"merchantId":self.merchantId,@"typeName":self.detailsText.text,@"type":type};
            [QJGlobalControl sendGETWithUrl:JQXHttp_AddClass parameters:params success:^(id data) {
                [JHHJView hideLoading];
                NSLog(@"data =====   %@",data);
                if([data[@"code"] integerValue] == 200){
                    
                    [ALToastView toastInView:self.view withText:@"添加分类成功"];
                    
                    dispatch_time_t delayTime = dispatch_time
                    (DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
                    
                    dispatch_after
                    (delayTime, dispatch_get_main_queue(),
                     ^{
                         [self.navigationController popViewControllerAnimated:YES];
                         
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"JQXClassListData" object:nil userInfo:@{@"styleStr":self.styleStr}];
                     }
                     );
                    
                }else{
                    [ALToastView toastInView:self.view withText:data[@"message"]];
                }
                
                
            } fail:^(NSError *error) {
                [JHHJView hideLoading];
                [ALToastView toastInView:self.view withText:@"请求失败"];
            }];
        }
    }

}
- (void)TextChange:(UITextField *)textFiled
{
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textFiled.text options:0 range:NSMakeRange(0, textFiled.text.length) withTemplate:@""];
    
    
    if (![noEmojiStr isEqualToString:textFiled.text]) {
        
        textFiled.text = noEmojiStr;
        
    }
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //不支持系统表情的输入
    if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
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
