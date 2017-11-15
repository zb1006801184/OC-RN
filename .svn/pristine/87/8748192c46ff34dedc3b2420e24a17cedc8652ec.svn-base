//
//  MineMoneryViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "MineMoneryViewController.h"
#import "OrderRecModel.h"
#import "ReserveView.h"
#import "PayRechargeViewController.h"
#import "PaySumbitViewController.h"
@interface MineMoneryViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSInteger  page_no_index;
    
    BOOL HearderOrFoot;
}
@property(nonatomic,strong)UITableView *tabView;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)NSString *moneyStr;
@property(nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)UIView *headerView;

@end

@implementation MineMoneryViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    page_no_index = 1;
    [self creatOneClassShopindex:page_no_index];
    [self creatMainView];
}
- (void)viewDidLoad {
    
    [self setNavBarWithTitle:@"我的账户" isBack:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.data = [[NSMutableArray alloc]init];
    
    [super viewDidLoad];
    
    page_no_index = 1;
    [self creatOneClassShopindex:page_no_index];
    
    [self creatMainView];
    
}

-(void)creatMainView{
    
    [self.headerView removeFromSuperview];
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, TOPALLHeight, SCREEN_WIDTH, 120)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headerView];
    CGFloat yPos = 20;
    
    UILabel *balanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, SCREEN_WIDTH, 30)];
    
    balanceLabel.text = @"余额";
    
    balanceLabel . textColor = [UIColor lightGrayColor];
    
    balanceLabel . textAlignment = NSTextAlignmentCenter;
    
    balanceLabel . font = [UIFont systemFontOfSize:14];
    
    [self.headerView addSubview:balanceLabel];
    
    
    yPos += 30;
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, SCREEN_WIDTH, 30)];
    
    moneyLabel.text = @"0.0元";
    
    moneyLabel . textColor = [UIColor blackColor];
    
    moneyLabel . font = [UIFont boldSystemFontOfSize:26];
    
    moneyLabel . textAlignment = NSTextAlignmentCenter;
    
    [self.headerView addSubview:moneyLabel];
    
    self.moneyLabel = moneyLabel;
    
    yPos += 40;
    UIButton *rechargeBtn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 150)/2, yPos, 60, 25)];
    rechargeBtn.backgroundColor = BACKGROUNGCOLOR;
    rechargeBtn.layer.masksToBounds = YES;
    rechargeBtn.layer.cornerRadius = 5;
    [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
    [rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rechargeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rechargeBtn addTarget:self action:@selector(rechargeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:rechargeBtn];
    
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(rechargeBtn.right + 30, yPos, 60, 25)];
    submitBtn.backgroundColor = BACKGROUNGCOLOR;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5;
    [submitBtn setTitle:@"提现" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.headerView addSubview:submitBtn];
    
    yPos += 45;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, yPos, SCREEN_WIDTH, 1)];
    
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.headerView addSubview:lineView];
    
    
    yPos += 10;
    
    UILabel *reserveLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, yPos, SCREEN_WIDTH - 30, 30)];
    
    reserveLabel.text = @"余额变动记录";
    
    reserveLabel . textColor = [UIColor lightGrayColor];
    
    reserveLabel . font = [UIFont systemFontOfSize:15];
    
    reserveLabel . textAlignment = NSTextAlignmentLeft;
    
    [self.headerView addSubview:reserveLabel];
    
    yPos += 35;
    
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, yPos, SCREEN_WIDTH, 1)];
    
    lineView2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.headerView addSubview:lineView2];
    
    yPos += 1;
    
    
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, yPos, SCREEN_WIDTH, 40)];
    topview.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:topview];
    
    
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,SCREENSIZE.width/3, 40)];
    timeLabel.text = @"时间";
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.numberOfLines = 1;
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [topview addSubview:timeLabel];
    
    UILabel *moneyLabels = [[UILabel alloc]initWithFrame:CGRectMake(SCREENSIZE.width/3, 0, SCREENSIZE.width/3, 40)];
    moneyLabels.text =@"消费额度";
    moneyLabels.numberOfLines = 1;
    moneyLabels.textColor = [UIColor blackColor];
    moneyLabels.textAlignment = NSTextAlignmentCenter;
    moneyLabels.font = [UIFont systemFontOfSize:14];
    [topview addSubview:moneyLabels];
    
    
    UILabel *payStyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENSIZE.width/3 *2, 0, SCREENSIZE.width/3, 40)];
    payStyLabel.text = @"支付类别";
    payStyLabel.textColor = [UIColor blackColor];
    payStyLabel.font = [UIFont systemFontOfSize:14];
    payStyLabel.numberOfLines = 1;
    payStyLabel.textAlignment = NSTextAlignmentCenter;
    [topview addSubview:payStyLabel];
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0,39 , SCREEN_WIDTH, 1)];
    lineView3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [topview addSubview:lineView3];
    
    yPos += 40;
    
    [self.headerView setHeight:yPos];
    
    self.tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, yPos + TOPALLHeight, SCREEN_WIDTH,SCREEN_HEIGHT - yPos - NAVHeight - STATUSBAHeight)];
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    UIView *tabV = [[UIView alloc]init];
    self.tabView.tableFooterView = tabV;
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tabView];
    
    
    [self setupRefresh];
    
    
}

