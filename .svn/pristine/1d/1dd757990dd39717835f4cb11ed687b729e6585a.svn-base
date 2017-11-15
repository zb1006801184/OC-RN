//
//  TableManagerViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/25.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "TableManagerViewController.h"
#import "AddTableViewController.h"
#import "AddTableTableViewCell.h"
#import "TableClassListViewController.h"

@interface TableManagerViewController ()<UITableViewDelegate,UITableViewDataSource,AddTableSelectedDelegete>
{
    NSInteger page_index;
}
@property (nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIButton *deleteButton;
@property (nonatomic,strong)UIButton *cancelButton;
@property (nonatomic,strong)NSString *styleStr;
@property (nonatomic,strong)NSMutableArray *mainArray;

@end

@implementation TableManagerViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    page_index = 1;
    [self setTableListData:page_index];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"餐位管理" isBack:YES];
    [self setNAVRight];
    self.styleStr = @"正常";
    self.view.backgroundColor = RGB_COLOR(239, 239, 239);
    [self.view addSubview:self.mainTableView];
    [self setbottomViewUI];
    page_index = 1;
    [self setTableListData:page_index];
    [self setupRefresh];
}

- (void)setNAVRight
{
    UIButton *finashButton = [JQXCustom creatButton:CGRectMake(SCREEN_WIDTH - 60, 0, 60, 44) backColor:[UIColor clearColor]  text:@"分类" textColor:[UIColor whiteColor] font:Font(14) addTarget:self Action:@selector(finashAction)];
    [self.navBarView addSubview:finashButton];
    
}
- (void)finashAction
{
    TableClassListViewController *vc = [[TableClassListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
    if([self.styleStr isEqualToString:@"正常"]){
        static NSString *identifer = @"AddTableTableViewCellID";
        AddTableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer ];
        if(cell == nil){
            cell = [[AddTableTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer style:self.styleStr];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(self.mainArray.count != 0){
            NSDictionary *dic = [self.mainArray objectAtIndex:indexPath.row];
            [cell setData:dic];
        }
        return cell;
    }else{
        
        static NSString *identifer = @"AddTableEditTableViewCellID";
        AddTableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(cell == nil){
            cell = [[AddTableTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer style:self.styleStr];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell.tableDelegate = self;
        if(self.mainArray.count != 0){
            NSDictionary *dic = [self.mainArray objectAtIndex:indexPath.row];
            [cell setData:dic];
        }
        return cell;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 81;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.mainArray objectAtIndex:indexPath.row];
    AddTableViewController *vc = [[AddTableViewController alloc]init];
    vc.styleStr = @"编辑餐位";
    vc.tableID = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"id"])];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 选中按钮
- (void)SelecctedTableSure:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    NSDictionary *dic = [self.mainArray objectAtIndex:indexPath.row];
    if([dic[@"isChoose"] integerValue] == 2){ //isChoose 1是未预订。2是已预定
        [ALToastView toastInView:self.view withText:@"该餐位已被预订"];
    }else{
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.mainArray objectAtIndex:indexPath.row]];
        [dic setObject:@"1" forKey:@"edit"];
        
        [self.mainArray replaceObjectAtIndex:indexPath.row withObject:dic];
        [self.mainTableView reloadData];
    }
}
#pragma mark - 取消按钮
- (void)SelecctedTableCancel:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.mainArray objectAtIndex:indexPath.row]];
    [dic setObject:@"0" forKey:@"edit"];
    
    [self.mainArray replaceObjectAtIndex:indexPath.row withObject:dic];
    [self.mainTableView reloadData];
}



