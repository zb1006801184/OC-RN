//
//  ServiceSetUpViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/10/19.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "ServiceSetUpViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
@interface ServiceSetUpViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    CGFloat _subLen;
}
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *mainScrollView;
@property (nonatomic,strong)UIImageView *headImage;
@property (nonatomic,strong)UIButton *imgButton;
@property (nonatomic,strong)UITextField *nameText;
@property (nonatomic,strong)UITextField *telText;
@property (nonatomic,strong)NSString *dataStr;
@property (nonatomic,strong)UIButton *sumbitButton;
@end

@implementation ServiceSetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"服务经理" isBack:YES];
    self.dataStr = @"照片";
    [self setMainUI];
}
- (void)setMainUI
{
    self.mainScrollView = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.mainScrollView];
    
    //图片
    self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - SCALE_WIDTH(120))/2, 20, SCALE_WIDTH(120), SCALE_WIDTH(120))];
    self.headImage.image = [UIImage imageNamed:@"photo"];
    self.headImage.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:self.headImage];
    
    self.imgButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.headImage.width,self.headImage.height)];
    [self.imgButton addTarget:self action:@selector(ImageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headImage addSubview:self.imgButton];
    
    UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(0, self.headImage.bottom - 20, self.headImage.left, 20) backColor:[UIColor clearColor] text:@"服务经理照片" textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentCenter numOnLines:1];
    [self.mainScrollView addSubview:tsLabel];
    
    //名称
    UILabel *tsLabel1 = [JQXCustom creatLabel:CGRectMake(0, tsLabel.bottom + 40, self.headImage.left, 40) backColor:[UIColor whiteColor] text:@"名称" textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentCenter numOnLines:1];
    [self.mainScrollView addSubview:tsLabel1];
    
    UIView *bgView1 = [[UIView alloc]initWithFrame:CGRectMake(tsLabel1.right, tsLabel.bottom + 40 , SCREEN_WIDTH - tsLabel1.width - 30, 40)];
    bgView1.layer.borderWidth = 1;
    bgView1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.mainScrollView addSubview:bgView1];
    
    self.nameText = [JQXCustom creatTextFiled:CGRectMake(10, 0, bgView1.width - 20, bgView1.height) placeholder:@"经理名称(最多输入4个汉字)"];
//    self.nameText.placeholder = @"最多可输入4个汉字";
    [self.nameText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView1 addSubview:self.nameText];
    
    //联系电话
    UILabel *tsLabel2 = [JQXCustom creatLabel:CGRectMake(0, tsLabel1.bottom + 20, self.headImage.left, 40) backColor:[UIColor whiteColor] text:@"联系电话" textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentCenter numOnLines:1];
    [self.mainScrollView addSubview:tsLabel2];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(tsLabel2.right, tsLabel1.bottom + 20, SCREEN_WIDTH - tsLabel1.width - 30, 40)];
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.mainScrollView addSubview:bgView];
    
    self.telText = [JQXCustom creatTextFiled:CGRectMake(10, 0, bgView.width - 20, bgView.height) placeholder:@"请输入服务经理电话号码"];
    self.telText.keyboardType = UIKeyboardTypeNumberPad;
    self.telText.delegate  = self;
    [self.telText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:self.telText];
    
    if([self.styleStr isEqualToString:@"编辑"]){
        NSString *imgUrl = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.mainDic[@"url"])];
        self.dataStr = imgUrl;
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"%@"]];
        self.nameText.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.mainDic[@"name"])];
        self.telText.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.mainDic[@"telphone"])];
    }
    
    self.sumbitButton = [JQXCustom creatButton:CGRectMake(60, tsLabel2.bottom + 50 , SCREEN_WIDTH - 120, 40) backColor:BACKGROUNGCOLOR text:@"保存" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14] addTarget:self Action:@selector(sumbitAction)];
    self.sumbitButton.userInteractionEnabled = YES;
    self.sumbitButton.layer.masksToBounds = YES;
    self.sumbitButton.layer.cornerRadius = 5;
    [self.mainScrollView addSubview:self.sumbitButton];
    
    
}
#pragma mark - 保存按钮点击事件
- (void)sumbitAction
{
    [self.view endEditing:YES];
    if(self.nameText.text.length == 0 || self.telText.text.length != 11 || [self.dataStr isEqualToString:@"照片"]){
        
        [ALToastView toastInView:self.view withText:@"信息不全，请补充"];
        
    }else if([[self.nameText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0 || [[self.telText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0){
        [ALToastView toastInView:self.view withText:@"请输入正确信息"];
    }else{
        //详细地址
        BOOL nameSpecial = [QJGlobalControl isIncludeSpecialCharact:self.nameText.text];
        BOOL telSpecial = [QJGlobalControl isIncludeSpecialCharact:self.telText.text];
        if(nameSpecial || telSpecial){
            [ALToastView toastInView:self.view withText:@"不可以输入特殊字符"];
        }else{
            self.sumbitButton.userInteractionEnabled = NO;
            //添加
            [JHHJView showLoadingOnTheKeyWindowWithType:2];
            NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:UserID];
            NSDictionary *params = [NSDictionary dictionary];
            
            if([self.styleStr isEqualToString:@"编辑"]){
                params =@{@"userId":userid,@"type":@"2",@"telPhone":self.telText.text,@"name":self.nameText.text,@"imgUrl":self.dataStr,@"id":self.mainDic[@"id"]};
            }else{
                params = @{@"userId":userid,@"type":@"2",@"telPhone":self.telText.text,@"name":self.nameText.text,@"imgUrl":self.dataStr};
            }
            
            [QJGlobalControl sendPOSTWithUrl:JQXServiceManager_Url parameters:params success:^(id data) {
                [JHHJView hideLoading];
                NSLog(@"data === %@",data);
                if([data[@"code"] integerValue] == 200){
                    [ALToastView toastInView:self.view withText:@"添加成功"];
                    dispatch_time_t delayTime = dispatch_time
                    (DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
                    
                    dispatch_after
                    (delayTime, dispatch_get_main_queue(),
                     ^{
                         [self.navigationController popViewControllerAnimated:YES];
                         
                     }
                     );
                }else{
                    self.sumbitButton.userInteractionEnabled = YES;
                    [ALToastView toastInView:self.view withText:data[@"message"]];
                }
            } fail:^(NSError *error) {
                [JHHJView hideLoading];
                NSLog(@"data === %@",error);
                [ALToastView toastInView:self.view withText:@"请求失败"];
                self.sumbitButton.userInteractionEnabled = YES;
            }];
        }
        
    }
}
#pragma mark - 服务经理照片
- (void)ImageAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self choosePhotoAction];
    }];
    
    UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self choosePictureAction];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:photoAction];
    [alert addAction:pictureAction];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - 照片点击事件
