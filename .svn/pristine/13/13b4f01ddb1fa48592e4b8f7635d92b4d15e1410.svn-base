//
//  OrderManagerDeatilsController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/26.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "OrderManagerDeatilsController.h"
#import "MessageViewController.h"//评论
@interface OrderManagerDeatilsController ()
@property (nonatomic,strong)UIScrollView *mainScrollView;
@property (nonatomic,strong)UILabel *shopTimeLabel;
@property (nonatomic,strong)UILabel *styleLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)NSMutableArray *mainArray;
@property (nonatomic,strong)UILabel *peopleLabel;
//@property (nonatomic,strong)UILabel *tableLabel;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIButton *haveButton;
@property (nonatomic,strong)UIButton *messageButton;
@property (nonatomic,strong)NSDictionary *mainDic;
@property (nonatomic,strong)UIButton *cancleButton;//取消订单
@end

@implementation OrderManagerDeatilsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"订单详情" isBack:YES];
    self.view.backgroundColor = RGB_COLOR(239, 239, 239);
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarView.bottom)];
    self.mainScrollView.backgroundColor = RGB_COLOR(239, 239, 239);
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.mainScrollView];
    [self GetDetailsData];
}
#pragma mark - 获取数据
- (void)GetDetailsData
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    NSDictionary *params = @{@"orderNo":self.orderNo};
    
    [QJGlobalControl sendGETWithUrl:JQXHttp_AdvanceManagerDetails parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data   ====   %@",data);
        self.mainDic = data[@"data"];
        if([data[@"code"]integerValue] == 200){
            
            [self setMainUI:data[@"data"]];
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
}

- (void)setMainUI:(NSDictionary *)dic{
    
    //电话
    UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH - 20, 50)];
    phoneView.backgroundColor = [UIColor whiteColor];
    phoneView.layer.cornerRadius = 8;
    phoneView.layer.masksToBounds = YES;
    [self.mainScrollView addSubview:phoneView];
    
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, (phoneView.height - 20)/2, 20, 20)];
    NSString *imgStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"memberHeadImage"])];
    [img1 sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"yudingguanli_huiyuan"]];
    [phoneView addSubview:img1];
    
    NSString *phoneStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"memberTelPhone"])];
    
    self.phoneLabel = [JQXCustom creatLabel:CGRectMake(img1.right + 10, 0, 130, phoneView.height) backColor:[UIColor clearColor] text:phoneStr textColor:[UIColor colorWithHexString:@"#888889"] font:Font(12) textAlignment:NSTextAlignmentLeft numOnLines:1];
    [phoneView addSubview:self.phoneLabel];
    
    
    self.styleLabel = [JQXCustom creatLabel:CGRectMake(phoneView.width - 90, 0, 80, phoneView.height) backColor:[UIColor clearColor] text:@"" textColor:[UIColor blackColor] font:Font(12) textAlignment:NSTextAlignmentRight numOnLines:1];
    [phoneView addSubview:self.styleLabel];
    
    //预计到店时间
   
    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(10, phoneView.bottom + 1, SCREEN_WIDTH - 20, 55)];
    timeView.backgroundColor = [UIColor whiteColor];
    timeView.layer.cornerRadius = 8;
    timeView.layer.masksToBounds = YES;
    [self.mainScrollView addSubview:timeView];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(20, (phoneView.height - 20)/2, 20, 20)];
    img.image = [UIImage imageNamed:@"time_img"];
    
    [timeView addSubview:img];
    
    
    UILabel *tsTimeLabel = [JQXCustom creatLabel:CGRectMake(img.right + 10, 0, 130, phoneView.height) backColor:[UIColor clearColor] text:@"预计到店时间" textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentLeft numOnLines:1];
    [timeView addSubview:tsTimeLabel];
    
     NSString *timeStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"hopeServiceDate"])];
    
    self.shopTimeLabel = [JQXCustom creatLabel:CGRectMake(phoneView.width - 140, 0, 130, phoneView.height) backColor:[UIColor clearColor] text:timeStr textColor:[UIColor colorWithHexString:@"#888889"] font:Font(12) textAlignment:NSTextAlignmentRight numOnLines:1];
    [timeView addSubview:self.shopTimeLabel];

    self.mainArray = [NSMutableArray arrayWithArray:dic[@"dlist"]];
    CGFloat menuH = 0;
    if(self.mainArray.count == 0){
        menuH = 0;
    }else{
        menuH = (self.mainArray.count - 1)*7.5 + self.mainArray.count* 80;
    }
    //点的菜品～～～～～～～～～～～～
    UIView *menuView = [[UIView alloc]initWithFrame:CGRectMake(10, timeView.bottom - 5, SCREEN_WIDTH - 20,menuH)];
    menuView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:menuView];
    for (int i = 0; i < self.mainArray.count; i ++) {
        NSDictionary *dict = [self.mainArray objectAtIndex:i];
        UIView *foodView = [[UIView alloc]initWithFrame:CGRectMake(0, i * 80 + i *7.5, menuView.width, 80)];
        foodView.backgroundColor = RGB_COLOR(248, 248, 248);
        [menuView addSubview:foodView];
        
        UIImageView *foodImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];
        NSString *imgStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dict[@"imgAddress"])];
        [foodImg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"JQXShi"]] ;
        [foodView addSubview:foodImg];
        //打折
        CGFloat titleLeft = foodImg.right + 10;
