//
//  RegisterPhotoViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/22.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "RegisterPhotoViewController.h"
#import "ChoosePhoController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "ClassView.h"
#import "RegisterMoneryViewController.h"//人均消费金额
@interface RegisterPhotoViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *mainScrollView;
@property (nonatomic,strong)ClassView *classListVC;
@property (nonatomic,strong)UIView *markView;//遮罩试图
@property (nonatomic,strong)UITextField *moneryText;//人均消费
@property (nonatomic,strong)UITextField *openTimeText;//营业时间
@property (nonatomic,strong)UITextField *closeText;//非营业时间
@property (nonatomic,strong)UITextField *companyText;//企业名称
@property (nonatomic,strong)UITextField *shopNameText;//门店名称
@property (nonatomic,strong)UITextField *contactsText;//联系人
@property (nonatomic,strong)UITextField *classLabel;//行业分类
@property (nonatomic,strong)UIButton *classButton;//行业分类按钮
@property (nonatomic,strong)UIImageView *classImg;//行业分类箭头
@property (nonatomic,strong)NSArray *businessArray;//营业执照图片数组
@property (nonatomic,strong)NSArray *IDCardArray;//法人身份证数组
@property (nonatomic,strong)NSArray *shopPhotoArray;//门店照片数组
@property (nonatomic,strong)NSArray *otherArray;//其他照片数组
@property (nonatomic,strong)NSArray *classArray;//行业分类



@end

@implementation RegisterPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"申请商户" isBack:YES];
    self.mainScrollView = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, TOPALLHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NAVHeight - STATUSBAHeight)];
//    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.mainScrollView];
    
    //上传图片
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UPImageActon:) name:@"UpImage" object:nil];
    
    //正在上传图片
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UPImageLoadingActon:) name:@"UpImageLoading" object:nil];
    
    //行业分类确定按钮点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ClassSureActon:) name:@"ClassPickerViewSure" object:nil];
    //行业分类取消按钮点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CancleActon:) name:@"PickerViewCancle" object:nil];
    
    [self setMainUI];
}
#pragma mark - 门店区域取消按钮点击通知
- (void)CancleActon:(NSNotification *)notif
{
    [self.markView removeFromSuperview];
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
        
    }else{
        self.classLabel.text = @"";
    }
    
    
    
}