- (void)choosePhotoAction
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    ipc.navigationBar.backgroundColor = [UIColor redColor];
    //判断设备是否支持这种sourcetype
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    ipc.delegate = self;
    //是否允许编辑
    ipc.allowsEditing = YES;
    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark - 相册点击事件
- (void)choosePictureAction
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.navigationBar.backgroundColor = [UIColor whiteColor];
    //判断设备是否支持这种sourcetype
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    ipc.delegate = self;
    //是否允许编辑
    ipc.allowsEditing = YES;
    
    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark---ImagePickerControllerDelegate---
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    
    
    NSString *formatInfo = [[info objectForKey:UIImagePickerControllerReferenceURL] absoluteString];
    
    if ([formatInfo rangeOfString:@"JPG"].location == NSNotFound &&
        [formatInfo rangeOfString:@"PNG"].location == NSNotFound) {
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        [picker dismissViewControllerAnimated:YES completion:^{}];
        
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        [self uploadImage:originalImage];
        
        
    }
    
//    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
//
//    [picker dismissViewControllerAnimated:NO completion:nil];
}
- (void)uploadImage:(UIImage *)upimage
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [manager POST:http_PhotoURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        //        NSData *data = UIImagePNGRepresentation(upimage);
        NSData * data = [self CompressedPictureWithImage:upimage];
        
        
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        //上传
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 对应网站上[upload.php中]处理文件的[字段"file"]
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        [formData appendPartWithFileData:data name:@"image" fileName:fileName mimeType:@"image/png"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpImageLoading" object:nil userInfo:@{@"test":@"正在上传"}];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功 %@", responseObject);
        [JHHJView hideLoading];
        
        /*
         code = 200;
         count = 0;
         data = "https://ph-images.oss-cn-shenzhen.aliyuncs.com/merchant/app/image/20170727/20170727181025233761898.png";
         message = "\U56fe\U7247\U4e0a\U4f20\U6210\U529f";
         success = 1;
         */
        
        if([responseObject[@"code"]integerValue] == 200){
            self.dataStr = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
            self.headImage.image = upimage;
            [ALToastView toastInView:self.view withText:@"上传成功"];
            
        }else{
            [ALToastView toastInView:self.view withText:responseObject[@"message"]];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [JHHJView hideLoading];
        NSLog(@"上传失败 %@", error);
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}

//图片压缩方法
-(NSData *)CompressedPictureWithImage:(UIImage *)image
{
    //压缩图片
    NSData * imageData = UIImageJPEGRepresentation(image, 1.0f);
    
    float m = [imageData length]/1024.0;
    if (m>10*1024) {
        [ALToastView toastInView:self.view withText:@"图片不能大于10M"];
        return nil;
    }
    
    imageData = UIImageJPEGRepresentation(image, 1/ (10 * m) );
    
    return imageData;
    
}
- (void)TextChange:(UITextField *)textFiled
{
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textFiled.text options:0 range:NSMakeRange(0, textFiled.text.length) withTemplate:@""];
    
    
    if (![noEmojiStr isEqualToString:textFiled.text] || [[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
        
        textFiled.text = noEmojiStr;
        
    }
    
    if(textFiled == self.telText){
        NSInteger MAX = 11;
        NSString *nsTextContent = textFiled.text;
//        NSInteger Num = nsTextContent.length;
        
        UITextRange *selectedRange = [textFiled markedTextRange];
        UITextPosition *position = [textFiled positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制,防止中文被截断
        if (!position){
            if (nsTextContent.length > MAX){
                //中文和emoj表情存在问题，需要对此进行处理
                NSRange rangeRange = [nsTextContent rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX)];
                self.telText.text = [nsTextContent substringWithRange:rangeRange];
            }
        }
    }
    
    if(textFiled == self.nameText){
        @try{
            
            UITextField *textField = textFiled;
            NSString *str = [[textField text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
            NSLog(@"str--%@",str);
            UITextRange *selectedRange = [textField markedTextRange];
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            
            if (!position) {
                CGFloat ascLen=[self countW:str];
                NSLog(@"ascLen------------------%f",ascLen);
                if (ascLen > 4) {
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
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField == self.telText){
        //禁止用户输入字母
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c]) {
                return NO;
            }
        }
    }
    return YES;
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
        if (wLen>=3.5&&wLen<4.5) {//设定这个范围是因为，当输入了当输入9英文，即4.5，后面还能输1字母，但不能输1中文
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