//        if([dic[@"sale"] integerValue] == 1){//打折
//            UILabel *saleLabel = [JQXCustom creatLabel:CGRectMake(foodImg.right + 10, foodImg.top, 15, 15) backColor:RGB_COLOR(194, 133, 225) text:@"折" textColor:[UIColor whiteColor] font:Font(12) textAlignment:NSTextAlignmentCenter numOnLines:1];
//            [foodView addSubview:saleLabel];
//            titleLeft = saleLabel.right + 5;
//        }else{
//            titleLeft = foodImg.right + 10;
//        }
        //菜品名称
        NSString *menuStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dict[@"dishName"])];
        UILabel *titleLabel = [JQXCustom creatLabel:CGRectMake(titleLeft, foodImg.top, 120, 15) backColor:[UIColor clearColor] text:menuStr textColor:[UIColor blackColor] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:1];
        [foodView addSubview:titleLabel];
        
//        //内容
//        UILabel *contentLabel = [JQXCustom creatLabel:CGRectMake(foodImg.right + 10, titleLabel.bottom + 10, 120, 15) backColor:[UIColor clearColor] text:[NSString stringWithFormat:@"%@",dict[@"description"]] textColor:[UIColor colorWithHexString:@"#888889"] font:Font(12) textAlignment:NSTextAlignmentLeft numOnLines:1];
//        [foodView addSubview:contentLabel];
        
        //数量
        NSString *countStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dict[@"dCount"])];
        UILabel *numLabel = [JQXCustom creatLabel:CGRectMake(foodImg.right + 10, foodImg.bottom - 15, 120, 15) backColor:[UIColor clearColor] text:[NSString stringWithFormat:@"×%@",countStr] textColor:[UIColor colorWithHexString:@"#888889"] font:Font(12) textAlignment:NSTextAlignmentLeft numOnLines:1];
        [foodView addSubview:numLabel];
        
        //价格
        CGFloat moneryStr = [[NSString stringWithFormat:@"%@",NULL_TO_NIL(dict[@"money"])] floatValue];
        UILabel *moneryLabel = [JQXCustom creatLabel:CGRectMake(menuView.width - 70, foodImg.top, 60, 15) backColor:[UIColor clearColor] text:[NSString stringWithFormat:@"¥%.2f",moneryStr] textColor:[UIColor blackColor] font:Font(12) textAlignment:NSTextAlignmentRight numOnLines:1];
        [foodView addSubview:moneryLabel];
        
