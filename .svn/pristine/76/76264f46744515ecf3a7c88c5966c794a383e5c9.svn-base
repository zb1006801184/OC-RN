//
//  OrderViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderCell.h"
#import "OrderRecModel.h"

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSInteger  page_no_index;
    
    BOOL HearderOrFoot;
}
@property(nonatomic,strong)UITableView *tabView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"订单记录" isBack:YES];
    self.view.backgroundColor = BACKGrayColor;
    
    self.dataArray = [[NSMutableArray alloc]init];
    
    [self creatTopView];
    page_no_index = 1;
    [self creatOneClassShopindex:page_no_index];
    
    [self creatOrderList];

}
-(void)creatTopView{
    
    UIView *topview = [[UIView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, 40)];
    topview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topview];
    
    //    CGFloat wPos;
    //    wPos = self.view.frame.size.width / 4;
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,SCREENSIZE.width/3, 40)];
    timeLabel.text = @"时间";
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.numberOfLines = 1;
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [topview addSubview:timeLabel];
    
    
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENSIZE.width/3 , 0, SCREENSIZE.width/3, 40)];
    moneyLabel.text =@"账号/消费额度";
    moneyLabel.numberOfLines = 1;
    moneyLabel.textColor = [UIColor blackColor];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.font = [UIFont systemFontOfSize:14];
    [topview addSubview:moneyLabel];
    
    
    UILabel *payStyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENSIZE.width/3 * 2, 0, SCREENSIZE.width/3, 40)];
    payStyLabel.text = @"支付类型";
    payStyLabel.textColor = [UIColor blackColor];
    payStyLabel.font = [UIFont systemFontOfSize:14];
    payStyLabel.numberOfLines = 1;
    payStyLabel.textAlignment = NSTextAlignmentCenter;
    [topview addSubview:payStyLabel];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
    lineview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [topview addSubview:lineview];
}



-(void)creatOrderList{
    
    
    self.tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom+40, SCREEN_WIDTH,SCREEN_HEIGHT - self.navBarView.bottom - 40 )];
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tabView.tableHeaderView = headView;
    UIView *tabV = [[UIView alloc]init];
    self.tabView.tableFooterView = tabV;
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tabView];
    [self setupRefresh];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

//下拉刷新
- (void)setupRefresh
{
    
    self.tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(header)];
    
    self.tabView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footer)];
    
}

-(void)header{
    
    page_no_index = 1;
    
//    HearderOrFoot = YES;
    
    [self creatOneClassShopindex:page_no_index];
    
}

-(void)footer{
    
    
    page_no_index +=1;
    
//    HearderOrFoot = NO;
    
    [self creatOneClassShopindex:page_no_index];
    
}

-(void)creatOneClassShopindex:(NSInteger )index{
    
    
    NSString *url = httpOrderListByMerchantPhone;
    NSDictionary *params = @{@"pageNum":[NSString stringWithFormat:@"%ld",index],@"pageSize":@"10"};
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendPOSTWithUrl:url parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSString *result=[NSString stringWithFormat:@"%@",data[@"code"]];
//        NSLog(@"%@",data);
        if ([result isEqual:@"200"]) {
            
            NSDictionary *dic =data[@"data"];
            if(page_no_index == 1){
                if(self.dataArray.count != 0){
                    [self.dataArray removeAllObjects];
                }
            }
            
            for (NSDictionary *dicc in dic) {
                OrderRecModel *model = [[OrderRecModel alloc]init];
                model.memberPhone = NULL_TO_NIL(dicc[@"memberTelPhone"]);
                model.payDate = NULL_TO_NIL(dicc[@"createTime"]);
                model.payType = NULL_TO_NIL(dicc[@"payType"]);
                model.totalPrice = NULL_TO_NIL(dicc[@"orderMoney"]);
                [self.dataArray addObject:model];
            }
            NSArray *array = data[@"data"];
            if(array.count == 0){
                
                [ALToastView toastInView:self.view withText:@"没有更多数据"];
            }
            
        }else{
            
            NSString *msg = data[@"message"];
            
            [ALToastView toastInView:self.view withText:msg];
            
        }
        
        [self.tabView reloadData];
        
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
    
    return self.dataArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderCell *cell=[OrderCell cellWithTableView:tableView];
    
    cell.dataArray = self.dataArray[indexPath.row];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
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
