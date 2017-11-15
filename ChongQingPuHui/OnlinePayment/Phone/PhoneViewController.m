//
//  PhoneViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/14.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "PhoneViewController.h"
#import "LBXScanResult.h"
#import "LBXScanWrapper.h"
#import "LBXScanView.h"
#import <objc/message.h>
#import "LBXAlertAction.h"
#import "SubLBXScanViewController.h"
#import "OnMoneryViewController.h"//输入消费总额
#import "BindingPhoneViewController.h"//绑定手机号
#import "BindingPhoneSuccessController.h"//绑定过手机号
#import "JKCountDownButton.h"
@interface PhoneViewController ()
@property (nonatomic,strong)UITextField *textFiled;
@property (nonatomic,strong)JKCountDownButton *nextBtn;
@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(GoCreatOrder:) name:@"GoCreatOrder" object:nil];
    [self setNavBarWithTitle:@"输入会员手机号" isBack:YES];
    [self setUI];
//    if([self.styleStr isEqualToString:@"线下付"]){
//        
//        [self setNAVRight];
//        
//    }
    
}
- (void)setUI{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(20, 94, SCREENSIZE.width - 40, SCALE_HEIGHT(50))];
    bgView.layer.borderColor= BACKGrayColor.CGColor;
    bgView.layer.borderWidth = 1.5;
    [self.view addSubview:bgView];
    
    
    UITextField *rightTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, bgView.width - 10, bgView.height)];
    rightTextField.placeholder = @"请输入您的会员手机号";
    rightTextField.tag = 100;
    rightTextField.font = [UIFont systemFontOfSize:14];
    rightTextField.keyboardType = UIKeyboardTypeNumberPad;
    [rightTextField addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:rightTextField];
    self.textFiled = rightTextField;
    
