//
//  AdvanceManagerViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/25.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "AdvanceManagerViewController.h"
#import "FSCustomButton.h"
#import "AdvanceTableViewCell.h"
#import "OrderManagerDeatilsController.h"
#import "MessageViewController.h"
@interface AdvanceManagerViewController ()<UITableViewDelegate,UITableViewDataSource,AdvanceTableViewCellDelegate>
{
    NSInteger pageIndex;
}
@property (nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)NSString *styleStr;
@property (nonatomic,strong)NSMutableArray *mainArray;
@property (nonatomic,strong)NSDictionary *orderDic;

@end

@implementation AdvanceManagerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([self.styleStr isEqualToString:@"待确认"]){
        pageIndex = 1;
        [self getAdvanceList:pageIndex];
        [self setupRefresh];
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"预定管理" isBack:NO];
    self.styleStr = @"待确认";
    self.view.backgroundColor = RGB_COLOR(239, 239, 239);
    [self setMainButtonUI];
    [self.view addSubview:self.mainTableView];
    pageIndex = 1;
    [self getAdvanceList:pageIndex];
    [self setupRefresh];
    [self setNAVLeft];
    // 接单通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifActon:) name:@"JQXOrderSuccess" object:nil];
    
}

- (void)notifActon:(NSNotification *)notif
{
    NSString *orderStr = [NSString stringWithFormat:@"%@",notif.userInfo[@"orderNo"]];
    for (int i = 0; i < self.mainArray.count; i ++) {
        NSDictionary *dic = [self.mainArray objectAtIndex:i];
        NSString *orderNo = [NSString stringWithFormat:@"%@",dic[@"orderNo"]];
        if([orderNo isEqualToString:orderStr]){
         
            [self.mainArray removeObject:dic];
            [self.mainTableView reloadData];
            
        }
    }
}


#pragma mark - UITableViewDelegate

//indexPath.row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainArray.count;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"AdvanceTableViewCellID";
    AdvanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(cell == nil){
        cell = [[AdvanceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.cellDelegate = self;
    if(self.mainArray.count != 0){
        NSDictionary *dic = [self.mainArray objectAtIndex:indexPath.row];
        [cell setDataDic:dic index:indexPath.row];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10 + 51 + 60*3 + 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.mainArray objectAtIndex:indexPath.row];
    OrderManagerDeatilsController *detailsVC = [[OrderManagerDeatilsController alloc]init];
    detailsVC.orderNo = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"orderNo"])];
    [self.navigationController pushViewController:detailsVC animated:YES];
}
#pragma mark - 接单按钮点击事件
- (void)AdvanceTableViewCell:(NSDictionary *)dic
{
    
    NSString *orderNo = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"orderNo"])];
    self.orderDic = dic;
    [self getOrderNO:orderNo];
    
}
#pragma mark - 取消接单按钮点击事件
- (void)AdvanceCancleTableViewCell:(NSDictionary *)dic
{
    
    NSString *orderID = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"id"])];
    self.orderDic = dic;
    [self getCancleOrderId:orderID];
    
}


#pragma mark - 查看评价信息
- (void)MessageTableViewCell:(NSDictionary *)dic
{
    
    MessageViewController *vc = [[MessageViewController alloc]init];
    vc.orderID = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"id"])];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)setMainButtonUI
{
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, SCALE_HEIGHT(60))];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    NSArray *titleArray = @[@"待确认",@"已确认",@"评价"];
    NSArray *imgNArray = @[@"yudingguanli_img_daiqueren_n",@"yudingguanli_img_yiqueren_n",@"yudingguanli_img_pingjia_n"];
    NSArray *imgSArray = @[@"yudingguanli_img_daiqueren_s",@"yudingguanli_img_yiqueren_s",@"yudingguanli_img_pingjia_s"];
    FSCustomButton *button = [FSCustomButton new];
    
    for (int i = 0; i< titleArray.count; i++) {
        
        button = [self createButtonWithFrame:CGRectMake((SCREEN_WIDTH - SCALE_HEIGHT(60) *3 - 30)/2 + i * SCALE_HEIGHT(60) + i * 30, 0, SCALE_HEIGHT(60),SCALE_HEIGHT(60) ) title:titleArray[i] imageName:imgNArray[i] selectedTitleColor:BACKGROUNGCOLOR selectedImage:imgSArray[i]];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        if(i == 0){
            button.selected = YES;
        }
        [whiteView addSubview:button];
    }
    
    
}

-(void)buttonAction:(FSCustomButton *)sender{
    
    
    FSCustomButton *button = [FSCustomButton new];
    
    for (int i = 0; i < 4; i++) {
        
        button = [self.view viewWithTag:100 + i];
        
        if (button.tag == sender.tag) {
            
            button.selected = YES;
            
        }else{
            
            button.selected = NO;
            
        }
        
        
    }
    
    NSLog(@"%ld",sender.tag);
    
    switch (sender.tag) {
        case 100:
            self.styleStr = @"待确认";
            break;
        case 101:
            self.styleStr = @"已确认";
            break;
        case 102:
            self.styleStr = @"评价";
            break;
        default:
            break;
    }
    pageIndex = 1;
    [self getAdvanceList:pageIndex];
}

