//
//  ClassShopViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/9/1.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "ClassShopViewController.h"
#import "ClassShopTableViewCell.h"
@interface ClassShopViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger pageIndex;
}
@property (nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)NSMutableArray *shopArray;

@end

@implementation ClassShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self setNavBarWithTitle:self.titleStr isBack:YES];
    [self setNavBarWithTitle:@"分类商品列表" isBack:YES];
    self.view.backgroundColor = RGB_COLOR(239, 239, 239);
    [self.view addSubview:self.mainTableView];
    pageIndex = 1;
    [self getShopListData:pageIndex];
}
#pragma mark - UITableViewDelegate
//section

//indexPath.row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shopArray.count;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"ClassShopTableViewCellID";
    ClassShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(cell == nil){
        cell = [[ClassShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
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


#pragma mark - 获取商品列表
- (void)getShopListData:(NSInteger)page
{
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    NSDictionary *params = @{@"merchantid":self.merchantId,@"dishTypeId":self.dishTypeId};
    [QJGlobalControl sendGETWithUrl:JQXHttp_ClassShopList parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data =====   %@",data);
        if([data[@"code"] integerValue] == 200){
            
            [self ListSuccess:data[@"data"]];
            
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}

- (void)ListSuccess:(NSArray*)array_{
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




- (UITableView *)mainTableView
{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom , SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarView.bottom) style:UITableViewStylePlain];
        _mainTableView.backgroundColor = RGB_COLOR(239, 239, 239);
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        headerView.backgroundColor = RGB_COLOR(239, 239, 239);
        _mainTableView.tableHeaderView = headerView;
        _mainTableView.tableFooterView = [UIView new];
        [_mainTableView setEditing:NO animated:YES];
    }
    return _mainTableView;
}
- (NSMutableArray *)shopArray
{
    if(!_shopArray){
        _shopArray = [NSMutableArray array];
    }
    return _shopArray;
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
