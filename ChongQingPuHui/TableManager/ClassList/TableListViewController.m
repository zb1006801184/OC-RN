//
//  TableListViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/10/9.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "TableListViewController.h"
#import "AddTableTableViewCell.h"
@interface TableListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)NSMutableArray *mainArray;
@end

@implementation TableListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"分类餐位列表" isBack:YES];
    [self.view addSubview:self.mainTableView];
    [self setTableListData];
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
    static NSString *identifer = @"TableListCellID";
    AddTableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer ];
    if(cell == nil){
        cell = [[AddTableTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer style:@"正常"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(self.mainArray.count != 0){
        NSDictionary *dic = [self.mainArray objectAtIndex:indexPath.row];
        [cell setData:dic];
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


#pragma mark - 请求列表
- (void)setTableListData{
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSDictionary *params = @{@"merchantId":self.merchantId,@"dishTypeId":self.idStr};
    [QJGlobalControl sendGETWithUrl:JQXHttp_TableClassSmallList parameters:params success:^(id data) {
        [JHHJView hideLoading];

        if([data[@"code"] integerValue] == 200){
            
            self.mainArray =  data[@"data"];
            [self.mainTableView reloadData];
            
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
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarView.bottom) style:UITableViewStylePlain];
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
