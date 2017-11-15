//
//  EditLabelViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/9/25.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "EditLabelViewController.h"

@interface EditLabelViewController ()<UITextFieldDelegate>
{
    CGFloat _subLen;
}
@property (nonatomic,strong)UITextField *tableText;
@property (nonatomic,strong)UITextField *meunText;
@property (nonatomic,strong)NSString *titleOneStr;
@property (nonatomic,strong)NSString *titleTwoStr;

@end

@implementation EditLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"修改标签名称" isBack:YES];
    [self setNAVRight];
    [self setDataShow];
}
- (void)setDataShow
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendPOSTWithUrl:JQXPagShow parameters:nil success:^(id data) {
        NSLog(@"data == %@",data);
        [JHHJView hideLoading];
        if([data[@"code"] integerValue] == 200){
            self.titleOneStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(data[@"data"][@"titelOne"])];
            self.titleTwoStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(data[@"data"][@"titelTwo"])];
            [self setMainUI];
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
}
#pragma mark - 主界面
- (void)setMainUI{
    
    UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(0, self.navBarView.bottom + 20, 80, 40) backColor:[UIColor clearColor] text:@"修改一" textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentCenter numOnLines:1];
    [self.view addSubview:tsLabel];
    
    self.tableText = [[UITextField alloc]initWithFrame:CGRectMake(tsLabel.right , tsLabel.top, SCREEN_WIDTH - 80 - 20, 40)];
    self.tableText.textColor = [UIColor blackColor];
    self.tableText.layer.borderWidth = 1;
    self.tableText.placeholder = @"最多可输入6个汉字";
    self.tableText.text = self.titleOneStr;
    self.tableText.delegate = self;
    self.tableText.layer.borderColor = RGB_COLOR(221, 221, 221).CGColor;
    self.tableText.textAlignment = NSTextAlignmentCenter;
    self.tableText.font = [UIFont systemFontOfSize:15];
    [self.tableText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.tableText];
    
    UILabel *tsLabel2 = [JQXCustom creatLabel:CGRectMake(0, tsLabel.bottom + 20, 80, 40) backColor:[UIColor clearColor] text:@"修改二" textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentCenter numOnLines:1];
    [self.view addSubview:tsLabel2];
    
    self.meunText = [[UITextField alloc]initWithFrame:CGRectMake(tsLabel2.right , tsLabel2.top, SCREEN_WIDTH - 80 - 20, 40)];
    self.meunText.text = self.titleTwoStr;
    self.meunText.delegate = self;
    self.meunText.placeholder = @"最多可输入6个汉字";
    self.meunText.textColor = [UIColor blackColor];
    self.meunText.layer.borderWidth = 1;
    self.meunText.layer.borderColor = RGB_COLOR(221, 221, 221).CGColor;
    self.meunText.textAlignment = NSTextAlignmentCenter;
    self.meunText.font = [UIFont systemFontOfSize:15];
    [self.meunText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.meunText];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(20, tsLabel2.bottom + 30, SCREEN_WIDTH - 40, SCREEN_WIDTH + 30)];
    img.image = [UIImage imageNamed:@"tsImage"];
    [self.view addSubview:img];
    
}
#pragma mark - 完成按钮
- (void)setNAVRight
{
    UIButton *finashButton = [JQXCustom creatButton:CGRectMake(SCREEN_WIDTH - 60, 0, 60, 44) backColor:[UIColor clearColor]  text:@"完成" textColor:[UIColor whiteColor] font:Font(14) addTarget:self Action:@selector(finashAction)];
    [self.navBarView addSubview:finashButton];
    
}
#pragma mark - 完成按钮点击事件
- (void)finashAction
{
    [self.view endEditing:YES];
    //判断全是空格
    if([[self.tableText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0 || [[self.meunText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0){
        [ALToastView toastInView:self.view withText:@"请输入正确信息"];
    }else{
        BOOL special = [QJGlobalControl isIncludeSpecialCharact:self.tableText.text];
        BOOL special1 = [QJGlobalControl isIncludeSpecialCharact:self.meunText.text];
        if(special || special1){
            [ALToastView toastInView:self.view withText:@"不可以输入特殊字符"];
        }else{
            
            [self UpDataMessage];
            
            
        }
    }
}
#pragma mark - 提交
- (void)UpDataMessage{
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSDictionary *params = @{@"titelOne":self.tableText.text,@"titelTwo":self.meunText.text};
    [QJGlobalControl sendPOSTWithUrl:JQXPagShow_UPDate parameters:params success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"] integerValue] == 200){
            [ALToastView toastInView:self.view withText:data[@"message"]];
            
            dispatch_time_t delayTime = dispatch_time
            (DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
            
            dispatch_after
            (delayTime, dispatch_get_main_queue(),
             ^{
                 [self.navigationController popViewControllerAnimated:YES];
                 
                 
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


- (void)TextChange:(UITextField *)textFiled
{
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textFiled.text options:0 range:NSMakeRange(0, textFiled.text.length) withTemplate:@""];
    
    if (![noEmojiStr isEqualToString:textFiled.text]) {
        textFiled.text = noEmojiStr;
    }
    @try{
        
        UITextField *textField = textFiled;
        NSString *str = [[textField text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
        NSLog(@"str--%@",str);
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        if (!position) {
            CGFloat ascLen=[self countW:str];
            NSLog(@"ascLen------------------%f",ascLen);
            if (ascLen > 6) {
                NSString *strNew = [NSString stringWithString:str];
                NSLog(@"strNew--%@",strNew);
                NSLog(@"_subLen%f",_subLen);
                if (_subLen==0) {
                    _subLen=strNew.length;
                }
                [textField setText:[strNew substringToIndex:_subLen]];
            }
        }
        else{
        }
    }
    @catch(NSException *exception) {
        NSLog(@"exception:%@", exception);
    }
    @finally {
        
    }
}


- (CGFloat)countW:(NSString *)s
{
    int i;CGFloat n=[s length],l=0,a=0,b=0;
    CGFloat wLen=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[s characterAtIndex:i];//按顺序取出单个字符
        if(isblank(c)){//判断字符串为空或为空格
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
        wLen=l+(CGFloat)((CGFloat)(a+b)/2.0);
        NSLog(@"wLen--%f",wLen);
        if (wLen>=5.5&&wLen<6.5) {//设定这个范围是因为，当输入了当输入9英文，即4.5，后面还能输1字母，但不能输1中文
            _subLen=l+a+b;//_subLen是要截取字符串的位置
        }
        
    }
    if(a==0 && l==0)
    {
        _subLen=0;
        return 0;//只有isblank
    }
    else{
        
        return wLen;//长度，中文占1，英文等能转ascii的占0.5
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

