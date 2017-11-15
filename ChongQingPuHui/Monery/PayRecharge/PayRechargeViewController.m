//
//  PayRechargeViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "PayRechargeViewController.h"
#import "Order.h"
#import "RSADataSigner.h"
#import "DataSigner.h"
#import "QuickRechargeController.h"
#import "WXApi.h"
@interface PayRechargeViewController ()<UITextFieldDelegate>
{
    UIButton *jifenBtn;
    UIButton *quckBtn;
    UIImageView *jifenImage;
    UIImageView *quckImage;
    NSString *chargeType;
    
}
@property (nonatomic,strong)UITextField *moneryField;

@end

@implementation PayRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"在线充值" isBack:YES];
    [self setUI];
    //支付宝支付结果通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AliPayCallBack:) name:@"AliPayCallBack" object:nil];
}

-(void)AliPayCallBack:(NSNotification *)notification
{
    NSDictionary * notifDic = notification.userInfo;
    NSString * resultStatus = notifDic[@"resultStatus"];
    if ([resultStatus isEqualToString:@"9000"]) {//成功
        [ALToastView toastInView:self.view withText:@"充值成功"];
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            
        });
    }else {
        NSLog(@"支付宝支付失败");
        [ALToastView toastInView:self.view withText:@"充值失败"];
        
    }
}

- (void)setUI{
    
//    UILabel *tsLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 64, SCREEN_WIDTH - 40, 50)];
//    tsLabel. text = @"使用支付宝充值";
//    tsLabel.font = [UIFont systemFontOfSize:14];
//    tsLabel.textColor = [UIColor blackColor];
//    tsLabel.textAlignment = NSTextAlignmentLeft;
//    [self.view addSubview:tsLabel];
    
    
    float yPos = 84;
    
    jifenImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, yPos + 10, 20, 20)];
    jifenImage.image = [UIImage imageNamed:@"radio_checked"];
    [self.view addSubview:jifenImage];
    
    jifenBtn = [[UIButton alloc]initWithFrame:CGRectMake( 0, yPos, SCREEN_WIDTH, 40)];
    //    [jifenBtn setImage:[UIImage imageNamed:@"radio_unchecked"] forState:UIControlStateNormal];
    jifenBtn.tag = 101;
    [jifenBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jifenBtn];
    UILabel *jifenLabel = [[UILabel alloc]initWithFrame:CGRectMake( 70, yPos, SCREEN_WIDTH - 80, 40)];
    jifenLabel.text = @"支付宝";
    jifenLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:jifenLabel];
    chargeType = @"2";
    
    yPos += 40;
//    quckImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, yPos + 10, 20, 20)];
//    quckImage.image = [UIImage imageNamed:@"radio_unchecked"];
//    [self.view addSubview:quckImage];
//    
//    quckBtn = [[UIButton alloc]initWithFrame:CGRectMake( 0, yPos, SCREEN_WIDTH, 40)];
//    
//    quckBtn.tag = 102;
//    [quckBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:quckBtn];
//    UILabel *quckLabel = [[UILabel alloc]initWithFrame:CGRectMake( 70, yPos, SCREEN_WIDTH - 80, 40)];
//    quckLabel.text = @"快捷充值";
//    quckLabel.font = [UIFont systemFontOfSize:15];
//    [self.view addSubview:quckLabel];

    quckImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, yPos + 10, 20, 20)];
    quckImage.image = [UIImage imageNamed:@"radio_unchecked"];
    [self.view addSubview:quckImage];
    
    quckBtn = [[UIButton alloc]initWithFrame:CGRectMake( 0, yPos, SCREEN_WIDTH, 40)];
    
    quckBtn.tag = 102;
    [quckBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quckBtn];
    UILabel *quckLabel = [[UILabel alloc]initWithFrame:CGRectMake( 70, yPos, SCREEN_WIDTH - 80, 40)];
    quckLabel.text = @"微信支付";
    quckLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:quckLabel];
    
    yPos += 40;
    
    
    UIView *bkView = [[UIView alloc]init];
    bkView.frame = CGRectMake(20, yPos + 20, SCREEN_WIDTH - 40, SCALE_HEIGHT(50));
    bkView.backgroundColor = [UIColor whiteColor];
    bkView.layer.masksToBounds=YES;
    bkView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    bkView.layer.borderWidth = 1.5;
    [self.view addSubview:bkView];
    
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, SCALE_HEIGHT(50))];
    leftLabel. text = @"金额";
    leftLabel.font = [UIFont systemFontOfSize:14];
    leftLabel.textColor = [UIColor blackColor];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    [bkView addSubview:leftLabel];
    
    
    self.moneryField = [[UITextField alloc]initWithFrame:CGRectMake(90, 0, bkView.frame.size.width - 100, SCALE_HEIGHT(50))];
    self.moneryField.placeholder = @"点击输入金额";
    self.moneryField.tag = 100;
    self.moneryField.textAlignment = NSTextAlignmentRight;
    self.moneryField.font = [UIFont systemFontOfSize:14];
    self.moneryField.keyboardType = UIKeyboardTypeDecimalPad;
    self.moneryField.delegate = self;
    
    [bkView addSubview:self.moneryField];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, bkView.bottom + 30, self.view.frame.size.width - 80, SCALE_HEIGHT(40))];
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 5;
    loginBtn.backgroundColor = BACKGROUNGCOLOR;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}