- (void)setMainUI
{
    
    CGFloat xingH = 20;
    
    //前面小星星
    
    for (int i = 0; i < 8; i ++) {
        UILabel *xingLabel = [JQXCustom creatLabel:CGRectMake(0,xingH, 20, 45) backColor:[UIColor clearColor] text:@"*" textColor:BACKGROUNGCOLOR font:Font(13) textAlignment:NSTextAlignmentCenter numOnLines:1];
        if(i < 4){
            xingH = xingH + 45 + 10;
            
        }else if(i >= 4 && i < 6){
            
            xingH = xingH + 150 +10;
            
        }else {
            
            xingH = xingH + 270 + 5;
            
        }
        
        [self.mainScrollView addSubview:xingLabel];
        
        
    }
    
    
    //企业名称
    RegisterView *companyView = [[RegisterView alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH - 40, 45)];
    companyView.tsLabel.text = @"企业名称";
    [self.mainScrollView addSubview:companyView];
    
    self.companyText = [JQXCustom creatTextFiled:CGRectMake(90, 0, companyView.width - 90 - 10, companyView.height) placeholder:@"请点击输入您的企业名称(必填)"];
    self.companyText.textAlignment = NSTextAlignmentLeft;
    self.companyText.delegate = self;
     [self.companyText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [companyView addSubview:self.companyText];
    
    //门店名称
    RegisterView *shopNameView = [[RegisterView alloc]initWithFrame:CGRectMake(20, companyView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    shopNameView.tsLabel.text = @"门店名称";
    [self.mainScrollView addSubview:shopNameView];
    
    self.shopNameText = [JQXCustom creatTextFiled:CGRectMake(90, 0, shopNameView.width - 90 - 10, shopNameView.height) placeholder:@"请点击输入您的门店名称"];
    self.shopNameText.textAlignment = NSTextAlignmentLeft;
    self.shopNameText.delegate = self;
    [self.shopNameText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [shopNameView addSubview:self.shopNameText];
    
    //联系人
    RegisterView *contactsView = [[RegisterView alloc]initWithFrame:CGRectMake(20, shopNameView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    contactsView.tsLabel.text = @"联系人";
    [self.mainScrollView addSubview:contactsView];
    
    self.contactsText = [JQXCustom creatTextFiled:CGRectMake(90, 0, contactsView.width - 90 - 10, contactsView.height) placeholder:@"请输入联系电话"];
    self.contactsText.textAlignment = NSTextAlignmentLeft;
    self.contactsText.keyboardType = UIKeyboardTypeNumberPad;
    self.contactsText.delegate = self;
    [self.contactsText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [contactsView addSubview:self.contactsText];

    
    //行业分类
    RegisterView *classView = [[RegisterView alloc]initWithFrame:CGRectMake(20, contactsView.bottom + 10, SCREEN_WIDTH - 40, 45)];
    classView.tsLabel.text = @"行业分类";
    [self.mainScrollView addSubview:classView];
    
    self.classImg = [[UIImageView alloc]initWithFrame:CGRectMake(contactsView.width - 20, (classView.height - 13)/2, 7, 13)];
    self.classImg.image = [UIImage imageNamed:@"me_goon"];
    [classView addSubview:self.classImg];
    
    self.classLabel = [JQXCustom creatTextFiled:CGRectMake(100, 0, classView.width - 90 - 33, classView.height) placeholder:@"请选择行业分类"];
    self.classLabel.userInteractionEnabled = NO;
    [classView addSubview:self.classLabel];
    
    self.classButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, classView.width, classView.height)];
    self.classButton.tag = 1;
    [self.classButton addTarget:self action:@selector(classAction:) forControlEvents:UIControlEventTouchUpInside];
    [classView addSubview:self.classButton];

    
    
    //营业执照
    UIView *businessView = [[UIView alloc]initWithFrame:CGRectMake(20, classView.bottom + 10, SCREEN_WIDTH - 40, SCALE_HEIGHT(150))];
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
    UIView *IDCardView = [[UIView alloc]initWithFrame:CGRectMake(20, businessView.bottom + 10, SCREEN_WIDTH - 40, SCALE_HEIGHT(150))];
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
    UIView *shopPhotoView = [[UIView alloc]initWithFrame:CGRectMake(20, IDCardView.bottom + 10, SCREEN_WIDTH - 40, SCALE_HEIGHT(270))];
    shopPhotoView.layer.borderWidth = 1.5;
    shopPhotoView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.mainScrollView addSubview:shopPhotoView];
    
    UILabel *shopPhotoLabel = [JQXCustom creatLabel:CGRectMake(10, 0, businessView.width, 30) backColor:[UIColor clearColor] text:@"门店照片" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
    shopPhotoLabel.attributedText = [self String:@"门店照片 最多可上传5张" RangeString:@"最多可上传5张" styleStr:@"字体"];
    [shopPhotoView addSubview:shopPhotoLabel];
    
    
    ChoosePhoController *shopPhotoVC = [[ChoosePhoController alloc] init];
    
    shopPhotoVC.view.frame = CGRectMake(10, shopPhotoLabel.bottom + 5, shopPhotoView.width - 20, shopPhotoView.height - 35);
    
    [shopPhotoVC sendStrFunc:CGSizeMake(shopPhotoVC.view.frame.size.width, shopPhotoVC.view.frame.size.height) maxNumber:5 showNumber:3];
    
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
    UIView *otherView = [[UIView alloc]initWithFrame:CGRectMake(20, shopPhotoView.bottom + 10, SCREEN_WIDTH - 40, SCALE_HEIGHT(270))];
    otherView.layer.borderWidth = 1.5;
    otherView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.mainScrollView addSubview:otherView];
    
    UILabel *otherLabel = [JQXCustom creatLabel:CGRectMake(10, 0, businessView.width, 30) backColor:[UIColor clearColor] text:@"行业许可证" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
    otherLabel.attributedText = [self String:@"行业许可证 最多可上传5张" RangeString:@"最多可上传5张" styleStr:@"字体"];
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
    
    UIButton *sumbitButton = [JQXCustom creatButton:CGRectMake(60, otherView.bottom + 50 , SCREEN_WIDTH - 120, 40) backColor:BACKGROUNGCOLOR text:@"下一步" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14] addTarget:self Action:@selector(sumbitAction)];
    sumbitButton.layer.masksToBounds = YES;
    sumbitButton.layer.cornerRadius = 5;
    
    [self.mainScrollView addSubview:sumbitButton];
    
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, sumbitButton.bottom + 30);
}
#pragma mark - 下一步
- (void)sumbitAction
{
    [self.view endEditing:YES];
    if(self.businessArray.count == 0 ||self.IDCardArray.count == 0 ||self.shopPhotoArray.count == 0 ||self.otherArray.count == 0|| self.classArray.count == 0|| self.companyText.text.length == 0 ||self.shopNameText.text.length == 0 || self.contactsText.text.length == 0){

        [ALToastView toastInView:self.view withText:@"信息不全，请补充"];

    }else if([[self.companyText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0 || [[self.shopNameText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0 || [[self.contactsText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
        
        [ALToastView toastInView:self.view withText:@"请输入正确信息"];
        
    }else{
        
        if(self.contactsText.text.length != 11){

             [ALToastView toastInView:self.view withText:@"请输入正确手机号"];

        }else{
            

            if(self.IDCardArray.count != 2){

                [ALToastView toastInView:self.view withText:@"法人身份证必须上传2张"];

            }else{
    
                //企业名称
                
                BOOL special = [QJGlobalControl isIncludeSpecialCharact:self.companyText.text];
                if(special){
                    [ALToastView toastInView:self.view withText:@"不可以输入特殊字符"];
                }else{
                    [self.registerDic setValue:self.companyText.text forKey:@"companyName"];
                
                }
                //店铺名称
                BOOL special1 = [QJGlobalControl isIncludeSpecialCharact:self.shopNameText.text];
                if(special1){
                    [ALToastView toastInView:self.view withText:@"不可以输入特殊字符"];
                }else{
                    [self.registerDic setValue:self.shopNameText.text forKey:@"merchantName"];
                }

                //联系人
                [self.registerDic setValue:self.contactsText.text forKey:@"personName"];
                //管理比例
                [self.registerDic setValue:@"0.15" forKey:@"businessProfitRatio"];
                //推广师id
                [self.registerDic setValue:@"123456" forKey:@"promoterId"];
                
                //行业分类 self.classArray
                for (int i = 0; i < self.classArray.count; i ++) {
                    NSDictionary *dic = [self.classArray objectAtIndex:i];
                    //获取到行业分类1的dic
                    NSDictionary *classDic = dic[@"selectedClass"];
                    NSString *classID = [NSString stringWithFormat:@"%@",NULL_TO_NIL(classDic[@"id"])];
                    NSNumber *classIDLong = [NSNumber numberWithLong:[classID longLongValue]];
                    NSString *classIDStr = [classIDLong stringValue];
                    
                    NSString *classKey = [NSString stringWithFormat:@"merchantMerchantTypeDTOList[%d].firstMerchantTypeId",i];
                    
                    [self.registerDic setValue:classIDStr forKey:classKey];
                    
                    
                    //获取到行业分类2的dic
                    NSDictionary *childrenDic = dic[@"selectedChildren"];
                    NSString *childrenID = [NSString stringWithFormat:@"%@",NULL_TO_NIL(childrenDic[@"id"])];
                    NSNumber *childrenIDLong = [NSNumber numberWithLong:[childrenID longLongValue]];
                    NSString *childrenIDStr = [childrenIDLong stringValue];
                    
                    NSString *childrenKey = [NSString stringWithFormat:@"merchantMerchantTypeDTOList[%d].secondMerchantTypeId",i];
                    
                    [self.registerDic setValue:childrenIDStr forKey:childrenKey];
                    
                    
                }
                
                
                
                //营业执照 1 营业执照图片 2 身份证图片 3 门店照片 4行业许可证 上传多张图片 图片类型
                NSString *bussStr = [NSString stringWithFormat:@"%@",self.businessArray[0]];
                [self.registerDic setValue:bussStr forKey:@"merchantImageDTOList[0].url"];
                [self.registerDic setValue:@1 forKey:@"merchantImageDTOList[0].type"];
                
                //法人身份证
                for (int j = 0; j < self.IDCardArray.count; j ++) {
                    
                    NSString *idStr = [NSString stringWithFormat:@"%@",[self.IDCardArray objectAtIndex:j]];
                    NSString *urlKey = [NSString stringWithFormat:@"merchantImageDTOList[%ld].url",self.businessArray.count + j];
                    NSString *typeKey = [NSString stringWithFormat:@"merchantImageDTOList[%ld].type",self.businessArray.count + j];
                    [self.registerDic setValue:idStr forKey:urlKey];
                    [self.registerDic setValue:@2 forKey:typeKey];
                }
                
                //门店照片
                //        NSString *shopPhotoStr = [NSString stringWithFormat:@"%@",self.shopPhotoArray[0]];
                //        NSString *shopurlKey = [NSString stringWithFormat:@"merchantImageDTOList[%ld].url",self.businessArray.count + self.IDCardArray.count];
                //        NSString *shoptypeKey = [NSString stringWithFormat:@"merchantImageDTOList[%ld].type",self.businessArray.count + self.IDCardArray.count];
                //        [self.registerDic setValue:shopPhotoStr forKey:shopurlKey];
                //        [self.registerDic setValue:@3 forKey:shoptypeKey];
                
                if(self.shopPhotoArray.count != 0){
                    for (int y = 0; y < self.shopPhotoArray.count; y ++) {
                        NSString *idStr = [NSString stringWithFormat:@"%@",[self.shopPhotoArray objectAtIndex:y]];
                        NSString *urlKey = [NSString stringWithFormat:@"merchantImageDTOList[%ld].url",self.businessArray.count + self.IDCardArray.count + y];
                        NSString *typeKey = [NSString stringWithFormat:@"merchantImageDTOList[%ld].type",self.businessArray.count + self.IDCardArray.count + y];
                        [self.registerDic setValue:idStr forKey:urlKey];
                        [self.registerDic setValue:@3 forKey:typeKey];
                    }
                }
                
                
                if(self.otherArray.count!= 0){
                    //其他资料
                    for (int x = 0; x < self.otherArray.count; x ++) {
                        
                        NSString *idStr = [NSString stringWithFormat:@"%@",[self.otherArray objectAtIndex:x]];
                        NSString *urlKey = [NSString stringWithFormat:@"merchantImageDTOList[%ld].url",self.businessArray.count + self.IDCardArray.count +self.shopPhotoArray.count + x];
                        NSString *typeKey = [NSString stringWithFormat:@"merchantImageDTOList[%ld].type",self.businessArray.count + self.IDCardArray.count +self.shopPhotoArray.count + x];
                        [self.registerDic setValue:idStr forKey:urlKey];
                        [self.registerDic setValue:@4 forKey:typeKey];
                    }
                }
                
                
                [self ReginsterActionData];
                
                
            }

        }

    }
}

#pragma mark - 行业分类
- (void)classAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    //获取行业分类列表
    [self getClassListData];
}

#pragma mark - 行业类别请求接口
- (void)getClassListData
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    [QJGlobalControl sendGETWithUrl:http_ClassDataList parameters:nil success:^(id data) {
        [JHHJView hideLoading];
        //        NSLog(@"data = %@",data);
        if([data[@"code"]integerValue] == 200){
            
            NSArray *array = data[@"data"];
            if(array.count != 0){
                [self.markView removeFromSuperview];
                self.markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                self.markView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5];
                [self.view addSubview:self.markView];
                
                self.classListVC = [[ClassView alloc]initWithFrame:CGRectMake(20, SCALE_HEIGHT(150), SCREEN_WIDTH - 40, 270) mainArray:data[@"data"] selectedArray:[NSMutableArray arrayWithArray:self.classArray]];
                self.classListVC.backgroundColor = [UIColor whiteColor];
                self.classListVC.layer.masksToBounds = YES;
                self.classListVC.layer.cornerRadius = 10;
                [self.markView addSubview:self.classListVC];
            }else{
                [ALToastView toastInView:self.view withText:@"暂无数据"];
            }
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}



- (void)ReginsterActionData
{
    RegisterMoneryViewController *vc = [[RegisterMoneryViewController alloc]init];
    vc.registerDic = self.registerDic;
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
- (NSMutableDictionary *)registerDic
{
    if(!_registerDic){
        _registerDic = [NSMutableDictionary dictionary];
    }
    return _registerDic;
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
