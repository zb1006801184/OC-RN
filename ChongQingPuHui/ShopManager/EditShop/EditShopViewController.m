//
//  EditShopViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/24.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "EditShopViewController.h"
#import "EditShopTableViewCell.h"
#import "ShopClassView.h"
#import "AddClassViewController.h"
@interface EditShopViewController ()<UITableViewDelegate,UITableViewDataSource,ShoppingSectionDelegate,SelectedClassDelegate>
{
    NSInteger pageIndex;
    ShopClassView *shopView;
    NSString *editClassStr;
    
}
@property (nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)NSMutableArray *shopArray;
@property (nonatomic,strong)NSMutableArray *classArray;

@end

@implementation EditShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"批量管理" isBack:YES];
    editClassStr = @"正常";
    self.view.backgroundColor = RGB_COLOR(239, 239, 239);
    [self setBottomViewUI];
    [self.view addSubview:self.mainTableView];
    pageIndex = 1;
    [self getShopListData:pageIndex];
    [self setupRefresh];
    editClassStr = @"正常";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifActon:) name:@"JQXClassListData" object:nil];
    
}
- (void)notifActon:(NSNotification *)notif
{
    editClassStr = @"添加了新分类";
    [self getClassListData];
}
#pragma mark - UITableViewDelegate

//indexPath.row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shopArray.count;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"EditShopTableViewCellID";
    EditShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(cell == nil){
        cell = [[EditShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer style:self.styleStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.SelectedDelegate = self;
    }
    if(self.shopArray.count != 0){
        NSDictionary *dic = [self.shopArray objectAtIndex:indexPath.row];
        [cell setDataListDic:dic];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - 选中商品  ShoppingSelectedDelegate代理方法
- (void)SelectedSectionConfirmCell:(UITableViewCell *)cell
{
    
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.shopArray objectAtIndex:indexPath.row]];
    [dic setObject:@"1" forKey:@"edit"];
    [self.shopArray replaceObjectAtIndex:indexPath.row withObject:dic];
    [self.mainTableView reloadData];
    
    
}
#pragma mark - 取消选中商品  ShoppingSelectedDelegate代理方法

- (void)SelectedSectionCancelCell:(UITableViewCell *)cell
{
    
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.shopArray objectAtIndex:indexPath.row]];
    [dic setObject:@"0" forKey:@"edit"];
    
    [self.shopArray replaceObjectAtIndex:indexPath.row withObject:dic];
    [self.mainTableView reloadData];
    
    
}

- (void)setBottomViewUI{

    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 45)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = RGB_COLOR(226, 226, 226);
    [bottomView addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, 0.5, 25)];
    lineView1.backgroundColor = RGB_COLOR(226, 226, 226);
    [bottomView addSubview:lineView1];
    
    NSArray *titleArray1 = @[self.styleStr,@"分类至"];
    for (int i = 0; i < titleArray1.count; i ++) {
        UIButton *button = [JQXCustom creatButton:CGRectMake(i *SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, bottomView.height) backColor:[UIColor clearColor] text:titleArray1[i] textColor:[UIColor colorWithHexString:@"#333333"] font:[UIFont systemFontOfSize:15] addTarget:self Action:@selector(BottomTwoAction:)];
        button.tag = 100 + i;
        [bottomView addSubview:button];
    }
    
}
#pragma mark - 上架／下架，分类至
- (void)BottomTwoAction:(UIButton *)sender
{
    
    NSMutableArray *idArr = [NSMutableArray array];
    for (int i = 0; i < self.shopArray.count; i ++) {
        NSDictionary *dict = [self.shopArray objectAtIndex:i];
        if([dict[@"edit"] integerValue] == 1){
            NSString *isStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dict[@"pid"])];
            [idArr addObject:isStr];
        }
        
    }
    if(idArr.count != 0){
        //已选择的商品
        NSString *idStr = [idArr componentsJoinedByString:@","];
        if(sender.tag == 100){//下架上架
            [self getShopUpOutData:idStr];
            
        }else{//分类至
            [self getClassListData];
        }
    }else{
        [ALToastView toastInView:self.view withText:@"请先选择菜品"];
    }
}

#pragma mark - 分类代理方法(选择的分类)
- (void)SelectedClassSure:(NSDictionary *)dic
{
    if([dic objectForKey:@"id"]){
        NSString *dishStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"id"])];
        NSMutableArray *idArr = [NSMutableArray array];
        for (int i = 0; i < self.shopArray.count; i ++) {
            NSDictionary *dict = [self.shopArray objectAtIndex:i];
            if([dict[@"edit"] integerValue] == 1){
                NSString *isStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dict[@"pid"])];
                [idArr addObject:isStr];
            }
            
        }
        NSString *idStr = [idArr componentsJoinedByString:@","];
        
        [self getClassAfter:idStr dishTypeId:dishStr];
        
    }else{
        [ALToastView toastInView:shopView withText:@"请选择分类"];
    }
}
#pragma mark - 分类代理方法(新建分类)
- (void)NewClassController
{
    [shopView removeFromSuperview];
    AddClassViewController *vc = [[AddClassViewController alloc]init];
    vc.styleStr = @"添加商品分类";
    [self.navigationController pushViewController:vc animated:YES];
}


