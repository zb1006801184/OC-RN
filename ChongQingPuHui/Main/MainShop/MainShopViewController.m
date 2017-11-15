//
//  MainShopViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/28.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "MainShopViewController.h"
#import "ChoosePhoController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "DateTimePickerView.h"
#import "MainShopManagerViewController.h"//店面经理
#import "JQXServiceViewController.h"//服务经理
@interface MainShopViewController ()<DateTimePickerViewDelegate,UITextFieldDelegate>
{
    UIView *businessView;//营业执照
    
    UIView *IDCardView;//法人身份证
    
    UIView *shopPhotoView;//门店照片
    
    UIView *otherView;//其他资料
    
    NSString *editShop;
    
}
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *mainScrollView;
@property (nonatomic,strong)UITextField *moneryText;//人均消费
@property (nonatomic,strong)UITextField *openTimeSText;//营业时间
@property (nonatomic,strong)UITextField *openTimeEText;//营业时间
@property (nonatomic,strong)UITextField *closeSText;//非营业时间
@property (nonatomic,strong)UITextField *closeNText;//非营业时间
@property (nonatomic,strong)UITextField *companyText;//企业名称
@property (nonatomic,strong)UITextField *shopNameText;//门店名称
@property (nonatomic,strong)UITextField *contactsText;//联系人
@property (nonatomic,strong)UITextField *classLabel;//行业分类
@property (nonatomic,strong)NSArray *businessArray;//营业执照图片数组
@property (nonatomic,strong)NSArray *IDCardArray;//法人身份证数组
@property (nonatomic,strong)NSArray *shopPhotoArray;//门店照片数组
@property (nonatomic,strong)NSArray *otherArray;//其他照片数组
@property (nonatomic,strong)NSString *dateStr;//判断点击的是哪个时间
@property (nonatomic,strong)UIButton *shopManagerButton;//店面经理的状态
@property (nonatomic,strong)DateTimePickerView *pickerView;
@property (nonatomic,strong)NSDictionary *shopManagerDic;
@end