//    NSString *tsStr = @"此手机号已注册普惠会员／点击下一步可自动注册会员";
//    CGFloat tsH = [tsStr CallateLabelSizeHeight:[UIFont systemFontOfSize:12] lineWidth:SCREEN_WIDTH - 40];
//    UILabel *tsLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, bgView.bottom + 10, SCREEN_WIDTH - 40, tsH)];
//    tsLabel.text = tsStr;
//    if(SCREEN_WIDTH < 375){
//        tsLabel.font = [UIFont systemFontOfSize:9];
//    }else{
//        tsLabel.font = [UIFont systemFontOfSize:12];
//    }
//    tsLabel.textColor = RGB_COLOR(205, 206, 207);
//    tsLabel.numberOfLines = 0;
//    [self.view addSubview:tsLabel];
    
    self.nextBtn = [[JKCountDownButton alloc]initWithFrame:CGRectMake(40, bgView.bottom + 50, self.view.frame.size.width - 80, SCALE_HEIGHT(40))];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius = 5;
    self.nextBtn.backgroundColor = BACKGROUNGCOLOR;
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextBtn];
    
}
#pragma mark - 下一步按钮点击事件
- (void)sureClick:(JKCountDownButton *)sender
{
    [self.textFiled resignFirstResponder];
    
    if(self.textFiled.text.length == 11 || self.textFiled.text.length == 13 ){
        
        if([QJGlobalControl checkPhoneNumber:self.textFiled.text]){
            
            NSString *orderType = @"0";
            if([self.styleStr isEqualToString:@"线下付"]){
                orderType = @"0";
            }else{
                orderType = @"1";
            }
            //走接口
            NSString *phone = [NSString stringWithFormat:@"%@",self.textFiled.text];
            NSDictionary *params = @{@"memberPhone":phone,@"merchantId":self.merchantId,@"orderType":orderType};
            [JHHJView showLoadingOnTheKeyWindowWithType:2];
            [QJGlobalControl sendPOSTWithUrl:JQXHttp_MoneryPhone parameters:params success:^(id data) {
                [JHHJView hideLoading];
                NSLog(@"🍇%@",data);
                if([data[@"code"]integerValue] == 200){
                    
                    NSString *memberID = [NSString stringWithFormat:@"%@",data[@"data"][@"memberId"]];
                    [[NSUserDefaults standardUserDefaults]setObject:phone forKey:MemberPhone];
                    [[NSUserDefaults standardUserDefaults]setObject:memberID forKey:MemberId];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    //三种情况 1.是会员并且已经绑定并支付订单 2.是会员 但是没绑定手机号或者没支付订单 3.不是会员
                    //                NSString *proTelPhone = [NSString stringWithFormat:@"%@",NULL_TO_NIL(data[@"data"][@"proTelPhone"])];
                    //                if(![proTelPhone isEqualToString:@"(null)"]){ //1.是会员并且已经绑定并支付订单
                    //                    BindingPhoneSuccessController *vc = [[BindingPhoneSuccessController alloc]init];
                    //                    vc.proTelPhone = proTelPhone;
                    //                    [self.navigationController pushViewController:vc animated:YES];
                    
                    OnMoneryViewController *vc = [[OnMoneryViewController alloc]init];
                    vc.styleStr = self.styleStr;
                    vc.proTelPhone = @"绑定手机号";
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    //                }else{//2.是会员 但是没绑定手机号或者没支付订单
                    //                    sender.enabled = NO;
                    //
                    //                    [sender startWithSecond:15];
                    //
                    //                    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                    //
                    //                        sender.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f];
                    //                        sender.layer.borderColor = [UIColor lightGrayColor].CGColor;
                    //                        NSString *title = [NSString stringWithFormat:@"短信已发送(%d秒)",second];
                    //                        [countDownButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    //                        return title;
                    //
                    //                    }];
                    //
                    //                    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                    //
                    //                        sender.backgroundColor = BACKGROUNGCOLOR;
                    //                        countDownButton.enabled = YES;
                    //
                    //                        [countDownButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    //
                    //
                    //                        return @"重新获取";
                    //
                    //                    }];
                    //
                    //                    NSString *phoneStr = [NSString stringWithFormat:@"请确认用户%@是否已收到短信",phone];
                    //
                    //                    //UIAlertController风格：UIAlertControllerStyleAlert
                    //                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                    //                                                                                             message:phoneStr
                    //                                                                                      preferredStyle:UIAlertControllerStyleAlert ];
                    //
                    //                    //添加取消到UIAlertController中
                    //                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                    //                    [alertController addAction:cancelAction];
                    //
                    //                    //添加确定到UIAlertController中
                    //                    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //                        BindingPhoneViewController *vc = [[BindingPhoneViewController alloc]init];
                    //                        [self.navigationController pushViewController:vc animated:YES];
                    //                    }];
                    //                    [alertController addAction:OKAction];
                    //
                    //                    [self presentViewController:alertController animated:YES completion:nil];
                    //
                    //                }
                    
                    
                }else if ([data[@"code"] integerValue] == 10112){//3.不是会员
                    
                    
                    [[NSUserDefaults standardUserDefaults]setObject:phone forKey:MemberPhone];
                    
                    
                    sender.enabled = NO;
                    
                    [sender startWithSecond:15];
                    
                    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                        
                        sender.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f];
                        sender.layer.borderColor = [UIColor lightGrayColor].CGColor;
                        NSString *title = [NSString stringWithFormat:@"短信已发送(%d秒)",second];
                        [countDownButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        return title;
                        
                    }];
                    
                    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                        
                        sender.backgroundColor = BACKGROUNGCOLOR;
                        countDownButton.enabled = YES;
                        
                        [countDownButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        
                        
                        return @"重新获取";
                        
                    }];
                    
                    NSString *phoneStr = [NSString stringWithFormat:@"请确认用户%@是否已收到短信",phone];
                    
                    //UIAlertController风格：UIAlertControllerStyleAlert
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                             message:phoneStr
                                                                                      preferredStyle:UIAlertControllerStyleAlert ];
                    
                    //添加取消到UIAlertController中
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                    [alertController addAction:cancelAction];
                    
                    //添加确定到UIAlertController中
                    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        OnMoneryViewController *vc = [[OnMoneryViewController alloc]init];
                        vc.styleStr = self.styleStr;
                        vc.proTelPhone = @"绑定手机号";
                        [self.navigationController pushViewController:vc animated:YES];
                    }];
                    [alertController addAction:OKAction];
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                    
                    //                BindingPhoneViewController *vc = [[BindingPhoneViewController alloc]init];
                    //                vc.styleStr = @"不是会员";
                    //                [self.navigationController pushViewController:vc animated:YES];
                    
                }else{
                    [ALToastView toastInView:self.view withText:data[@"message"]];
                }
                
            } fail:^(NSError *error) {
                [JHHJView hideLoading];
                [ALToastView toastInView:self.view withText:@"请求失败"];
            }];
            
        }else{
            
            [ALToastView toastInView:self.view withText:@"请输入正确手机号码"];
            
        }
        
    }else{
        [ALToastView toastInView:self.view withText:@"请输入正确手机号码"];
    }

}


- (void)TextChange:(UITextField *)textFiled
{
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textFiled.text options:0 range:NSMakeRange(0, textFiled.text.length) withTemplate:@""];
    
    
    if (![noEmojiStr isEqualToString:textFiled.text] || [[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
        
        textFiled.text = noEmojiStr;
        
    }
    
    if(textFiled == self.textFiled){
        NSInteger MAX = 11;
        NSString *nsTextContent = textFiled.text;
        NSInteger Num = nsTextContent.length;
        
        UITextRange *selectedRange = [textFiled markedTextRange];
        UITextPosition *position = [textFiled positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制,防止中文被截断
        if (!position){
            if (nsTextContent.length > MAX){
                //中文和emoj表情存在问题，需要对此进行处理
                NSRange rangeRange = [nsTextContent rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX)];
                self.textFiled.text = [nsTextContent substringWithRange:rangeRange];
            }
        }
    }
    
    
}

#pragma mark - 右上角按钮
- (void)setNAVRight
{
    UIButton *rightButton = [JQXCustom creatButton:CGRectMake(SCREEN_WIDTH - 90, 0, 80, 44) backColor:[UIColor clearColor] text:@" 条形码" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14] addTarget:self Action:@selector(CodeAction)];
    [rightButton setImage:[UIImage imageNamed:@"icon-code"] forState:UIControlStateNormal];
    [self.navBarView addSubview:rightButton];
    
}
#pragma mark - 条形码按钮点击事件
- (void)CodeAction
{
    
    if (![self cameraPemission])
    {
        [self showError:@"没有摄像机权限"];
        return;
    }
    
    NSString *methodName = @"recoCropRect";
    
    SEL normalSelector = NSSelectorFromString(methodName);
    if ([self respondsToSelector:normalSelector]) {
        
        ((void (*)(id, SEL))objc_msgSend)(self, normalSelector);
    }

    
}