- (void)setbottomViewUI{

    [self.bottomView removeFromSuperview];
    [self.deleteButton removeFromSuperview];
    [self.cancelButton removeFromSuperview];
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 45)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = RGB_COLOR(226, 226, 226);
    [self.bottomView addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, 0.5, 25)];
    lineView1.backgroundColor = RGB_COLOR(226, 226, 226);
    [self.bottomView addSubview:lineView1];
    
    NSArray *titleArray1 = @[@"  添加新餐位",@"  删除"];
    NSArray *imgArray = @[@"jia",@"piliang"];
    for (int i = 0; i < titleArray1.count; i ++) {
        UIButton *button = [JQXCustom creatButton:CGRectMake(i *SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, self.bottomView.height) backColor:[UIColor clearColor] text:titleArray1[i] textColor:[UIColor colorWithHexString:@"#333333"] font:[UIFont systemFontOfSize:15] addTarget:self Action:@selector(BottomTwoAction:)];
        [button setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        button.tag = 200 + i;
        [self.bottomView addSubview:button];
    }
    
}
#pragma mark - 删除按钮
- (void)setDeleteButtonUI
{
    [self.bottomView removeFromSuperview];
    [self.deleteButton removeFromSuperview];
    [self.cancelButton removeFromSuperview];
    self.deleteButton = [JQXCustom creatButton:CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH/2, 45) backColor:BACKGROUNGCOLOR text:@"删除" textColor:[UIColor whiteColor] font:Font(15) addTarget:self Action:@selector(bottomButtonAction)];
    [self.view addSubview:self.deleteButton];
    
    self.cancelButton = [JQXCustom creatButton:CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT - 45, SCREEN_WIDTH/2, 45) backColor:[UIColor whiteColor] text:@"取消" textColor:[UIColor blackColor] font:Font(15) addTarget:self Action:@selector(cancleAction)];
    [self.view addSubview:self.cancelButton];
    
}
#pragma mark - 取消编辑状态
- (void)cancleAction
{
    self.styleStr = @"正常";
    for (int i = 0; i < self.mainArray.count; i ++) {
        NSMutableDictionary *dic = [self.mainArray objectAtIndex:i];
        [dic setValue:@"0" forKey:@"edit"];
        [self.mainArray replaceObjectAtIndex:i withObject:dic];
    }
    [self setbottomViewUI];
    [self.mainTableView reloadData];
}
#pragma mark - 删除按钮
- (void)bottomButtonAction
{
    
    NSMutableArray *idArr = [NSMutableArray array];
    for (int i = 0; i < self.mainArray.count; i ++) {
        NSDictionary *dict = [self.mainArray objectAtIndex:i];
        if([dict[@"edit"] integerValue] == 1){
            NSString *isStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dict[@"id"])];
            [idArr addObject:isStr];
        }
        
    }

    if(idArr.count != 0){
        //已选择的商品
        NSString *idStr = [idArr componentsJoinedByString:@","];
        [self deleteTable:idStr];
       
    }else{
        [ALToastView toastInView:self.view withText:@"请先选择餐位"];
    }
}
#pragma mark - 添加新商品，批量管理按钮点击事件
- (void)BottomTwoAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 200:
        {
            self.styleStr = @"正常";
            AddTableViewController *addVC = [[AddTableViewController alloc]init];
            addVC.styleStr = @"添加餐位";
            [self.navigationController pushViewController:addVC animated:YES];
        }
            break;
        case 201:
        {
            self.styleStr = @"编辑";
            [self setDeleteButtonUI];
            [self.mainTableView reloadData];
        }
            break;
        default:
            break;
    }
    
}

//下拉刷新
- (void)setupRefresh
{
    
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(header)];
     self.mainTableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footer)];
}

-(void)header{
    
    page_index = 1;
    
    [self setTableListData:page_index];
    
}

-(void)footer{
    
    
    page_index +=1;
    
    [self setTableListData:page_index];
    
}

#pragma mark - 请求列表
- (void)setTableListData:(NSInteger)page{
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];

    NSString *pageStr = [NSString stringWithFormat:@"%ld",page];
    NSDictionary *params = @{@"pageNum":pageStr,@"pageSize":@10,@"merchantId":self.merchantId};
    [QJGlobalControl sendGETWithUrl:JQXHttp_TableListPhone parameters:params success:^(id data) {
        [JHHJView hideLoading];
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
//        NSLog(@"data =====   %@",data);
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

- (void)ListSuccess:(NSArray*)array_{
    if(page_index == 1){
        
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
        
        UIView *imgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50)];
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
#pragma mark - 删除餐位
- (void)deleteTable:(NSString *)idStr
{
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    NSDictionary *params = @{@"ids":idStr};
    
    [QJGlobalControl sendGETWithUrl:JQXHttp_TableDelete parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data =====   %@",data);
        if([data[@"code"] integerValue] == 200){
            self.styleStr = @"正常";
            [self setbottomViewUI];
            page_index = 1;
            [self setTableListData:page_index];
            [ALToastView toastInView:self.view withText:@"删除餐位成功"];
            
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
        _mainTableView.tableFooterView = [UIView new];
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        headerView.backgroundColor = RGB_COLOR(239, 239, 239);
        _mainTableView.tableHeaderView = headerView;
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