//下拉刷新
- (void)setupRefresh
{
    
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(header)];
    
    self.mainTableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footer)];
    
}

-(void)header{
    
    pageIndex = 1;
    
    
    [self getShopListData:pageIndex];
    
}

-(void)footer{
    
    
    pageIndex +=1;
    
    [self getShopListData:pageIndex];
    
}


#pragma mark - 获取商品列表
- (void)getShopListData:(NSInteger)page
{
    NSString *type = @"";//0出售中1下架
    if([self.styleStr isEqualToString:@"下架"]){
        type = @"0";
    }else if ([self.styleStr isEqualToString:@"上架"]){
        type = @"1";
    }
    
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    NSString *pageStr = [NSString stringWithFormat:@"%ld",page];
    NSDictionary *params = @{@"merchantid":self.merchantId,@"isDelete":type,@"sort":@"2",@"pageSize":@10,@"pageNum":pageStr};
    [QJGlobalControl sendGETWithUrl:JQXHttp_ShopList parameters:params success:^(id data) {
        [JHHJView hideLoading];
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        NSLog(@"data =====   %@",data);
        if([data[@"code"] integerValue] == 200){
            NSArray *arr = data[@"data"];
            NSMutableArray *newArray = [NSMutableArray array];
            if(arr.count != 0){
                for (int i = 0; i < arr.count; i ++) {
                    NSDictionary *dic = [arr objectAtIndex:i];
                    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                    [newDic setValue:@"0" forKey:@"edit"];
                    [newArray addObject:newDic];
                }
                
            }
            
            [self ListSuccess:newArray];
            
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
#pragma mark - 处理数据
- (void)ListSuccess:(NSMutableArray*)array_{
    if(pageIndex == 1){
        
        //判断列表数组数据个数是否大于0
        if(self.shopArray.count > 0){
            [self.shopArray removeAllObjects];  //如果大于零清空数组中的数据
        }
    }
    
    // for循环array_数组所有数据
    for (NSInteger i=0 ; i < array_.count; i++) {
        
        [self.shopArray addObject:[array_ objectAtIndex:i]]; //把array_数组中的数据添加到可变数
        
    }
    [self.mainTableView reloadData];
}
#pragma mark - 获取分类列表
- (void)getClassListData
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    NSDictionary *params = @{@"merchantId":self.merchantId,@"type":@"0"};
    
    [QJGlobalControl sendGETWithUrl:JQXHttp_ShopClassList parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data =====   %@",data);
        if([data[@"code"] integerValue] == 200){
            
            shopView = [[ShopClassView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) ClassStr:@"商品添加分类" classArr:data[@"data"] editStr:editClassStr];
            shopView.SelectedDelegate = self;
            [self.view addSubview:shopView];
            
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}
#pragma mark - 分类至
- (void)getClassAfter:(NSString *)ids dishTypeId:(NSString *)disID
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    NSDictionary *params = @{@"ids":ids,@"dishTypeId":disID};
    
    [QJGlobalControl sendGETWithUrl:JQXHttp_ClassAfter parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data =====   %@",data);
        if([data[@"code"] integerValue] == 200){
           
            [shopView removeFromSuperview];
            [ALToastView toastInView:self.view withText:@"分类成功"];
            pageIndex = 1;
            [self getShopListData:pageIndex];
            
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}


#pragma mark - 上架 下架
- (void)getShopUpOutData:(NSString *)idStr
{
    NSString *isDelete = @"";
    if([self.styleStr isEqualToString:@"下架"]){
        isDelete = @"1";
    }else{
        isDelete = @"0";
    }
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSDictionary *params = @{@"merchantid":self.merchantId,@"dishIds":idStr,@"isDelete":isDelete};
    
    [QJGlobalControl sendGETWithUrl:JQXHttp_ShopUpOut parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data =====   %@",data);
        if([data[@"code"] integerValue] == 200){
            [ALToastView toastInView:self.view withText:@"操作成功"];
            pageIndex = 1;
            [self getShopListData:pageIndex];
            
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}


- (UITableView *)mainTableView
{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarView.bottom - 45) style:UITableViewStylePlain];
        _mainTableView.backgroundColor = RGB_COLOR(239, 239, 239);
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        headerView.backgroundColor = RGB_COLOR(239, 239, 239);
        _mainTableView.tableHeaderView = headerView;
        _mainTableView.tableFooterView = [UIView new];
    }
    return _mainTableView;
}
- (NSMutableArray *)shopArray{
    if(!_shopArray){
        _shopArray = [NSMutableArray array];
    }
    return _shopArray;
}
- (NSMutableArray *)classArray
{
    if(!_classArray){
        _classArray = [NSMutableArray array];
    }
    return _classArray;
}
- (void)dealloc{
    
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
