//
//  JQXRegisterViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/24.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "JQXRegisterViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "RegisterView.h"
#import "CityPickerView.h"
#import "AreaPickerView.h"
#import "ChoosePhoController.h"
#import "JKCountDownButton.h"
#import "ClassView.h"
#import "ShopAddressViewController.h"
#import "RegisterWebViewController.h"
@interface JQXRegisterViewController ()
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *mainScrollView;
@property (nonatomic,strong)UITextField *phoneText;//手机号
@property (nonatomic,strong)UITextField *companyText;//企业名称
@property (nonatomic,strong)UITextField *shopNameText;//门店名称
@property (nonatomic,strong)UITextField *contactsText;//联系人
@property (nonatomic,strong)UITextField *managerText;//管理比例费用
@property (nonatomic,strong)UITextField *extensionText;//推广师手机号
@property (nonatomic,strong)UITextField *nameText;//推广师姓名
@property (nonatomic,strong)UITextField *cityLabel;//门店区域
@property (nonatomic,strong)CityPickerView *cityVC;
@property (nonatomic,strong)AreaPickerView *areaVC;
@property (nonatomic,strong)ClassView *classListVC;
@property (nonatomic,strong)UIView *markView;//遮罩试图
@property (nonatomic,strong)UITextField *areaLabel;//所属区域
@property (nonatomic,strong)UITextField *addressXText;//详细地址
@property (nonatomic,strong)UITextField *mapLabel;//门店定位
@property (nonatomic,strong)UITextField *classLabel;//行业分类
@property (nonatomic,strong)UIButton *classButton;//行业分类按钮
@property (nonatomic,strong)UIImageView *classImg;//行业分类箭头
@property (nonatomic,strong)UITextField *codeText;//短信验证码
@property (nonatomic,strong)JKCountDownButton *numButton;//获取验证码按钮
@property (nonatomic,strong)NSString *countyCodeID;//第三级区域ID
@property (nonatomic,strong)NSArray *classArray;//行业分类
@property (nonatomic,strong)NSArray *businessArray;//营业执照图片数组
@property (nonatomic,strong)NSArray *IDCardArray;//法人身份证数组
@property (nonatomic,strong)NSArray *shopPhotoArray;//门店照片数组
@property (nonatomic,strong)NSArray *otherArray;//其他照片数组
@property (nonatomic,strong)NSString *longitudeStr;//经度
@property (nonatomic,strong)NSString *latitudeStr;//纬度
@property (nonatomic,strong)NSMutableDictionary *params;//传参数
@property (nonatomic,strong)NSString *extensionID;//推广师ID
@property (nonatomic,strong)NSString *proviceID;//省ID
@property (nonatomic,strong)NSString *cityID;//市ID  区 IDcountyCodeID
@property (nonatomic,strong)NSString *townID;//镇ID;
@property (nonatomic,strong)NSString *positionId;//社区主键ID

@end

@implementation JQXRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"申请商户" isBack:YES];
    self.mainScrollView = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.mainScrollView];
    [self setUI];
    //门店区域取消按钮点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CancleActon:) name:@"PickerViewCancle" object:nil];
    
    //门店区域确定按钮点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SureActon:) name:@"PickerViewSure" object:nil];
    //所属区域确定按钮点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AreaSureActon:) name:@"AreaPickerViewSure" object:nil];
    
    //行业分类确定按钮点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ClassSureActon:) name:@"ClassPickerViewSure" object:nil];
    
    //上传图片
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UPImageActon:) name:@"UpImage" object:nil];
    
    
    //正在上传图片
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UPImageLoadingActon:) name:@"UpImageLoading" object:nil];
   
}