-(void)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 101:
            //现金支付
            jifenImage.image = [UIImage imageNamed:@"radio_checked"];
            quckImage.image = [UIImage imageNamed:@"radio_unchecked"];
            chargeType = @"2";
            break;
        case 102:
//            积分支付
            //微信支付
            jifenImage.image = [UIImage imageNamed:@"radio_unchecked"];
            quckImage.image = [UIImage imageNamed:@"radio_checked"];
//            chargeType = @"7";
            chargeType = @"9";
            break;
        default:
            break;
    }
    
}
#pragma mark - 下一步
- (void)sureClick
{
    if ([chargeType isEqual:@"7"]) {
        if ([self.moneryField.text doubleValue] < 1) {
            [self.moneryField resignFirstResponder];
            [ALToastView toastInView:self.view withText:@"输入的充值金额请大于1元。"];
            return;
        }
    }
    
    [self.moneryField resignFirstResponder];
    if([self.moneryField.text floatValue] == 0 ||self.moneryField.text.length == 0){
        [ALToastView toastInView:self.view withText:@"请输入正确金额"];
    }else{
        NSDictionary *params = @{@"chargeType":chargeType,@"score":self.moneryField.text};
        
        [JHHJView showLoadingOnTheKeyWindowWithType:2];
        [QJGlobalControl sendPOSTWithUrl:httpPayRecharge parameters:params success:^(id data) {
            
            [JHHJView hideLoading];
            NSLog(@"🍉：%@",data);
            /*
             description = "\U5546\U6237\U652f\U4ed8\U5b9d\U5145\U503c\U8ba2\U5355";
             orderNo = PHCZDD201787307483439992;
             */
            
            if([data[@"code"]integerValue] == 200){
                
                NSDictionary *dic = data[@"data"];
                [self setHaveAlipay:dic];
            }else{
                [ALToastView toastInView:self.view withText:data[@"message"]];
            }
            
        } fail:^(NSError *error) {
            [JHHJView hideLoading];
            [ALToastView toastInView:self.view withText:@"请求失败"];
        }];
    }
    
    
}
- (void)setHaveAlipay:(NSDictionary *)dic
{
    NSString *orderNo = [NSString stringWithFormat:@"%@",dic[@"orderNo"]];
    
    NSString *description = [NSString stringWithFormat:@"%@",dic[@"description"]];
    
    NSString *payUrl = [NSString string];
    NSDictionary *params = [NSDictionary dictionary];
    if ([chargeType isEqual:@"2"]) {
        payUrl = httpAplipayUrl;
        params = @{@"description":description,@"orderNum":orderNo,@"amount":self.moneryField.text};
    }else{
        payUrl = [NSString stringWithFormat:@"%@?orderNum=%@&amount=%@",http_bj_com_payUrl,orderNo,self.moneryField.text];
        params = nil;
    }
    
    [QJGlobalControl sendPOSTAplipayWithUrl:payUrl parameters:params success:^(id data) {
        NSLog(@"data ======   %@",data);
        if([data[@"code"]integerValue] == 200){
            if ([chargeType isEqual:@"2"]) {
                [self Alipay:data[@"data"]];
            }else{
                [self pushNextView:data[@"data"]];
            }
        }else{
             [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}
//跳转到快捷充值页面
- (void)pushNextView:(NSString *)dataStr
{
    QuickRechargeController *ctrl = [[QuickRechargeController alloc]init];
    ctrl.webUrl = dataStr;
    [self.navigationController pushViewController:ctrl animated:YES];
}
#pragma mark - 调用支付宝
- (void)Alipay:(NSString *)dataStr
{
  
    NSString *appScheme = @"KuaiHuoAlipaySchemes";
    
    [[AlipaySDK defaultService] payOrder:dataStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AliPayCallBack" object:nil userInfo:resultDic];
    }];
}
#pragma mark - 调用微信
- (void)WeiXin:(NSDictionary *)dic
{
    if (![WXApi isWXAppInstalled]) {
        //判断是否有微信
        [ALToastView toastInView:self.view withText:@"该手机上没有微信，请去App Store下载.."];
    }else{
        
        //微信支付按钮方法
        PayReq *request = [[PayReq alloc] init];
        //应用id
        request.openID = WX_APP_ID;
        //商家向财付通申请的商家id
        request.partnerId = [NSString stringWithFormat:@"%@",dic[@"partid"]];
        //预支付订单 : 里面包含了 商品的标题 . 描述, 价格等商品信息.
        request.prepayId= [NSString stringWithFormat:@"%@",dic[@"prepayid"]];
        ///** 商家根据财付通文档填写的数据和签名 */
        // 相当于一种标识
        request.package = @"Sign=WXPay";
        ///** 随机串，防重发 */
        request.nonceStr= [NSString stringWithFormat:@"%@",dic[@"noncestr"]];
        //时间戳.  防止重发.
        //从1970年之后的秒数.
        request.timeStamp= 1452325279;
        ///** 商家根据微信开放平台文档对数据做的签名 */
        
        NSString *signStr =[self createMD5SingForPayWithAppID:WX_APP_ID partnerid:[NSString stringWithFormat:@"%@",dic[@"partid"]] prepayid:[NSString stringWithFormat:@"%@",dic[@"prepayid"]] package:@"Sign=WXPay" noncestr:[NSString stringWithFormat:@"%@",dic[@"noncestr"]] timestamp:1452325279];
        //加密数据用的
        request.sign= [NSString stringWithFormat:@"%@",signStr];
        
        
        //调用微信支付.
        [WXApi sendReq:request];
        
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.moneryField) {
        //不能输入表情
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
        
        NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textField.text options:0 range:NSMakeRange(0, textField.text.length) withTemplate:@""];
        
        
        if (![noEmojiStr isEqualToString:textField.text] || [[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
            
            textField.text = noEmojiStr;
            
        }
        
        
        //禁止用户输入字母
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c]) {
                return NO;
            }
        }
        
        
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
   
    return YES;
}
#pragma mark -  微信支付本地签名
//创建发起支付时的sign签名
-(NSString *)createMD5SingForPayWithAppID:(NSString *)appid_key partnerid:(NSString *)partnerid_key prepayid:(NSString *)prepayid_key package:(NSString *)package_key noncestr:(NSString *)noncestr_key timestamp:(UInt32)timestamp_key{
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject:appid_key forKey:@"appid"];//微信appid 例如wxfb132134e5342
    [signParams setObject:noncestr_key forKey:@"noncestr"];//随机字符串
    [signParams setObject:package_key forKey:@"package"];//扩展字段  参数为 Sign=WXPay
    [signParams setObject:partnerid_key forKey:@"partnerid"];//商户账号
    [signParams setObject:prepayid_key forKey:@"prepayid"];//此处为统一下单接口返回的预支付订单号
    [signParams setObject:[NSString stringWithFormat:@"%u",timestamp_key] forKey:@"timestamp"];//时间戳
    
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [signParams allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[signParams objectForKey:categoryId] isEqualToString:@""]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [signParams objectForKey:categoryId]];
        }
    }
    //添加商户密钥key字段  API 密钥
    //    [contentString appendFormat:@"key=%@", @"zsOVx0R0fZjDchCTz9yQ3h7Mm8qgZihY"];
    //易商通
    [contentString appendFormat:@"key=%@", WX_APP_KEY];
    
    NSLog(@"contentString%@====",contentString);
    
    NSString *result = [contentString md5];//md5加密
    
    NSLog(@"sign=====%@",result);
    
    return result;
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