@implementation MainShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"门店信息" isBack:YES];
    self.mainScrollView = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    //    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.mainScrollView];
    [self setMainUI];
    [self setNAVRight];
    [self getShopMessage];
    editShop = @"未更改";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifActon:) name:@"JQXEditShopMessage" object:nil];
    
}
- (void)notifActon:(NSNotification *)notif
{
    editShop = @"已更改";
    [self getShopMessage];
}
- (void)setMainUI
{
    CGFloat Y = 0;
    
    //人均消费
    RegisterView *moneryView = [[RegisterView alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, 45)];
    moneryView.tsLabel.text = @"人均消费";
    [self.mainScrollView addSubview:moneryView];
    
    self.moneryText = [JQXCustom creatTextFiled:CGRectMake(90, 0, moneryView.width - 90 - 30, moneryView.height) placeholder:@"请输入门店人均消费金额"];
    self.moneryText.textAlignment = NSTextAlignmentRight;
    self.moneryText.keyboardType = UIKeyboardTypeNumberPad;
    self.moneryText.delegate = self;
    [self.moneryText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [moneryView addSubview:self.moneryText];
    
    UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(moneryView.width - 30,0, 20, 45) backColor:[UIColor clearColor] text:@"元" textColor:[UIColor lightGrayColor] font:Font(13) textAlignment:NSTextAlignmentCenter numOnLines:1];
    [moneryView addSubview:tsLabel];
    //营业时间
    UIView *openView = [[UIView alloc]initWithFrame:CGRectMake(20, moneryView.bottom + 10, SCREEN_WIDTH - 40, 90)];
    openView.layer.borderWidth = 1;
    openView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.mainScrollView addSubview:openView];
    
    UILabel *otsLabel = [JQXCustom creatLabel:CGRectMake(10, 10, 80, 20) backColor:[UIColor clearColor] text:@"营业时间" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
    [openView addSubview:otsLabel];
    UILabel *otsLabel2 = [JQXCustom creatLabel:CGRectMake(10, otsLabel.bottom + 5, 50, 15) backColor:[UIColor clearColor] text:@"（每日）" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter numOnLines:1];
    [openView addSubview:otsLabel2];
    
    UIView *openSView = [[UIView alloc]initWithFrame:CGRectMake(90, 10 , openView.width - 90 - 20, 30)];
    openSView.layer.cornerRadius = 8;
    openSView.layer.masksToBounds = YES;
    openSView.backgroundColor = RGB_COLOR(239, 240, 241);
    [openView addSubview:openSView];
    
    self.openTimeSText = [JQXCustom creatTextFiled:CGRectMake(20, 0, openSView.width - 40, openSView.height) placeholder:@"请选择每日营业时间"];
    [openSView addSubview:self.openTimeSText];
    
    UIButton *openTimeSButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, openView.width, openView.height)];
    openTimeSButton.tag = 100;
    [openTimeSButton addTarget:self action:@selector(TimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [openSView addSubview:openTimeSButton];
    
    UIView *openEView = [[UIView alloc]initWithFrame:CGRectMake(90, openSView.bottom +10 , openView.width - 90 - 20, 30)];
    openEView.layer.cornerRadius = 8;
    openEView.layer.masksToBounds = YES;
    openEView.backgroundColor = RGB_COLOR(239, 240, 241);
    [openView addSubview:openEView];

    self.openTimeEText = [JQXCustom creatTextFiled:CGRectMake(20, 0, openEView.width - 40, openSView.height) placeholder:@"请选择每日打烊时间"];
    [openEView addSubview:self.openTimeEText];
    
    UIButton *openTimeEButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, openView.width, openView.height)];
    openTimeEButton.tag = 101;
    [openTimeEButton addTarget:self action:@selector(TimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [openEView addSubview:openTimeEButton];
    
    
    
    //非营业时间
    UIView *closeView = [[UIView alloc]initWithFrame:CGRectMake(20, openView.bottom + 10, SCREEN_WIDTH - 40, 90)];
    closeView.layer.borderWidth = 1;
    closeView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.mainScrollView addSubview:closeView];
    
    UILabel *ctsLabel = [JQXCustom creatLabel:CGRectMake(10, 10, 80, 20) backColor:[UIColor clearColor] text:@"歇业时间" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
    [closeView addSubview:ctsLabel];
   
    
    UIView *closeSView = [[UIView alloc]initWithFrame:CGRectMake(90, 10 , openView.width - 90 - 20, 30)];
    closeSView.layer.cornerRadius = 8;
    closeSView.layer.masksToBounds = YES;
    closeSView.backgroundColor = RGB_COLOR(239, 240, 241);
    [closeView addSubview:closeSView];
    
    self.closeSText = [JQXCustom creatTextFiled:CGRectMake(20, 0, openSView.width - 20, openSView.height) placeholder:@"请选择门店非营业的开始时间"];
    if(SCREEN_WIDTH < 375){
        self.closeSText.font = Font(10);
    }
    [closeSView addSubview:self.closeSText];
    
    UIButton *closeTimeSButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, openView.width, openView.height)];
    closeTimeSButton.tag = 102;
    [closeTimeSButton addTarget:self action:@selector(TimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [closeSView addSubview:closeTimeSButton];
    
    
    UIView *closeEView = [[UIView alloc]initWithFrame:CGRectMake(90, closeSView.bottom + 10 , openView.width - 90 - 20, 30)];
    closeEView.layer.cornerRadius = 8;
    closeEView.layer.masksToBounds = YES;
    closeEView.backgroundColor = RGB_COLOR(239, 240, 241);
    [closeView addSubview:closeEView];
    
    self.closeNText = [JQXCustom creatTextFiled:CGRectMake(20, 0, openEView.width - 20, openSView.height) placeholder:@"请选择门店非营业的结束时间"];
    if(SCREEN_WIDTH < 375){
        self.closeNText.font = Font(10);
    }
    [closeEView addSubview:self.closeNText];

    UIButton *closeTimeEButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, openView.width, openView.height)];
    closeTimeEButton.tag = 103;
    [closeTimeEButton addTarget:self action:@selector(TimeAction:) forControlEvents:UIControlEventTouchUpInside];
    [closeEView addSubview:closeTimeEButton];
    
    //店面经理信息
    RegisterView *shopManagerView = [[RegisterView alloc]initWithFrame:CGRectMake(20, closeView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    [shopManagerView.tsLabel setWidth:100];
    shopManagerView.tsLabel.text = @"店面经理信息";
    [self.mainScrollView addSubview:shopManagerView];
    
    UIImageView *rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(shopManagerView.width - 17, (45 - 13)/2, 7, 13)];
    rightImg.image = [UIImage imageNamed:@"me_goon"];
    [shopManagerView addSubview:rightImg];
    
    self.shopManagerButton = [JQXCustom creatButton:CGRectMake(shopManagerView.width - 150, 0, 130, shopManagerView.height) backColor:[UIColor clearColor] text:@"请输入店面经理信息" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(12) addTarget:self Action:@selector(ShopManagerAction)];
    self.shopManagerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [shopManagerView addSubview:self.shopManagerButton];
    
    //服务经理
    RegisterView *serviceManagerView = [[RegisterView alloc]initWithFrame:CGRectMake(20, shopManagerView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    [serviceManagerView.tsLabel setWidth:100];
    serviceManagerView.tsLabel.text = @"服务经理";
    [self.mainScrollView addSubview:serviceManagerView];
    
    UIImageView *rightImg1 = [[UIImageView alloc]initWithFrame:CGRectMake(shopManagerView.width - 17, (45 - 13)/2, 7, 13)];
    rightImg1.image = [UIImage imageNamed:@"me_goon"];
    [serviceManagerView addSubview:rightImg1];
    
    UIButton *serviceButton = [JQXCustom creatButton:CGRectMake(shopManagerView.width - 150, 0, 130, serviceManagerView.height) backColor:[UIColor clearColor] text:@"" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(12) addTarget:self Action:@selector(serviceAction)];
    [serviceManagerView addSubview:serviceButton];
    
    
    Y = serviceManagerView.bottom + 10;
    
    
    CGFloat xingH = Y;
    
    //前面小星星
    
    for (int i = 0; i < 8; i ++) {
        UILabel *xingLabel = [JQXCustom creatLabel:CGRectMake(0,xingH, 20, 45) backColor:[UIColor clearColor] text:@"*" textColor:BACKGROUNGCOLOR font:Font(13) textAlignment:NSTextAlignmentCenter numOnLines:1];
        if(i < 4){
            xingH = xingH + 45 + 10;
            
        }else if(i >= 4 && i < 6){
            
            xingH = xingH + 150 + 10;
            
        }else {
            
            xingH = xingH + 270 + 10;
            
        }
        
        [self.mainScrollView addSubview:xingLabel];
        
        
    }
    
    
    //企业名称
    RegisterView *companyView = [[RegisterView alloc]initWithFrame:CGRectMake(20, Y, SCREEN_WIDTH - 40, 45)];
    companyView.tsLabel.text = @"企业名称";
    [self.mainScrollView addSubview:companyView];
    
    self.companyText = [JQXCustom creatTextFiled:CGRectMake(90, 0, companyView.width - 90 - 10, companyView.height) placeholder:@"请点击输入您的企业名称(必填)"];
    self.companyText.textAlignment = NSTextAlignmentLeft;
    self.companyText.userInteractionEnabled = NO;
    [companyView addSubview:self.companyText];
    
    //门店名称
    RegisterView *shopNameView = [[RegisterView alloc]initWithFrame:CGRectMake(20, companyView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    shopNameView.tsLabel.text = @"门店名称";
    [self.mainScrollView addSubview:shopNameView];
    
    self.shopNameText = [JQXCustom creatTextFiled:CGRectMake(90, 0, shopNameView.width - 90 - 10, shopNameView.height) placeholder:@"请点击输入您的门店名称(必填)"];
    self.shopNameText.textAlignment = NSTextAlignmentLeft;
    self.shopNameText.userInteractionEnabled = NO;
    [shopNameView addSubview:self.shopNameText];
    
    //联系人
    RegisterView *contactsView = [[RegisterView alloc]initWithFrame:CGRectMake(20, shopNameView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    contactsView.tsLabel.text = @"联系人";
    [self.mainScrollView addSubview:contactsView];
    
    self.contactsText = [JQXCustom creatTextFiled:CGRectMake(90, 0, contactsView.width - 90 - 10, contactsView.height) placeholder:@"请点击输入您的联系人(必填)"];
    self.contactsText.textAlignment = NSTextAlignmentLeft;
    self.contactsText.userInteractionEnabled = NO;
    [contactsView addSubview:self.contactsText];
    //行业分类
    RegisterView *classView = [[RegisterView alloc]initWithFrame:CGRectMake(20, contactsView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    classView.tsLabel.text = @"行业分类";
    [self.mainScrollView addSubview:classView];
    
    UIImageView *classImg = [[UIImageView alloc]initWithFrame:CGRectMake(contactsView.width - 20, (classView.height - 13)/2, 7, 13)];
    classImg.image = [UIImage imageNamed:@"me_goon"];
    [classView addSubview:classImg];
    
    self.classLabel = [JQXCustom creatTextFiled:CGRectMake(100, 0, classView.width - 90 - 33, classView.height) placeholder:@"(必填)"];
    self.classLabel.userInteractionEnabled = NO;
    [classView addSubview:self.classLabel];
    
//    self.classButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, classView.width, classView.height)];
//    self.classButton.tag = 1;
//    [self.classButton addTarget:self action:@selector(classAction:) forControlEvents:UIControlEventTouchUpInside];
//    [classView addSubview:self.classButton];
    
    
    
    //营业执照
    businessView = [[UIView alloc]initWithFrame:CGRectMake(20, classView.bottom + 10, SCREEN_WIDTH - 40, 150)];

    businessView.layer.borderWidth = 1.5;
    businessView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.mainScrollView addSubview:businessView];
    
    UILabel *businessLabel = [JQXCustom creatLabel:CGRectMake(10, 0, businessView.width, 45) backColor:[UIColor clearColor] text:@"营业执照" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
    businessLabel.attributedText = [self String:@"营业执照 最多可上传1张" RangeString:@"最多可上传1张" styleStr:@"字体"];
    [businessView addSubview:businessLabel];
    
    
    
    
    //法人身份证
    IDCardView = [[UIView alloc]initWithFrame:CGRectMake(20, businessView.bottom + 10, SCREEN_WIDTH - 40, 150)];
    IDCardView.layer.borderWidth = 1.5;
    IDCardView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.mainScrollView addSubview:IDCardView];
    
    UILabel *IDCardLabel = [JQXCustom creatLabel:CGRectMake(10, 0, IDCardView.width, 45) backColor:[UIColor clearColor] text:@"法人身份证" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
    IDCardLabel.attributedText = [self String:@"法人身份证 最多可上传2张" RangeString:@"最多可上传2张" styleStr:@"字体"];
    [IDCardView addSubview:IDCardLabel];
    
    
    shopPhotoView = [[UIView alloc]initWithFrame:CGRectMake(20, IDCardView.bottom + 10, SCREEN_WIDTH - 40, 270)];
    shopPhotoView.layer.borderWidth = 1.5;
    shopPhotoView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.mainScrollView addSubview:shopPhotoView];
    
    UILabel *shopPhotoLabel = [JQXCustom creatLabel:CGRectMake(10, 0, businessView.width, 45) backColor:[UIColor clearColor] text:@"门店照片" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
    shopPhotoLabel.attributedText = [self String:@"门店照片 最多可上传5张" RangeString:@"最多可上传5张" styleStr:@"字体"];
    [shopPhotoView addSubview:shopPhotoLabel];
    
    
    
    
    otherView = [[UIView alloc]initWithFrame:CGRectMake(20, shopPhotoView.bottom + 10, SCREEN_WIDTH - 40, 270)];
    otherView.layer.borderWidth = 1.5;
    otherView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.mainScrollView addSubview:otherView];
    
    UILabel *otherLabel = [JQXCustom creatLabel:CGRectMake(10, 0, businessView.width, 45) backColor:[UIColor clearColor] text:@"行业许可证" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
    otherLabel.attributedText = [self String:@"行业许可证 最多可上传5张" RangeString:@"最多可上传5张" styleStr:@"字体"];
    [otherView addSubview:otherLabel];
    
    
    
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, otherView.bottom + 30);
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
    if(self.moneryText.text.length == 0 ||self.openTimeSText.text.length == 0 ||self.openTimeEText.text.length == 0 ||self.closeSText.text.length == 0 ||self.closeNText.text.length == 0){
         [ALToastView toastInView:self.view withText:@"信息不全，请补充"];
    }else{
        
        [JHHJView showLoadingOnTheKeyWindowWithType:2];
        NSString *merchantId = [[NSUserDefaults standardUserDefaults]objectForKey:LoginId];
        NSDictionary *params = @{@"merchantId":merchantId,@"costMoney":self.moneryText.text,@"openBeginTime":self.openTimeSText.text,@"openEndTime":self.openTimeEText.text,@"closeBeginTime":self.closeSText.text,@"closeEndTime":self.closeNText.text};
        
        [QJGlobalControl sendPOSTWithUrl:JQXHttp_MAINShopMessageMoeryTime parameters:params success:^(id data) {
            [JHHJView hideLoading];
            if([data[@"code"]integerValue] == 200){
                
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
    
}
#pragma mark - 服务经理按钮点击事件
- (void)serviceAction
{
    JQXServiceViewController *vc = [[JQXServiceViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSMutableAttributedString *)String:(NSString *)String RangeString:(NSString *)RangeString styleStr:(NSString *)styleStr
{
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:String];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:RangeString];
    if([styleStr isEqualToString:@"字体"]){
        
        [hintString addAttribute:NSForegroundColorAttributeName value: [UIColor lightGrayColor] range:range1];
        [hintString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:range1];
    }else{
        [hintString addAttribute:NSForegroundColorAttributeName value:BACKGROUNGCOLOR range:range1];
    }
    
    
    return hintString;
}

#pragma mark - 营业时间和非营业时间
- (void)TimeAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    [self.pickerView removeFromSuperview];
    self.pickerView = [[DateTimePickerView alloc] init];
    self.pickerView.delegate = self;
    
    if(sender.tag == 100){//营业开始时间
        
        self.dateStr = @"营业开始时间";
        self.pickerView.pickerViewMode = DatePickerViewTimeMode;
        [self.view addSubview:self.pickerView];
        [self.pickerView showDateTimePickerView];
        
    }else if (sender.tag == 101){//打烊时间
        
        self.dateStr = @"打烊时间";
        self.pickerView.pickerViewMode = DatePickerViewTimeMode;
        [self.view addSubview:self.pickerView];
        [self.pickerView showDateTimePickerView];
        
    }else if (sender.tag == 102){//非营业开始时间
        
        self.dateStr = @"非营业开始时间";
        self.pickerView.pickerViewMode = DatePickerViewDateTimeMode;
        [self.view addSubview:self.pickerView];
        [self.pickerView showDateTimePickerView];
        
    }else if (sender.tag == 103){//非营业结束时间
        
        self.dateStr = @"非营业结束时间";
        self.pickerView.pickerViewMode = DatePickerViewDateTimeMode;
        [self.view addSubview:self.pickerView];
        [self.pickerView showDateTimePickerView];
    }
}
#pragma mark - delegate
- (void)didClickFinishDateTimePickerView:(NSString *)date{
    if([self.dateStr isEqualToString:@"营业开始时间"]){
       
        self.openTimeSText.text = date;
        
    }else if ([self.dateStr isEqualToString:@"打烊时间"]){
        
        self.openTimeEText.text = date;
        
    }else if ([self.dateStr isEqualToString:@"非营业开始时间"]){
        
        self.closeSText.text = date;
        
    }else if ([self.dateStr isEqualToString:@"非营业结束时间"]){
        
        self.closeNText.text = date;
        
    }
    
    
}

#pragma mark - 店面经理
- (void)ShopManagerAction
{
    NSString *status = @"";
    if([self.shopManagerDic isEqual:[NSNull null]]){ //初始化
        status = @"3";
    }else{
        status =  [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.shopManagerDic[@"certification"])];
    }

    MainShopManagerViewController *vc = [[MainShopManagerViewController alloc]init];
    vc.styleStr = status;//0审核中 1已审核 2审核失败 3.初始化
    vc.mainDic = self.shopManagerDic;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 获取信息
- (void)getShopMessage
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSDictionary *params = @{@"id":self.merchantId};
    
    [QJGlobalControl sendPOSTWithUrl:JQXHttp_MAINShopMessage parameters:params success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"]integerValue] == 200){
            self.shopManagerDic = data[@"data"][@"storemanager"];
            if([editShop isEqualToString:@"未更改"]){
                [self setContentMessage:data[@"data"][@"merchant"]];
            }else{
                [self updateSHopMessage:data[@"data"][@"merchant"]];
            }
            
            
            
        }else{
            
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
}
#pragma mark - 更新店面经理状态
- (void)updateSHopMessage:(NSDictionary *)dic
{
    if([self.shopManagerDic isEqual:[NSNull null]]){
        NSLog(@"hahahahaahaaahaha");
        [self.shopManagerButton setTitle:@"请输入店面经理信息" forState:UIControlStateNormal];
    }else{
        //店面经理
        NSString *certification = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.shopManagerDic[@"certification"])];
        if([certification isEqualToString:@"1"]){
            
            NSString *status = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.shopManagerDic[@"status"])];//0在职 1解聘
            if([status isEqualToString:@"0"]){
                //                NSString *name = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.shopManagerDic[@"memberName"])];
                [self.shopManagerButton setTitle:@"审核通过" forState:UIControlStateNormal];
            }else{
                [self.shopManagerButton setTitle:@"请输入店面经理信息" forState:UIControlStateNormal];
            }
            
            
            
        }else if ([certification isEqualToString:@"0"]){
            [self.shopManagerButton setTitle:@"审核中" forState:UIControlStateNormal];
        }else{
            [self.shopManagerButton setTitle:@"未审核" forState:UIControlStateNormal];//审核失败
        }
    }
}
#pragma mark - 设置信息
- (void)setContentMessage:(NSDictionary *)dic
{
    //人均消费
    NSString *monerystr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"costMoney"])];

    if([monerystr isEqualToString:@"(null)"]){
        monerystr = @"";
    }
    self.moneryText.text = monerystr;
    //营业开始时间
    NSString *openSstr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"openBeginTime"])];
    
    if([openSstr isEqualToString:@"(null)"]){
        openSstr = @"";
    }
    self.openTimeSText.text = openSstr;
    //打烊时间
    NSString *openEstr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"openEndTime"])];
    
    if([openEstr isEqualToString:@"(null)"]){
        openEstr = @"";
    }
    self.openTimeEText.text = openEstr;
    
    //非营业开始时间
    NSString *closeSstr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"closeBeginTime"])];
    
    if([closeSstr isEqualToString:@"(null)"]){
        closeSstr = @"";
    }
    self.closeSText.text = closeSstr;
    
    //非营业结束时间
    NSString *closeEstr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"closeEndTime"])];
    
    if([closeEstr isEqualToString:@"(null)"]){
        closeEstr = @"";
    }
    self.closeNText.text = closeEstr;
    NSLog(@"%@",self.shopManagerDic);
    
    if([self.shopManagerDic isEqual:[NSNull null]]){
        NSLog(@"hahahahaahaaahaha");
        [self.shopManagerButton setTitle:@"请输入店面经理信息" forState:UIControlStateNormal];
    }else{
        //店面经理
        NSString *certification = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.shopManagerDic[@"certification"])];
        if([certification isEqualToString:@"1"]){
            
             NSString *status = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.shopManagerDic[@"status"])];//0在职 1解聘
            if([status isEqualToString:@"0"]){
//                NSString *name = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.shopManagerDic[@"memberName"])];
                [self.shopManagerButton setTitle:@"审核通过" forState:UIControlStateNormal];
            }else{
                [self.shopManagerButton setTitle:@"请输入店面经理信息" forState:UIControlStateNormal];
            }
            
            
            
        }else if ([certification isEqualToString:@"0"]){
            [self.shopManagerButton setTitle:@"审核中" forState:UIControlStateNormal];
        }else{
            [self.shopManagerButton setTitle:@"未审核" forState:UIControlStateNormal];//审核失败
        }
    }
    
    //企业名称
    self.companyText.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"companyName"])];
    //门店名称
    self.shopNameText.text =[NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"merchantName"])];
    //联系人
    self.contactsText.text =[NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"personName"])];
    //行业分类
    if(![dic[@"merchantType"] isEqual:[NSNull null]]){
        NSArray *merchantArr = dic[@"merchantType"];
        NSString *merchantStr = [merchantArr componentsJoinedByString:@"-"];
        self.classLabel.text = merchantStr;
    }else{
        self.classLabel.text = @" ";
    }
    
    
    CGFloat imgWidth = (225 - 50)/2;
    CGFloat gwidth = (shopPhotoView.width - imgWidth *3)/4;

    //营业执照
    NSArray *bussArr = dic[@"yingye"];
    NSDictionary *bussDic = [bussArr objectAtIndex:0];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(gwidth, 30 + (120 - imgWidth)/2, imgWidth, imgWidth)];
    NSString *imgstr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(bussDic[@"url"])];
    [img sd_setImageWithURL:[NSURL URLWithString:imgstr] placeholderImage:[UIImage imageNamed:@"JQXShi"]];
    [businessView addSubview:img];
    
    //身份证
    NSArray *IDArr = dic[@"idcard"];
    for (int i = 0; i < IDArr.count; i ++) {
        NSDictionary *idDic = [IDArr objectAtIndex:i];
        NSString *imgstr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(idDic[@"url"])];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((i + 1) *gwidth +i *imgWidth, 30 + (120 - imgWidth)/2, imgWidth, imgWidth)];
        [img sd_setImageWithURL:[NSURL URLWithString:imgstr] placeholderImage:[UIImage imageNamed:@"JQXShi"]];
        [IDCardView addSubview:img];
    }

    //门店
    NSArray *shopArr = dic[@"mendian"];
    for (int i = 0; i < shopArr.count; i ++) {
        NSDictionary *shopDic = [shopArr objectAtIndex:i];
        NSString *imgstr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(shopDic[@"url"])];
        int yIndex = i/3;
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((i + 1) *gwidth +i *imgWidth - yIndex * shopPhotoView.width + yIndex *gwidth, 30 + 10 + yIndex *10 + yIndex *imgWidth, imgWidth, imgWidth)];
        
        [img sd_setImageWithURL:[NSURL URLWithString:imgstr] placeholderImage:[UIImage imageNamed:@"JQXShi"]];
        [shopPhotoView addSubview:img];
    }
    //行业
    NSArray *otherArr = dic[@"other"];
    for (int i = 0; i < otherArr.count; i ++) {
        NSDictionary *otherDic = [otherArr objectAtIndex:i];
        NSString *imgstr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(otherDic[@"url"])];

        int yIndex = i/3;
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((i + 1) *gwidth +i *imgWidth - yIndex * shopPhotoView.width + yIndex *gwidth, 30 + 10 + yIndex *10 + yIndex *imgWidth, imgWidth, imgWidth)];
         [img sd_setImageWithURL:[NSURL URLWithString:imgstr] placeholderImage:[UIImage imageNamed:@"JQXShi"]];
        [otherView addSubview:img];
    }
}
#pragma mark - 判断人均消费
- (void)TextChange:(UITextField *)textFiled
{
    int MAX = 9;
    if(textFiled == self.moneryText){
        NSString *moneryStr = [NSString stringWithFormat:@"%@",self.moneryText.text];
        if(moneryStr.length > MAX){
            
            NSRange rangeRange = [moneryStr rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX)];
            self.moneryText.text = [moneryStr substringWithRange:rangeRange];
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField == self.moneryText){
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
- (NSDictionary *)shopManagerDic
{
    if(!_shopManagerDic){
        _shopManagerDic = [NSDictionary dictionary];
    }
    return _shopManagerDic;
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