#pragma mark - 门店区域取消按钮点击通知
- (void)CancleActon:(NSNotification *)notif
{
    [self.markView removeFromSuperview];
}
#pragma mark - 门店区域确定按钮点击通知
- (void)SureActon:(NSNotification *)notif
{
    [self.markView removeFromSuperview];
    NSDictionary *dic = notif.userInfo;
    self.cityLabel.text = [NSString stringWithFormat:@"%@ - %@ - %@",NULL_TO_NIL(dic[@"province"][@"areaName"]),NULL_TO_NIL(dic[@"city"][@"areaName"]),NULL_TO_NIL(dic[@"country"][@"areaName"])];
    self.countyCodeID = NULL_TO_NIL(dic[@"country"][@"areaId"]);
    self.proviceID = NULL_TO_NIL(dic[@"province"][@"areaId"]);
    self.cityID = NULL_TO_NIL(dic[@"city"][@"areaId"]);

}
#pragma mark - 所属区域确定按钮点击通知
- (void)AreaSureActon:(NSNotification *)notif
{
    [self.markView removeFromSuperview];
    NSDictionary *dic = notif.userInfo;
    self.areaLabel.text = NULL_TO_NIL(dic[@"town"][@"townName"]);
    self.townID = NULL_TO_NIL(dic[@"city"][@"townId"]);
    self.positionId = NULL_TO_NIL(dic[@"city"][@"id"]);
}
#pragma mark - 行业分类确定按钮点击通知
- (void)ClassSureActon:(NSNotification *)notif
{
    [self.markView removeFromSuperview];
    self.classArray = notif.userInfo[@"classSure"];
    if(self.classArray.count != 0){
        NSMutableArray *showArray = [NSMutableArray array];
        for (int i = 0; i < self.classArray.count; i ++) {
            NSDictionary *dic = [self.classArray objectAtIndex:i];
            NSDictionary *smallDic = dic[@"selectedChildren"];
            NSString *showStr = [NSString stringWithFormat:@"%@",smallDic[@"merchantTypeName"]];
            [showArray addObject:showStr];
        }
        NSString *showText = [showArray componentsJoinedByString:@"-"];
        self.classLabel.text = showText;
        
    }
    
    
    
}
#pragma mark - 图片上传
- (void)UPImageActon:(NSNotification *)notif
{
    NSString *str = [NSString stringWithFormat:@"%@",notif.userInfo[@"test"]];
    [ALToastView toastInView:self.view withText:str];
}
- (void)UPImageLoadingActon:(NSNotification *)notif
{
    NSString *str = [NSString stringWithFormat:@"%@",notif.userInfo[@"test"]];

    if([str isEqualToString:@"正在上传"]){
        [JHHJView showLoadingOnTheKeyWindowWithType:2];

    }else{
        
         [JHHJView hideLoading];
    }
}
- (void)setUI{
    
    //手机号
    RegisterView *phoneView = [[RegisterView alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, 45)];
    phoneView.tsLabel.text = @"手机号";
    [self.mainScrollView addSubview:phoneView];
    
    self.phoneText = [self creatTextFiled:CGRectMake(90, 0, phoneView.width - 90 - 10, phoneView.height) placeholder:@"请点击输入您的手机号(必填)"];
    self.phoneText.keyboardType = UIKeyboardTypeNumberPad;
    [self.phoneText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [phoneView addSubview:self.phoneText];
    
    //企业名称
    RegisterView *companyView = [[RegisterView alloc]initWithFrame:CGRectMake(20, phoneView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    companyView.tsLabel.text = @"企业名称";
    [self.mainScrollView addSubview:companyView];
    
    self.companyText = [self creatTextFiled:CGRectMake(90, 0, companyView.width - 90 - 10, companyView.height) placeholder:@"请点击输入您的企业名称(必填)"];
    [companyView addSubview:self.companyText];
    
    //门店名称
    RegisterView *shopNameView = [[RegisterView alloc]initWithFrame:CGRectMake(20, companyView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    shopNameView.tsLabel.text = @"门店名称";
    [self.mainScrollView addSubview:shopNameView];
    
    self.shopNameText = [self creatTextFiled:CGRectMake(90, 0, shopNameView.width - 90 - 10, shopNameView.height) placeholder:@"请点击输入您的门店名称(必填)"];
    [shopNameView addSubview:self.shopNameText];
    
    //联系人
    RegisterView *contactsView = [[RegisterView alloc]initWithFrame:CGRectMake(20, shopNameView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    contactsView.tsLabel.text = @"联系人";
    [self.mainScrollView addSubview:contactsView];
    
    self.contactsText = [self creatTextFiled:CGRectMake(90, 0, contactsView.width - 90 - 10, contactsView.height) placeholder:@"请点击输入您的联系人(必填)"];
    self.contactsText.keyboardType = UIKeyboardTypeNumberPad;
    [contactsView addSubview:self.contactsText];
    
    //管理比例费用
    RegisterView *moneryView = [[RegisterView alloc]initWithFrame:CGRectMake(20, contactsView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    [moneryView.tsLabel setWidth:moneryView.width];
    moneryView.tsLabel.text = @"管理比例费用：";
    [self.mainScrollView addSubview:moneryView];
    
    self.managerText = [self creatTextFiled:CGRectMake(90, 0, moneryView.width - 90 - 10, moneryView.height) placeholder:@"管理费用比例（0.13 - 0.39）(必填)"];
    self.managerText.keyboardType = UIKeyboardTypeDecimalPad;
    [moneryView addSubview:self.managerText];

    
    
    //推广师手机号
    RegisterView *extensionView = [[RegisterView alloc]initWithFrame:CGRectMake(20, moneryView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    extensionView.tsLabel.text = @"推广师";
    [self.mainScrollView addSubview:extensionView];
    
    self.extensionText = [self creatTextFiled:CGRectMake(90, 0, extensionView.width - 90 - 10, extensionView.height) placeholder:@"请点击输入您的推广师电话"];
    self.extensionText.keyboardType = UIKeyboardTypeNumberPad;
    [self.extensionText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [extensionView addSubview:self.extensionText];
    
    //推广师姓名
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(20, extensionView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    nameView.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f];
    [self.mainScrollView addSubview:nameView];
    
    UILabel *tsLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, nameView.height)];
    tsLabel2.text = @"推广师姓名";
    tsLabel2.font = [UIFont systemFontOfSize:14];
    [nameView addSubview:tsLabel2];
    
    self.nameText = [[UITextField alloc]initWithFrame:CGRectMake(tsLabel2.right + 10, 0, nameView.width - tsLabel2.width - 30, nameView.height)];
    self.nameText.userInteractionEnabled = NO;
    self.nameText.textAlignment = NSTextAlignmentRight;
    self.nameText.textColor = [UIColor whiteColor];
    self.nameText.font = [UIFont systemFontOfSize:13];
    self.nameText.text = @"自动获取";
    [nameView addSubview:self.nameText];
    
    //门店区域
    RegisterView *shopCityView = [[RegisterView alloc]initWithFrame:CGRectMake(20, nameView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    shopCityView.tsLabel.text = @"门店区域:";
    [self.mainScrollView addSubview:shopCityView];
    
    UIImageView *moreimgf = [[UIImageView alloc]initWithFrame:CGRectMake(shopCityView.width - 20, (shopCityView.height - 13)/2, 7, 13)];
    moreimgf.image = [UIImage imageNamed:@"me_goon"];
    [shopCityView addSubview:moreimgf];
    
    self.cityLabel = [self creatTextFiled:CGRectMake(100, 0, contactsView.width - 90 - 33, contactsView.height) placeholder:@"(必填)"];
    self.cityLabel.userInteractionEnabled = NO;
    [shopCityView addSubview:self.cityLabel];
    
    UIButton *cityButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, shopCityView.width, shopCityView.height)];
    [cityButton addTarget:self action:@selector(CityAction) forControlEvents:UIControlEventTouchUpInside];
    [shopCityView addSubview:cityButton];
    
    //所属区域
    RegisterView *areaView = [[RegisterView alloc]initWithFrame:CGRectMake(20, shopCityView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    areaView.tsLabel.text = @"所属区域:";
    [self.mainScrollView addSubview:areaView];
    
    UIImageView *moreimga = [[UIImageView alloc]initWithFrame:CGRectMake(areaView.width - 20, (areaView.height - 13)/2, 7, 13)];
    moreimga.image = [UIImage imageNamed:@"me_goon"];
    [areaView addSubview:moreimga];
    
    self.areaLabel = [self creatTextFiled:CGRectMake(100, 0, contactsView.width - 90 - 33, contactsView.height) placeholder:@"(必填)"];
    self.areaLabel.userInteractionEnabled = NO;
    [areaView addSubview:self.areaLabel];
    
    UIButton *areaButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, shopCityView.width, shopCityView.height)];
    [areaButton addTarget:self action:@selector(areaAction) forControlEvents:UIControlEventTouchUpInside];
    [areaView addSubview:areaButton];
    
    
    //详细地址
    RegisterView *addressView = [[RegisterView alloc]initWithFrame:CGRectMake(20, areaView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    addressView.tsLabel.text = @"详细地址";
    [self.mainScrollView addSubview:addressView];
    
    self.addressXText = [self creatTextFiled:CGRectMake(90, 0, addressView.width - 90 - 10, shopNameView.height) placeholder:@"请点击输入您的详细地址(必填)"];
    [addressView addSubview:self.addressXText];

    

    //门店定位
    RegisterView *shopMapView = [[RegisterView alloc]initWithFrame:CGRectMake(20, addressView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    shopMapView.tsLabel.text = @"门店定位";
    [self.mainScrollView addSubview:shopMapView];
    
    UIImageView *moreimg = [[UIImageView alloc]initWithFrame:CGRectMake(shopMapView.width - 20, (shopMapView.height - 13)/2, 7, 13)];
    moreimg.image = [UIImage imageNamed:@"me_goon"];
    [shopMapView addSubview:moreimg];
    
    self.mapLabel = [self creatTextFiled:CGRectMake(100, 0, contactsView.width - 90 - 33, contactsView.height)  placeholder:@"(必填)"];
    self.mapLabel.userInteractionEnabled = NO;
    [shopMapView addSubview:self.mapLabel];
    
    UIButton *mapButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, shopMapView.width, shopMapView.height)];
    [mapButton addTarget:self action:@selector(MapAction) forControlEvents:UIControlEventTouchUpInside];
    [shopMapView addSubview:mapButton];
    
    //行业分类
    RegisterView *classView = [[RegisterView alloc]initWithFrame:CGRectMake(20, shopMapView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    classView.tsLabel.text = @"行业分类";
    [self.mainScrollView addSubview:classView];
    
    self.classImg = [[UIImageView alloc]initWithFrame:CGRectMake(shopMapView.width - 20, (classView.height - 13)/2, 7, 13)];
    self.classImg.image = [UIImage imageNamed:@"me_goon"];
    [classView addSubview:self.classImg];
    
    self.classLabel = [self creatTextFiled:CGRectMake(100, 0, classView.width - 90 - 33, classView.height) placeholder:@"(必填)"];
    self.classLabel.userInteractionEnabled = NO;
    [classView addSubview:self.classLabel];
    
    self.classButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, classView.width, classView.height)];
    self.classButton.tag = 1;
    [self.classButton addTarget:self action:@selector(classAction:) forControlEvents:UIControlEventTouchUpInside];
    [classView addSubview:self.classButton];
    
    
    //营业执照
    UIView *businessView = [[UIView alloc]initWithFrame:CGRectMake(20, classView.bottom + 10, SCREEN_WIDTH - 40, 150)];
    businessView.layer.borderWidth = 1.5;
    businessView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.mainScrollView addSubview:businessView];
    
    UILabel *businessLabel = [JQXCustom creatLabel:CGRectMake(10, 0, businessView.width, 30) backColor:[UIColor clearColor] text:@"营业执照" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
    businessLabel.attributedText = [self String:@"营业执照 最多可上传1张" RangeString:@"最多可上传1张" styleStr:@"字体"];
    [businessView addSubview:businessLabel];
    
    
    
    ChoosePhoController *choosePhotoVC = [[ChoosePhoController alloc] init];

    choosePhotoVC.view.frame = CGRectMake(10, businessLabel.bottom + 5, businessView.width - 20, businessView.height - 35);
    
    [choosePhotoVC sendStrFunc:CGSizeMake(choosePhotoVC.view.frame.size.width, choosePhotoVC.view.frame.size.height) maxNumber:1 showNumber:3];
    
    [choosePhotoVC PhotoArray:^(NSMutableArray *photoArray) {
//        NSLog(@"photoArray ======   %@",photoArray);
        self.businessArray = photoArray;
         NSLog(@"businessArray ======   %@",photoArray);
    }];
    UIView *view = [self.mainScrollView viewWithTag:1001];
    
    if (view == nil) {
        
        choosePhotoVC.view.tag = 1001;
        [self addChildViewController:choosePhotoVC];
        [businessView addSubview:choosePhotoVC.view];
        
    }

    //法人身份证
    UIView *IDCardView = [[UIView alloc]initWithFrame:CGRectMake(20, businessView.bottom + 10, SCREEN_WIDTH - 40, 150)];
    IDCardView.layer.borderWidth = 1.5;
    IDCardView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.mainScrollView addSubview:IDCardView];
    
    UILabel *IDCardLabel = [JQXCustom creatLabel:CGRectMake(10, 0, IDCardView.width, 30) backColor:[UIColor clearColor] text:@"法人身份证" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
    IDCardLabel.attributedText = [self String:@"法人身份证 最多可上传2张" RangeString:@"最多可上传2张" styleStr:@"字体"];
    [IDCardView addSubview:IDCardLabel];
    
    
    
    ChoosePhoController *IDVC = [[ChoosePhoController alloc] init];
    
    IDVC.view.frame = CGRectMake(10, IDCardLabel.bottom + 5, IDCardLabel.width - 20, businessView.height - 35);
    
    [IDVC sendStrFunc:CGSizeMake(choosePhotoVC.view.frame.size.width, choosePhotoVC.view.frame.size.height) maxNumber:2 showNumber:3];
    
    [IDVC PhotoArray:^(NSMutableArray *photoArray) {
//        NSLog(@"photoArray ======   %@",photoArray);
        self.IDCardArray = photoArray;
         NSLog(@"self.IDCardArray ======   %@",photoArray);
    }];
    
    UIView *IDview = [self.mainScrollView viewWithTag:1002];
    
    if (IDview == nil) {
        
        IDVC.view.tag = 1002;
        [self addChildViewController:IDVC];
        [IDCardView addSubview:IDVC.view];
        
    }
    
    //门店照片
    UIView *shopPhotoView = [[UIView alloc]initWithFrame:CGRectMake(20, IDCardView.bottom + 10, SCREEN_WIDTH - 40, 150)];
    shopPhotoView.layer.borderWidth = 1.5;
    shopPhotoView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.mainScrollView addSubview:shopPhotoView];
    
    UILabel *shopPhotoLabel = [JQXCustom creatLabel:CGRectMake(10, 0, businessView.width, 30) backColor:[UIColor clearColor] text:@"门店照片" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
    shopPhotoLabel.attributedText = [self String:@"门店照片 最多可上传1张" RangeString:@"最多可上传1张" styleStr:@"字体"];
    [shopPhotoView addSubview:shopPhotoLabel];
    
    
    
    ChoosePhoController *shopPhotoVC = [[ChoosePhoController alloc] init];
    
    shopPhotoVC.view.frame = CGRectMake(10, shopPhotoLabel.bottom + 5, shopPhotoView.width - 20, shopPhotoView.height - 35);
    
    [shopPhotoVC sendStrFunc:CGSizeMake(choosePhotoVC.view.frame.size.width, choosePhotoVC.view.frame.size.height) maxNumber:1 showNumber:3];
    
    [shopPhotoVC PhotoArray:^(NSMutableArray *photoArray) {
        self.shopPhotoArray = photoArray;
        NSLog(@"shopPhotoArray ======   %@",photoArray);
    }];
    
    UIView *shopPhotoview = [self.mainScrollView viewWithTag:1003];
    
    if (shopPhotoview == nil) {
        
        shopPhotoVC.view.tag = 1003;
        [self addChildViewController:shopPhotoVC];
        [shopPhotoView addSubview:shopPhotoVC.view];
        
    }

    
    //其他资料
    UIView *otherView = [[UIView alloc]initWithFrame:CGRectMake(20, shopPhotoView.bottom + 10, SCREEN_WIDTH - 40, 270)];
    otherView.layer.borderWidth = 1.5;
    otherView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.mainScrollView addSubview:otherView];
    
    UILabel *otherLabel = [JQXCustom creatLabel:CGRectMake(10, 0, businessView.width, 30) backColor:[UIColor clearColor] text:@"其他资料" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
    otherLabel.attributedText = [self String:@"其他资料 最多可上传5张" RangeString:@"最多可上传5张" styleStr:@"字体"];
    [otherView addSubview:otherLabel];
    
    
    
    ChoosePhoController *otherVC = [[ChoosePhoController alloc] init];
    
    otherVC.view.frame = CGRectMake(10, otherLabel.bottom + 5, otherView.width - 20, otherView.height - 35);
    
    [otherVC sendStrFunc:CGSizeMake(otherVC.view.frame.size.width, otherVC.view.frame.size.height) maxNumber:5 showNumber:3];
    
    [otherVC PhotoArray:^(NSMutableArray *photoArray) {
        self.otherArray = photoArray;
        NSLog(@"otherArray ======   %@",photoArray);
    }];
    
    UIView *othernewview = [self.mainScrollView viewWithTag:1004];
    
    if (othernewview == nil) {
        
        otherVC.view.tag = 1004;
        [self addChildViewController:otherVC];
        [otherView addSubview:otherVC.view];
        
    }
    
    //验证码
    UIView *codeView = [[UIView alloc]initWithFrame:CGRectMake(20, otherView.bottom + 10, SCREEN_WIDTH - 150, 45)];
    codeView.layer.borderWidth = 1.5;
    codeView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.mainScrollView addSubview:codeView];
    
    self.codeText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, codeView.width - 20, codeView.height)];
    self.codeText.keyboardType = UIKeyboardTypeNumberPad;
    self.codeText.font = [UIFont systemFontOfSize:13];
    self.codeText.placeholder = @"请输入手机验证码";
    [codeView addSubview:self.codeText];
    
    self.numButton = [[JKCountDownButton alloc]initWithFrame:CGRectMake(codeView.right + 10, otherView.bottom + 12.5 , otherView.width - codeView.width - 10, 40)];
    self.numButton.backgroundColor = BACKGROUNGCOLOR;
    self.numButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.numButton.layer.masksToBounds = YES;
    self.numButton.layer.cornerRadius = 5;
    [self.numButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.numButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.numButton addTarget:self action:@selector(numAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.numButton];


    
    UIButton *sumbitButton = [JQXCustom creatButton:CGRectMake(60, codeView.bottom + 40 , SCREEN_WIDTH - 120, 40) backColor:BACKGROUNGCOLOR text:@"立即申请" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14] addTarget:self Action:@selector(sumbitAction)];
    sumbitButton.layer.masksToBounds = YES;
    sumbitButton.layer.cornerRadius = 5;
    
    [self.mainScrollView addSubview:sumbitButton];
    
    
    UIButton *ReginSerButton = [JQXCustom creatButton:CGRectMake(0, sumbitButton.bottom + 10 , SCREEN_WIDTH, 20) backColor:[UIColor whiteColor] text:@"《普惠联盟商户服务协议》" textColor:BACKGROUNGCOLOR font:[UIFont systemFontOfSize:14] addTarget:self Action:@selector(ReginSerButton)];
    [self.mainScrollView addSubview:ReginSerButton];
    
    
    UILabel *tsLable = [JQXCustom creatLabel:CGRectMake(0, ReginSerButton.bottom + 10, SCREEN_WIDTH, 20) backColor:[UIColor clearColor] text:@"已经是商户，立即登录" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentCenter numOnLines:1];
    tsLable.attributedText = [self String:@"已经是商户，立即登录" RangeString:@"立即登录" styleStr:@"其他"];
    [self.mainScrollView addSubview:tsLable];
    
    UIButton *LoginButton = [JQXCustom creatButton:CGRectMake(0, ReginSerButton.bottom + 5, SCREEN_WIDTH, 30) backColor:[UIColor clearColor] text:@"" textColor:[UIColor clearColor] font:[UIFont systemFontOfSize:12] addTarget:self Action:@selector(PopAction)];
    [self.mainScrollView addSubview:LoginButton];
    
    
    //设置滑动视图内容
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 45 * 11 + 10 *11 + 20 + 64 + 970);

}
#pragma mark - 注册协议
- (void)ReginSerButton
{
    RegisterWebViewController *webVC = [[RegisterWebViewController alloc]init];
    [self.navigationController pushViewController:webVC animated:YES];
}
#pragma mark - 立即申请
- (void)sumbitAction
{
    if(self.phoneText.text.length == 0 || self.companyText.text.length == 0|| self.shopNameText.text.length == 0 || self.contactsText.text.length == 0 ||self.nameText.text.length == 0 ||self.managerText.text.length == 0|| self.cityLabel.text.length == 0 ||self.areaLabel.text .length == 0 ||self.addressXText.text.length == 0 || self.mapLabel.text.length == 0|| self.classLabel.text.length == 0 || self.classArray.count == 0 || self.businessArray.count == 0 || self.IDCardArray.count == 0 || self.shopPhotoArray.count == 0 || self.codeText.text == 0){
        
        [ALToastView toastInView:self.view withText:@"信息填写不完整"];
        
    }else{
        
        [self ReginsterActionData];
        
    }
}
- (void)PopAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 门店区域
- (void)CityAction
{
    [self.view endEditing:YES];
    //获取三级联动信息
    [self getCityAreaListData];
    
}

#pragma mark - 所属区域
- (void)areaAction
{
    
    if(self.cityLabel.text.length == 0){
        
        [ALToastView toastInView:self.view withText:@"请先选择门店区域"];
        
    }else{
        [self.view endEditing:YES];
        //获取区域信息
        [self getAreaListData];
    }
    

}
#pragma mark - 门店定位
- (void)MapAction
{
    ShopAddressViewController *shopVC = [[ShopAddressViewController alloc]init];
     shopVC.styleStr = @"不保存";
    [shopVC messageText:^(NSMutableDictionary *messageDic) {
        self.mapLabel.text = [NSString stringWithFormat:@"%@",messageDic[@"name"]];
        self.longitudeStr = [NSString stringWithFormat:@"%@",messageDic[@"longitude"]];
        self.latitudeStr = [NSString stringWithFormat:@"%@",messageDic[@"latitude"]];

    }];
    [self.navigationController pushViewController:shopVC animated:YES];
}
#pragma mark - 行业分类
- (void)classAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    //获取行业分类列表
    [self getClassListData];
}
- (UITextField *)creatTextFiled:(CGRect)frame placeholder:(NSString *)placeholderN
{
    UITextField *textFiled = [[UITextField alloc]initWithFrame:frame];
    textFiled.textAlignment = NSTextAlignmentRight;
    textFiled.placeholder = placeholderN;
    textFiled.font = [UIFont systemFontOfSize:13];
    return textFiled;
}

#pragma mark  - 短信验证码
- (void)numAction:(JKCountDownButton *)sender
{
    [self.view endEditing:YES];
    
    if(self.phoneText.text.length == 11){
        
        NSString *url = [NSString stringWithFormat:@"%@/%@/%@",http_CodeURL,self.phoneText.text,@"PH20170122"];
        [QJGlobalControl sendGETWithUrl:url parameters:nil success:^(id data) {
            if([data[@"code"]integerValue] == 200){
                [ALToastView toastInView:self.view withText:@"发送验证码成功"];
                
                sender.enabled = NO;
                
                [sender startWithSecond:60];
                
                [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                    
                    sender.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f];
                    sender.layer.borderColor = [UIColor lightGrayColor].CGColor;
                    NSString *title = [NSString stringWithFormat:@"%d秒",second];
                    [countDownButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    return title;
                    
                }];
                
                [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                    
                    sender.backgroundColor = BACKGROUNGCOLOR;
                    countDownButton.enabled = YES;
                    
                   [countDownButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    
                    
                    return @"重新获取";
                    
                }];
                
            }else{
                
                [ALToastView toastInView:self.view withText:data[@"message"]];
            }
        } fail:^(NSError *error) {
            [ALToastView toastInView:self.view withText:@"请求失败"];
        }];
        
    }else{
        [ALToastView toastInView:self.view withText:@"请输入正确手机号"];
    }
    
    
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

#pragma mark - 判断电话多少位推广师电话
- (void)TextChange:(UITextField *)textFiled
{
    if (textFiled == self.extensionText) {
        if(self.extensionText.text.length == 11){
            [self.view endEditing:YES];
            [self getNameTextData];
        }else{
            self.nameText.text = @"自动获取";
        }
        
        
    }else if (textFiled == self.phoneText){
        if(self.phoneText.text.length == 11){
            [self.view endEditing:YES];
            [self setTUIGuangNewData];
        }else{
            self.extensionText.userInteractionEnabled = YES;
            self.extensionText.text = @"";
            self.nameText.text = @"自动获取";
        }
    }
}

#pragma mark - 推广师电话获取推广师姓名
- (void)getNameTextData
{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",http_PhoneGETName,self.extensionText.text];
    
    [QJGlobalControl sendGETWithUrl:url parameters:nil success:^(id data) {
        if([data[@"code"]integerValue] == 200){
            self.nameText.text = data[@"data"][@"memberName"];
            /*
             memberName 推广师名称
             id         推广师id
             
             
             */
            self.extensionID = data[@"data"][@"id"];
            
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }

    } fail:^(NSError *error) {
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}

#pragma mark - 获取三级联动信息
- (void)getCityAreaListData{
   
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendGETWithUrl:http_CityList parameters:nil success:^(id data) {
         [JHHJView hideLoading];
        if([data[@"code"]integerValue] == 200){
        
            [self.markView removeFromSuperview];
            [self.cityVC removeFromSuperview];
            self.markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            self.markView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5];
            [self.view addSubview:self.markView];
            
            self.cityVC = [[CityPickerView alloc]initWithFrame:CGRectMake(20, SCALE_HEIGHT(150), SCREEN_WIDTH - 40, 220) mainArray:data[@"data"]];
            self.cityVC.backgroundColor = [UIColor whiteColor];
            self.cityVC.layer.masksToBounds = YES;
            self.cityVC.layer.cornerRadius = 10;
            [self.markView addSubview:self.cityVC];
        }else{
        [ALToastView toastInView:self.view withText:data[@"message"]];
    }
     
    } fail:^(NSError *error) {
         [JHHJView hideLoading];
         [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}
#pragma mark - 获取区域列表
- (void)getAreaListData
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];

    NSString *url = [NSString stringWithFormat:@"%@/%@",http_AreaList,self.countyCodeID];
    [QJGlobalControl sendGETWithUrl:url parameters:nil success:^(id data) {
         [JHHJView hideLoading];
        if([data[@"code"]integerValue] == 200){
        
        
            [self.markView removeFromSuperview];
            [self.areaVC removeFromSuperview];
            self.markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            self.markView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5];
            [self.view addSubview:self.markView];
            
            self.areaVC = [[AreaPickerView alloc]initWithFrame:CGRectMake(20, SCALE_HEIGHT(150), SCREEN_WIDTH - 40, 220) mainArray:data[@"data"]];
            self.areaVC.backgroundColor = [UIColor whiteColor];
            self.areaVC.layer.masksToBounds = YES;
            self.areaVC.layer.cornerRadius = 10;
            [self.markView addSubview:self.areaVC];
        }else{
                [ALToastView toastInView:self.view withText:data[@"message"]];
            }
        
    } fail:^(NSError *error) {
         [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
    
}
#pragma mark - 行业类别请求接口
- (void)getClassListData
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];

    [QJGlobalControl sendGETWithUrl:http_ClassDataList parameters:nil success:^(id data) {
         [JHHJView hideLoading];
//        NSLog(@"data = %@",data);
        if([data[@"code"]integerValue] == 200){
            
            [self.markView removeFromSuperview];
            [self.areaVC removeFromSuperview];
            self.markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            self.markView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5];
            [self.view addSubview:self.markView];
            
            self.classListVC = [[ClassView alloc]initWithFrame:CGRectMake(20, SCALE_HEIGHT(150), SCREEN_WIDTH - 40, 270) mainArray:data[@"data"] selectedArray:[NSMutableArray arrayWithArray:self.classArray]];
            self.classListVC.backgroundColor = [UIColor whiteColor];
            self.classListVC.layer.masksToBounds = YES;
            self.classListVC.layer.cornerRadius = 10;
            [self.markView addSubview:self.classListVC];
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}

#pragma mark - 注册
- (void)ReginsterActionData
{
    [self.view endEditing:YES];
   //手机号
    [self.params setValue:self.phoneText.text forKey:@"telPhone"];
    //企业名称
    [self.params setValue:self.companyText.text forKey:@"companyName"];
    //店铺名称
    [self.params setValue:self.shopNameText.text forKey:@"merchantName"];
    //联系人
    [self.params setValue:self.contactsText.text forKey:@"personName"];
    //管理比例费用
    [self.params setValue:self.managerText.text forKey:@"businessProfitRatio"];
    //推广师id Long
    NSNumber *longNumber = [NSNumber numberWithLong:[self.extensionID longLongValue]];
    NSString *longStr = [longNumber stringValue];
    [self.params setValue:longStr forKey:@"promoterId"];
    //门店区域
    //省
    NSNumber *longNumberP = [NSNumber numberWithLong:[self.proviceID longLongValue]];
    NSString *longStrP = [longNumberP stringValue];
    [self.params setValue:longStrP forKey:@"provinceId"];
    //市
    NSNumber *longNumberC = [NSNumber numberWithLong:[self.cityID longLongValue]];
    NSString *longStrC = [longNumberC stringValue];
    [self.params setValue:longStrC forKey:@"cityId"];
    //区
    NSNumber *longNumberCo = [NSNumber numberWithLong:[self.countyCodeID longLongValue]];
    NSString *longStrCo = [longNumberCo stringValue];
    [self.params setValue:longStrCo forKey:@"countyId"];
    //社区 self.townID
    NSNumber *longNumberT = [NSNumber numberWithLong:[self.townID longLongValue]];
    NSString *longStrT = [longNumberT stringValue];
    [self.params setValue:longStrT forKey:@"townId"];
    
    NSNumber *longNumberPo = [NSNumber numberWithLong:[self.positionId longLongValue]];
    NSString *longStrPo = [longNumberPo stringValue];
    [self.params setValue:longStrPo forKey:@"positionId"];
    
    //详细地址
    [self.params setValue:self.addressXText.text forKey:@"address"];
    //门店定位
    //经度
    [self.params setValue:self.longitudeStr forKey:@"longitude"];
    //纬度
    [self.params setValue:self.latitudeStr forKey:@"latitude"];
    
    //行业分类 self.classArray
    for (int i = 0; i < self.classArray.count; i ++) {
        NSDictionary *dic = [self.classArray objectAtIndex:i];
        //获取到行业分类1的dic
        NSDictionary *classDic = dic[@"selectedClass"];
        NSString *classID = [NSString stringWithFormat:@"%@",NULL_TO_NIL(classDic[@"id"])];
        NSNumber *classIDLong = [NSNumber numberWithLong:[classID longLongValue]];
        NSString *classIDStr = [classIDLong stringValue];
        
        NSString *classKey = [NSString stringWithFormat:@"merchantMerchantTypeDTOList[%d].firstMerchantTypeId",i];
        
        [self.params setValue:classIDStr forKey:classKey];
        
        
        //获取到行业分类2的dic
        NSDictionary *childrenDic = dic[@"selectedChildren"];
        NSString *childrenID = [NSString stringWithFormat:@"%@",NULL_TO_NIL(childrenDic[@"id"])];
        NSNumber *childrenIDLong = [NSNumber numberWithLong:[childrenID longLongValue]];
        NSString *childrenIDStr = [childrenIDLong stringValue];
        
        NSString *childrenKey = [NSString stringWithFormat:@"merchantMerchantTypeDTOList[%d].secondMerchantTypeId",i];
        
        [self.params setValue:childrenIDStr forKey:childrenKey];

        
    }
    
    //营业执照 1 营业执照图片 2 身份证图片 3 门店照片 4其他证件 上传多张图片 图片类型
    NSString *bussStr = [NSString stringWithFormat:@"%@",self.businessArray[0]];
    [self.params setValue:bussStr forKey:@"merchantImageDTOList[0].url"];
    [self.params setValue:@1 forKey:@"merchantImageDTOList[0].type"];
    
    //法人身份证
    for (int j = 0; j < self.IDCardArray.count; j ++) {
        
        NSString *idStr = [NSString stringWithFormat:@"%@",[self.IDCardArray objectAtIndex:j]];
        NSString *urlKey = [NSString stringWithFormat:@"merchantImageDTOList[%ld].url",self.businessArray.count + j];
         NSString *typeKey = [NSString stringWithFormat:@"merchantImageDTOList[%ld].type",self.businessArray.count + j];
        [self.params setValue:idStr forKey:urlKey];
        [self.params setValue:@2 forKey:typeKey];
    }
    
    //门店照片
    NSString *shopPhotoStr = [NSString stringWithFormat:@"%@",self.shopPhotoArray[0]];
    NSString *shopurlKey = [NSString stringWithFormat:@"merchantImageDTOList[%ld].url",self.businessArray.count + self.IDCardArray.count];
    NSString *shoptypeKey = [NSString stringWithFormat:@"merchantImageDTOList[%ld].type",self.businessArray.count + self.IDCardArray.count];
    [self.params setValue:shopPhotoStr forKey:shopurlKey];
    [self.params setValue:@3 forKey:shoptypeKey];
    
    if(self.otherArray.count!= 0){
        //其他资料
        for (int x = 0; x < self.otherArray.count; x ++) {
            
            NSString *idStr = [NSString stringWithFormat:@"%@",[self.otherArray objectAtIndex:x]];
            NSString *urlKey = [NSString stringWithFormat:@"merchantImageDTOList[%ld].url",self.businessArray.count + self.IDCardArray.count +self.shopPhotoArray.count + x];
            NSString *typeKey = [NSString stringWithFormat:@"merchantImageDTOList[%ld].type",self.businessArray.count + self.IDCardArray.count +self.shopPhotoArray.count + x];
            [self.params setValue:idStr forKey:urlKey];
            [self.params setValue:@4 forKey:typeKey];
        }
    }
    //验证码
    [self.params setValue:self.codeText.text forKey:@"verificationCode"];
    
//    NSLog(@"🍉🍉🍉 ======%@",self.params);
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendPOSTWithUrl:http_ShopRegisterURL parameters:self.params success:^(id data) {
         [JHHJView hideLoading];
//        NSLog(@"🍊🍊🍊 ========%@",data);
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
#pragma mark - 根据输入的手机号获取是否有推广师
- (void)setTUIGuangNewData
{
    NSString *url = [NSString stringWithFormat:@"%@/%@",http_VipMessage,self.phoneText.text];
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    [QJGlobalControl sendGETWithUrl:url parameters:nil success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"] integerValue] == 200){
            self.extensionText.text = [NSString stringWithFormat:@"%@",data[@"data"][@"telPhone"]];
            self.extensionText.userInteractionEnabled = NO;
            [self getNameTextData];
            
        }else{
            self.extensionText.userInteractionEnabled = YES;
        }
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}
- (NSArray *)businessArray
{
    if(!_businessArray){
        _businessArray = [NSArray array];
    }
    return _businessArray;
}
- (NSArray *)IDCardArray
{
    if(!_IDCardArray){
        _IDCardArray = [NSArray array];
    }
    return _IDCardArray;
}
- (NSArray *)shopPhotoArray
{
    if(!_shopPhotoArray){
        _shopPhotoArray = [NSArray array];
    }
    return _shopPhotoArray;
}
- (NSArray *)otherArray
{
    if(!_otherArray){
        _otherArray = [NSArray array];
    }
    return _otherArray;
}
- (NSMutableDictionary *)params
{
    if(!_params){
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