//        //价格
//        CGFloat oldW = [[NSString stringWithFormat:@"¥%@",dic[@"old"]] CallatelabelSizeWidth:Font(9) lineHeight:15];
//        UILabel *oldMoneryLabel = [JQXCustom creatLabel:CGRectMake(menuView.width - oldW - 10, moneryLabel.bottom + 10, oldW, 15) backColor:[UIColor clearColor] text: [NSString stringWithFormat:@"¥%@",dic[@"old"]]textColor:[UIColor colorWithHexString:@"#888889"] font:Font(9) textAlignment:NSTextAlignmentRight numOnLines:1];
//        [foodView addSubview:oldMoneryLabel];
//        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 7.5, oldW, 1)];
//        lineView.backgroundColor = [UIColor colorWithHexString:@"#888889"];
//        [oldMoneryLabel addSubview:lineView];
        
    }
    
    NSArray *contentArray = dic[@"seats"];
    //用餐人数／餐位名称
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(10,menuView.bottom , SCREEN_WIDTH - 20, 60 *(contentArray.count + 1))];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:contentView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentView.width, 1)];
    lineView.backgroundColor = RGB_COLOR(248, 248, 248);
    [contentView addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 60, contentView.width, 1)];
    lineView1.backgroundColor = RGB_COLOR(248, 248, 248);
    [contentView addSubview:lineView1];
    
   
    
    UILabel *peopleTSLabel = [JQXCustom creatLabel:CGRectMake(20, 0, 80, 60) backColor:[UIColor clearColor] text:@"用餐人数" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:1];
    [contentView addSubview:peopleTSLabel];
    
    NSString *num = [NSString stringWithFormat:@"%@人",NULL_TO_NIL(dic[@"num"])];
    self.peopleLabel = [JQXCustom creatLabel:CGRectMake(contentView.width - 110, 0, 100, 60) backColor:[UIColor clearColor] text:num textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentRight numOnLines:1];
    [contentView addSubview:self.peopleLabel];
    
    for (int i = 0; i < contentArray.count; i ++) {
         NSDictionary *dict = [contentArray objectAtIndex:i];
        
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, peopleTSLabel.bottom + i *60, contentView.width, 1)];
        lineView2.backgroundColor = RGB_COLOR(248, 248, 248);
        [contentView addSubview:lineView2];
        
         UILabel *tableTSLabel = [JQXCustom creatLabel:CGRectMake(20, lineView2.bottom, 80, 60) backColor:[UIColor clearColor] text:@"餐位名称" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:1];
        [contentView addSubview:tableTSLabel];
        
         NSString *contentStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dict[@"dishName"])];
        UILabel *tableLabel = [JQXCustom creatLabel:CGRectMake(contentView.width - (contentView.width - 110) - 10, tableTSLabel.top, contentView.width - 110, 60) backColor:[UIColor clearColor] text:contentStr textColor:[UIColor colorWithHexString:@"#888889"] font:Font(12) textAlignment:NSTextAlignmentRight numOnLines:0];

        [contentView addSubview:tableLabel];
    }
    
    //合计
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(10, contentView.bottom - 5, SCREEN_WIDTH - 20, 55)];
    self.bottomView.backgroundColor = RGB_COLOR(248, 248, 248);
    self.bottomView.layer.cornerRadius = 8;
    self.bottomView.layer.masksToBounds = YES;
    [self.mainScrollView addSubview:self.bottomView];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bottomView.width, 5)];
    lineView2.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:lineView2];
    
    UILabel *allPriceLabel = [JQXCustom creatLabel:CGRectMake(10, 5, self.bottomView.width - 20, 50) backColor:[UIColor clearColor] text:@"" textColor:BACKGROUNGCOLOR font:Font(15) textAlignment:NSTextAlignmentLeft numOnLines:1];
    
     CGFloat allMoneyStr = [[NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"subscriptionMoney"])] floatValue];
     NSString *moneryStr = [NSString stringWithFormat:@"合计：¥%.2f",allMoneyStr];
    
     allPriceLabel.attributedText = [self String:moneryStr RangeString:@"合计：" style:@"合计"];
    [self.bottomView addSubview:allPriceLabel];
    
    //接单按钮
    self.haveButton = [JQXCustom creatButton:CGRectMake(self.bottomView.width - SCALE_WIDTH(100), 15, SCALE_WIDTH(90), 30) backColor:BACKGROUNGCOLOR text:@"接单" textColor:[UIColor whiteColor] font:Font(13) addTarget:self Action:@selector(HaveAction)];
    self.haveButton.layer.cornerRadius = 8;
    self.haveButton.layer.masksToBounds = YES;
    self.haveButton.hidden = YES;
    [self.bottomView addSubview:self.haveButton];
    
    //取消接单按钮
    self.cancleButton = [JQXCustom creatButton:CGRectMake(self.haveButton.left - SCALE_WIDTH(100), 15, SCALE_WIDTH(90), 30) backColor:[UIColor whiteColor] text:@"取消订单" textColor:[UIColor blackColor] font:Font(13) addTarget:self Action:@selector(CancleAction)];
    self.cancleButton.layer.cornerRadius = 8;
    self.cancleButton.layer.masksToBounds = YES;
    self.cancleButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.cancleButton.layer.borderWidth = 1;
    self.cancleButton.hidden = YES;
    [self.bottomView addSubview:self.cancleButton];
    
    
    //评价订单信息按钮
    self.messageButton = [JQXCustom creatButton:CGRectMake(self.bottomView.width - 110, 15, 100, 30) backColor:BACKGROUNGCOLOR text:@"查看评价信息" textColor:[UIColor whiteColor] font:Font(13) addTarget:self Action:@selector(MessageAction)];
    self.messageButton.layer.cornerRadius = 8;
    self.messageButton.layer.masksToBounds = YES;
    [self.bottomView addSubview:self.messageButton];
    
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.bottomView.bottom + 50);
    
    if([dic[@"status"] intValue] == 1){
        
        self.styleLabel.text = @"待确认";
        self.haveButton.hidden = NO;
        self.cancleButton.hidden = NO;
        self.messageButton.hidden = YES;
        
    }else if ([dic[@"status"] intValue] == 2){
        
        self.styleLabel.text = @"已确认";
        self.haveButton.hidden = YES;
        self.cancleButton.hidden = YES;
        self.messageButton.hidden = YES;
        
    }else if ([dic[@"status"] intValue] == 3){
        
        self.styleLabel.text = @"已评价";
        self.haveButton.hidden = YES;
        self.cancleButton.hidden = YES;
        self.messageButton.hidden = NO;
    }else if ([dic[@"status"] intValue] == 7){
        
        self.styleLabel.text = @"交易取消";
        self.haveButton.hidden = YES;
        self.cancleButton.hidden = YES;
        self.messageButton.hidden = YES;
        
    }

 
    
}
#pragma mark - 接单按钮
- (void)HaveAction
{
    self.haveButton.userInteractionEnabled = NO;
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSDictionary *params = @{@"orderNo":self.orderNo};
    
    [QJGlobalControl sendGETWithUrl:JQXHttp_AdvanceAgreeOrder parameters:params success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"]integerValue] == 200){
            NSLog(@"data   ====     %@",data);
            self.haveButton.hidden = YES;
            self.cancleButton.hidden = YES;
            self.styleLabel.text = @"已确认";
             [[NSNotificationCenter defaultCenter] postNotificationName:@"JQXOrderSuccess" object:nil userInfo:@{@"orderNo":self.orderNo}];
            [ALToastView toastInView:self.view withText:@"接单成功"];
            
            dispatch_time_t delayTime = dispatch_time
            (DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
            
            dispatch_after
            (delayTime, dispatch_get_main_queue(),
             ^{
                 [self.navigationController popViewControllerAnimated:YES];

             }
             );
            
            
        }else{
            self.haveButton.userInteractionEnabled = YES;
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        self.haveButton.userInteractionEnabled = YES;
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];

}
#pragma mark - 取消接单按钮
- (void)CancleAction
{
    NSString *orderID = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.mainDic[@"id"])];
    [self getCancleOrderId:orderID];
}