- (BOOL)cameraPemission
{
    
    BOOL isHavePemission = NO;
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                isHavePemission = YES;
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                break;
            case AVAuthorizationStatusNotDetermined:
                isHavePemission = YES;
                break;
        }
    }
    
    return isHavePemission;
}
- (void)showError:(NSString*)str
{
    [LBXAlertAction showAlertWithTitle:@"提示" msg:str chooseBlock:nil buttonsStatement:@"知道了",nil];
}

#pragma mark -框内区域识别
- (void)recoCropRect
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
    style.photoframeLineW = 6;
    style.photoframeAngleW = 24;
    style.photoframeAngleH = 24;
    style.colorAngle = BACKGROUNGCOLOR;
    style.isNeedShowRetangle = YES;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    
    
    //矩形框离左边缘及右边缘的距离
    style.xScanRetangleOffset = 40;
    
    //使用的支付宝里面网格图片
    UIImage *imgPartNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_part_net"];
    
    style.animationImage = imgPartNet;
    
    
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    //开启只识别框内
    vc.isOpenInterestRect = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)openScanVCWithStyle:(LBXScanViewStyle*)style
{
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    //vc.isOpenInterestRect = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//#pragma mark - 相册
//- (void)openLocalPhotoAlbum
//{
//    if ([LBXScanWrapper isGetPhotoPermission])
//    {
//        [self openLocalPhoto];
//    }
//    else
//        [self showError:@"      请到设置->隐私中开启本程序相册权限     "];
//}

/*!
 *  打开本地照片，选择图片识别
 */
//- (void)openLocalPhoto
//{
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//
//    picker.delegate = self;
//
//
//    //    picker.allowsEditing = YES;
//
//
//    [self presentViewController:picker animated:YES completion:nil];
//}



//当选择一张图片后进入这里

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    __weak __typeof(self) weakSelf = self;
    [LBXScanWrapper recognizeImage:image success:^(NSArray<LBXScanResult *> *array) {
        
        [weakSelf scanResultWithArray:array];
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    
    if (array.count < 1)
    {
        [self showError:@"识别失败了"];
        
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {
        
        NSLog(@"scanResult:%@",result.strScanned);
    }
    
    //    LBXScanResult *scanResult = array[0];
    
    //震动提醒
    [LBXScanWrapper systemVibrate];
    //声音提醒
    [LBXScanWrapper systemSound];
    
}


#pragma mark - 扫描二维码得到的数据
-(void)GoCreatOrder:(NSNotification *)sender{
    
    [self creatLoadData:sender.object];
}
#pragma mark - 根据二维码得到的数据请求
-(void)creatLoadData:(NSString *)dataStr{
    
    
        NSString *url = httpGetCard;
        NSDictionary *params = @{@"outerCode":dataStr};//self.codeStr
        [JHHJView showLoadingOnTheKeyWindowWithType:2];
        [QJGlobalControl sendPOSTWithUrl:url parameters:params success:^(id data) {
            [JHHJView hideLoading];
            NSLog(@"获取到的数据为：%@",data);
    
            NSString *result=[NSString stringWithFormat:@"%@",data[@"code"]];
    
            if ([result isEqual:@"200"]) {
    
                [[NSUserDefaults standardUserDefaults]setObject:data[@"data"][@"enablescore"] forKey:AvailableIntegral];
    
                [[NSUserDefaults standardUserDefaults]setObject:data[@"data"][@"code"] forKey:MemberCode];
                [[NSUserDefaults standardUserDefaults]setObject:data[@"data"][@"memberPhone"] forKey:MemberPhone];
                [[NSUserDefaults standardUserDefaults]setObject:data[@"data"][@"memberId"] forKey:MemberId];
                [[NSUserDefaults standardUserDefaults]synchronize];
    //
                OnMoneryViewController *ctrl = [[OnMoneryViewController alloc]init];
                [self.navigationController pushViewController:ctrl animated:YES];
    //
            }else{
    
                //            [ALToastView toastInView:self.view withText:@"请求失败，请重新扫描"];
                [ALToastView toastInView:self.view withText:data[@"message"]];
                //            [self.navigationController popViewControllerAnimated:YES];
            }
    
        } fail:^(NSError *error) {
            [JHHJView hideLoading];
            [ALToastView toastInView:self.view withText:@"请求失败"];
        }];
    //
    
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