//下拉刷新
- (void)setupRefresh
{
    
    self.tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(header)];
    self.tabView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footer)];
    
}

-(void)header{
    
    page_no_index = 1;
    
    HearderOrFoot = YES;
    
    [self creatOneClassShopindex:page_no_index];
    
    [self.tabView reloadData];
    
}

-(void)footer{
    
    
    page_no_index +=1;
    
    HearderOrFoot = NO;
    
    [self creatOneClassShopindex:page_no_index];
    
}
-(void)creatOneClassShopindex:(NSInteger )index{
    
    
    NSString *url = httpYUOrderListByMerchantPhone;
    NSDictionary *params = @{@"pageNum":[NSString stringWithFormat:@"%ld",(long)index],@"pageSize":@10};
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendPOSTWithUrl:url parameters:params success:^(id data) {
        [JHHJView hideLoading];
//        NSLog(@"🍉：%@",data);
        NSString *result=[NSString stringWithFormat:@"%@",data[@"code"]];
        
        if ([result isEqual:@"200"]) {
            NSDictionary *dic =data[@"data"][@"dataMap"];
            
            
            if(page_no_index == 1){
                if(self.data.count != 0){
                    [self.data removeAllObjects];
                }
            }
            
            for (NSDictionary *dicc in dic) {
                OrderRecModel *model = [[OrderRecModel alloc]init];
                //                model.memberPhone = NULL_TO_NIL(dicc[@"memberPhone"]);
                model.payDate = NULL_TO_NIL(dicc[@"createTime"]);
                model.payType = NULL_TO_NIL(dicc[@"source"]);
                model.totalPrice = NULL_TO_NIL(dicc[@"money"]);
                [self.data addObject:model];
            }
            
            self.moneyStr = [NSString stringWithFormat:@"%@",data[@"data"][@"userBalance"]];
            
            if([self.moneyStr floatValue] == 0){
                self.moneyStr = @"0.0";
            }
            
            self.moneyLabel.text = [NSString stringWithFormat:@"%@元",self.moneyStr];
            
            [self.tabView reloadData];
            
            NSArray *array = data[@"data"][@"dataMap"];
            if(array.count == 0){
                [ALToastView toastInView:self.view withText:@"没有更多数据"];
            }
            
        }else{
            
            NSString *msg = data[@"message"];
            
            [ALToastView toastInView:self.view withText:msg];
            
        }
        
        [self.tabView.mj_header endRefreshing];
        [self.tabView.mj_footer endRefreshing];
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [self.tabView.mj_header endRefreshing];
        [self.tabView.mj_footer endRefreshing];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.data.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reserveCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OrderRecModel *model = self.data[indexPath.row];
    ReserveView *resView = [[ReserveView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    NSString *payTypeStr =[NSString stringWithFormat:@"%@",model.payType];
    
    resView.moneyLabel.text =  [NSString stringWithFormat:@"%@元",model.totalPrice];
    if([payTypeStr isEqualToString:@"余额提现"]){
        payTypeStr = [NSString stringWithFormat:@"%@-手续费2元",payTypeStr];
    }
    resView.payStyLabel.text = payTypeStr;
    
    resView.timeLabel.text = [NSString stringWithFormat:@"%@",model.payDate];
    resView.phoneLabel.text =   [NSString stringWithFormat:@"%@",model.memberPhone];
    [cell addSubview:resView];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}
#pragma mark - 充值点击事件
- (void)rechargeAction
{
    PayRechargeViewController *payVC = [[PayRechargeViewController alloc]init];
    [self.navigationController pushViewController:payVC animated:YES];
    
}
#pragma mark - 提现点击事件
- (void)submitAction
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendGETWithUrl:httpYESorNOBank parameters:nil success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data === %@",data);
        if([data[@"code"]integerValue] == 200){
            
            [self isBankDetails];
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
}

- (void)isBankDetails
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendGETWithUrl:httpBankListURL parameters:nil success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"🍉：%@",data);
        if([data[@"code"]integerValue] == 200){
            
            PaySumbitViewController *sumbitVC = [[PaySumbitViewController alloc]init];
            sumbitVC.moneryStr = self.moneyStr;
            [self.navigationController pushViewController:sumbitVC animated:YES];
            

        }else if ([data[@"code"]integerValue] == 60033){
            //暂无银行卡信息
            [ALToastView toastInView:self.view withText:@"请先绑定银行卡"];
            
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    

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