#pragma mark - 商户取消接单数据请求
- (void)getCancleOrderId:(NSString *)orderId
{
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSDictionary *params = @{@"orderId":orderId};
    
    [QJGlobalControl sendGETWithUrl:JQXHttp_AdvanceDisAgreeOrder parameters:params success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"]integerValue] == 200){
            NSLog(@"data   ====     %@",data);
            [ALToastView toastInView:self.view withText:@"取消订单成功"];
            self.haveButton.hidden = YES;
            self.cancleButton.hidden = YES;
            //            BOOL isbool = [self.mainArray containsObject: self.orderDic];
            //            NSLog(@"%i",isbool);// i＝1；数组包含某个元素,i＝0；数组不包含某个元素
            //
            //            if(isbool == 1){
            //                [self.mainArray removeObject:self.orderDic];
            //                [self.mainTableView reloadData];
            //            }
            
        }else{
            
            [ALToastView toastInView:self.view withText:data[@"message"]];
            
        }
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}

#pragma mark - 查看评价信息
- (void)MessageAction
{
    MessageViewController *vc = [[MessageViewController alloc]init];
    vc.orderID = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.mainDic[@"id"])];
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSMutableAttributedString *)String:(NSString *)String RangeString:(NSString *)RangeString style:(NSString *)styleStr
{
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:String];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:RangeString];
    if([styleStr isEqualToString:@"餐位名称"]){
        [hintString addAttribute:NSForegroundColorAttributeName value: [UIColor blackColor] range:range1];
        [hintString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range1];
    }else{
        [hintString addAttribute:NSForegroundColorAttributeName value: [UIColor blackColor] range:range1];
    }
   
    
    
    return hintString;
}
- (NSMutableArray *)mainArray
{
    if(!_mainArray){
        _mainArray = [NSMutableArray array];
    }
    return _mainArray;
}
- (NSDictionary *)mainDic
{
    if(!_mainDic){
        _mainDic = [NSDictionary dictionary];
    }
    return _mainDic;
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
