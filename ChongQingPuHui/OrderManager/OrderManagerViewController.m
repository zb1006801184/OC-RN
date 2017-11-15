//
//  OrderManagerViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/22.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "OrderManagerViewController.h"
#import "FSCustomButton.h"        // 自定义按钮
#import "OrderMangerTableViewCell.h"
@interface OrderManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger pageIndex;
}
@property (nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)NSMutableArray *mainArray;
@property (nonatomic,strong)NSString *styleStr;//待支付 ，已支付
@end

@implementation OrderManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"订单管理" isBack:YES];
    self.view.backgroundColor = RGB_COLOR(239, 239, 239);
    [self setMainButtonUI];
    self.styleStr = @"待支付";
    [self.view addSubview:self.mainTableView];
    pageIndex = 1;
    [self getOrderList:pageIndex];
    [self setupRefresh];
    
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
    static NSString *identifer = @"OrderMangerTableViewCellID";
    OrderMangerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(cell == nil){
        cell = [[OrderMangerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if(self.mainArray.count != 0){
        NSDictionary *dic = [self.mainArray objectAtIndex:indexPath.row];
        [cell setDataList:dic];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_HEIGHT(120) + 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)setMainButtonUI
{
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, SCALE_HEIGHT(60))];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    NSArray *titleArray = @[@"待支付",@"已支付"];
    NSArray *imgNArray = @[@"dingdan_daizhifu_n",@"dingdan_yizhifu_n"];
    NSArray *imgSArray = @[@"dingdan_daizhifu_s",@"dingdan_yizhifu_s"];
    FSCustomButton *button = [FSCustomButton new];
    
    for (int i = 0; i< titleArray.count; i++) {
        
        button = [self createButtonWithFrame:CGRectMake((SCREEN_WIDTH - SCALE_HEIGHT(60) *2 - 40)/2 + i * SCALE_HEIGHT(60) + i * 40, 0, SCALE_HEIGHT(60),SCALE_HEIGHT(60) ) title:titleArray[i] imageName:imgNArray[i] selectedTitleColor:BACKGROUNGCOLOR selectedImage:imgSArray[i]];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        if(i == 0){
            button.selected = YES;
        }
        [whiteView addSubview:button];
    }
    
    NSArray *titleArray1 = @[@"时间",@"账号／消费额度",@"支付类型"];
    for (int i = 0; i < titleArray1.count; i ++) {
        
       UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(SCREEN_WIDTH/3 * i, whiteView.bottom, SCREEN_WIDTH/3, 40) backColor:[UIColor clearColor] text:titleArray1[i] textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentCenter numOnLines:0];
        [self.view addSubview:tsLabel];
        
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
            self.styleStr = @"待支付";
            break;
        case 101:
            self.styleStr = @"已支付";
            break;
        default:
            break;
    }
    
    pageIndex = 1;
    
    [self getOrderList:pageIndex];
    
}


//下拉刷新
- (void)setupRefresh
{
    
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(header)];
    
    self.mainTableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footer)];
    
}

-(void)header{
    
    pageIndex = 1;
    
    [self getOrderList:pageIndex];
    
}

-(void)footer{
    
    pageIndex +=1;
    
    [self getOrderList:pageIndex];
    
}

#pragma mark - 获取预定管理列表
- (void)getOrderList:(NSInteger)page
{
    
    int type;
    if([self.styleStr isEqualToString:@"待支付"]){
        type = 0;
    }else {
        type = 2;
    }
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSString *typeStr = [NSString stringWithFormat:@"%d",type];
    NSString *pageStr = [NSString stringWithFormat:@"%ld",page];
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:UserID];
    
    NSDictionary *params = @{@"merchantId":userID,@"status":typeStr,@"pageSize":@10,@"page":pageStr};
    
    [QJGlobalControl sendPOSTWithUrl:JQXHttp_OrderList parameters:params success:^(id data) {
        [JHHJView hideLoading];
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        
        if([data[@"code"] integerValue] == 200){
            [self ListSuccess:data[@"data"]];
        }else if([data[@"code"] integerValue] == 10107){
            NSString *str = [NSString stringWithFormat:@"%@",NULL_TO_NIL(data[@"data"])];
            if([str integerValue] == 0){
                NSArray *arr = [NSArray array];
                [self ListSuccess:arr];
            }
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
        
        UIView *imgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - SCALE_HEIGHT(60) - 40)];
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



- (UITableView *)mainTableView
{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom + SCALE_HEIGHT(60) + 40, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarView.bottom - SCALE_HEIGHT(60) - 40) style:UITableViewStylePlain];
        _mainTableView.backgroundColor = RGB_COLOR(239, 239, 239);
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableFooterView = [UIView new];
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}
- (NSMutableArray *)mainArray
{
    if(!_mainArray){
        _mainArray = [NSMutableArray array];
    }
    return _mainArray;
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