//下拉刷新
- (void)setupRefresh
{
    
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(header)];
    [self.mainTableView.mj_header beginRefreshingWithCompletionBlock:^{
        
    }];
    
    self.mainTableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footer)];
    
}

-(void)header{
    
    pageIndex = 1;
    
    [self getAdvanceList:pageIndex];
    
}

-(void)footer{
    pageIndex +=1;
    
    [self getAdvanceList:pageIndex];
    
}


#pragma mark - 获取预定管理列表
- (void)getAdvanceList:(NSInteger)page
{
    int type;
    if([self.styleStr isEqualToString:@"待确认"]){
        type = 1;
    }else if([self.styleStr isEqualToString:@"已确认"]){
        type = 2;
    }else{
        type = 3;
    }
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSString *typeStr = [NSString stringWithFormat:@"%d",type];
    NSString *pageStr = [NSString stringWithFormat:@"%ld",page];
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:UserID];
    NSDictionary *params = @{@"userId":userID,@"status":typeStr,@"pageSize":@10,@"pageNum":pageStr};

    [QJGlobalControl sendGETWithUrl:JQXHttp_AdvanceManagerList parameters:params success:^(id data) {
        [JHHJView hideLoading];
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
//        NSLog(@"data    =======   %@",data);
        
        if([data[@"code"] integerValue] == 200){
            [self ListSuccess:data[@"data"]];
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
    
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}


- (void)ListSuccess:(NSArray*)array_{
    if(pageIndex == 1){
        
        //判断列表数组数据个数是否大于0
        if(self.mainArray.count > 0){
            [self.mainArray removeAllObjects];  //如果大于零清空数组中的数据
        }
    }
    
    // for循环array_数组所有数据
    for (NSInteger i=0 ; i < array_.count; i++) {
        
        [self.mainArray addObject:[array_ objectAtIndex:i]]; //把array_数组中的数据添加到可变数
        
    }
    
    if(self.mainArray.count == 0){
        
        UIView *imgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - SCALE_HEIGHT(60))];
        imgView.backgroundColor = RGB_COLOR(239, 239, 239);
        UIImageView *nullImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 240)/2, (imgView.height - 245)/2, 240, 245)];
        nullImage.image = [UIImage imageNamed:@"NullBgImage"];
        [imgView addSubview:nullImage];
        self.mainTableView.tableFooterView = imgView;
        
    }else{
        self.mainTableView.tableFooterView = [UIView new];
    }

    
    
    [self.mainTableView reloadData];
}

#pragma mark - 商户接单数据请求
- (void)getOrderNO:(NSString *)orderNo
{
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSDictionary *params = @{@"orderNo":orderNo};
    
    [QJGlobalControl sendGETWithUrl:JQXHttp_AdvanceAgreeOrder parameters:params success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"]integerValue] == 200){
            NSLog(@"data   ====     %@",data);
            [ALToastView toastInView:self.view withText:@"接单成功"];
            [self setupRefresh];
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
        
         [[NSNotificationCenter defaultCenter] postNotificationName:@"JQXHaveButton" object:nil userInfo:nil];
        
    } fail:^(NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"JQXHaveButton" object:nil userInfo:nil];
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
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
            [self setupRefresh];
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
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"JQXHaveButton" object:nil userInfo:nil];
        
    } fail:^(NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"JQXHaveButton" object:nil userInfo:nil];
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}

- (UITableView *)mainTableView
{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom + SCALE_HEIGHT(60), SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarView.bottom - SCALE_HEIGHT(60)) style:UITableViewStylePlain];
        _mainTableView.backgroundColor = RGB_COLOR(239, 239, 239);
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableFooterView = [UIView new];
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}

-(FSCustomButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName selectedTitleColor:(UIColor *)selectedTitleColor selectedImage:(NSString *)selectedImage{
    
    
    FSCustomButton *button = [[FSCustomButton alloc] initWithFrame:frame];
    button.adjustsTitleTintColorAutomatically = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    button.buttonImagePosition = FSCustomButtonImagePositionTop;
    [self.view addSubview:button];
    
    
    return button;
}
#pragma mark - 导航栏
- (void)setNAVLeft
{
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 11, 22, 22)];
    backImg.image = [UIImage imageNamed:@"nav_icon"];
    [self.navBarView addSubview:backImg];
    
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 44)];
    [backBut addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView addSubview:backBut];
}

- (void)backAction
{
    if([self.pushStr isEqualToString:@"Push"]){
        
        AppDelegate * app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [app setHomeRoot];
        
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
}
- (NSMutableArray *)mainArray
{
    if(!_mainArray){
        _mainArray = [NSMutableArray array];
    }
    return _mainArray;
}
- (void) dealloc {
    
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
