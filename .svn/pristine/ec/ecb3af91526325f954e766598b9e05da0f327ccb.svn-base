//
//  TableClassListViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/10/9.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "TableClassListViewController.h"
#import "AddClassViewController.h"
#import "ClassTableViewCell.h"
#import "TableListViewController.h"
@interface TableClassListViewController ()<UITableViewDelegate,UITableViewDataSource,ClassDelegate>
@property (nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)UIView *bottomClassView;
@property (nonatomic,strong)UIButton *bottomEditClassButton;
@property (nonatomic,strong)NSString *classStr;
@property (nonatomic,strong)NSMutableArray *classArray;
@property (nonatomic,strong)NSDictionary *classDic;
@end

@implementation TableClassListViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getClassListData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"餐桌分类" isBack:YES];
    self.view.backgroundColor = RGB_COLOR(239, 239, 239);
    self.classStr = @"正常";
    [self.view addSubview:self.mainTableView];
    [self setClassBottomViewUI];
    [self getClassListData];
}

#pragma mark - UITableViewDelegate
//indexPath.row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classArray.count;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( [self.classStr isEqualToString: @"正常"]){
        static NSString *identifer = @"ClassTableListViewCellID";
        ClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(cell == nil){
            cell = [[ClassTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer style:@"正常"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        if(self.classArray.count != 0){
            NSDictionary *dic = [self.classArray objectAtIndex:indexPath.row];
            [cell setDataDic:dic];
        }
        
        return cell;
        
    }else{//编辑状态
        static NSString *identifer = @"ClassTableListViewEditCellID";
        ClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if(cell == nil){
            cell = [[ClassTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer style:@"编辑"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.delegate = self;
        if(self.classArray.count != 0){
            NSDictionary *dic = [self.classArray objectAtIndex:indexPath.row];
            [cell setDataDic:dic];
        }
        return cell;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.classArray objectAtIndex:indexPath.row];
    NSString *idStr = [NSString stringWithFormat:@"%@",dic[@"id"]];
    TableListViewController *vc = [[TableListViewController alloc]init];
    vc.idStr = idStr;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - ClassDelegate
- (void)EditClassCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    NSDictionary *dic = [self.classArray objectAtIndex:indexPath.row];
    NSString *classStr = [NSString stringWithFormat:@"%@",dic[@"typeName"]];
    NSString *idStr = [NSString stringWithFormat:@"%@",dic[@"id"]];
    AddClassViewController *addVC = [[AddClassViewController alloc]init];
    addVC.styleStr = @"编辑餐位分类";
    addVC.classStr = classStr;
    addVC.idStr = idStr;
    [self.navigationController pushViewController:addVC animated:YES];
}
#pragma mark - 删除该Cell
- (void)DelegateCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    self.classDic = [self.classArray objectAtIndex:indexPath.row];
    [UIAlertView alertViewTitle:@"提示" message:@"是否删除该分类" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    
    if(buttonIndex == 1){
        [self getDeleteClass];
    }
}

- (void) ScrollCell:(UITableViewCell *)cell
{
    
}

#pragma mark - 获取分类列表
- (void)getClassListData
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSDictionary *params = @{@"merchantId":self.merchantId};
    [QJGlobalControl sendGETWithUrl:JQXHttp_TableClassList parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data =====   %@",data);
        if([data[@"code"] integerValue] == 200){
            
            self.classArray = data[@"data"];
            [self.mainTableView reloadData];
            
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}
#pragma mark - 删除分类
- (void)getDeleteClass
{
    NSString *idStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.classDic[@"id"])];
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSString *merchantId = [[NSUserDefaults standardUserDefaults]objectForKey:LoginId];
    NSDictionary *params = @{@"id":idStr,@"merchantid":merchantId,@"type":@"1"};
    [QJGlobalControl sendGETWithUrl:JQXHttp_DeleteClass parameters:params success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"] integerValue] == 200){
            [self getClassListData];
            
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
}

- (void)setClassBottomViewUI{

    self.bottomClassView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 45)];
    self.bottomClassView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomClassView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = RGB_COLOR(226, 226, 226);
    [self.bottomClassView addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, 0.5, 25)];
    lineView1.backgroundColor = RGB_COLOR(226, 226, 226);
    [self.bottomClassView addSubview:lineView1];
    
    NSArray *titleArray1 = @[@"  添加分类",@"  编辑分类"];
    NSArray *imgArray = @[@"jia",@"piliang"];
    for (int i = 0; i < titleArray1.count; i ++) {
        UIButton *button = [JQXCustom creatButton:CGRectMake(i *SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, self.bottomClassView.height) backColor:[UIColor clearColor] text:titleArray1[i] textColor:[UIColor colorWithHexString:@"#333333"] font:[UIFont systemFontOfSize:15] addTarget:self Action:@selector(ClassBottomTwoAction:)];
        [button setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        button.tag = 300 + i;
        [self.bottomClassView addSubview:button];
    }
    
}
- (void)ClassBottomTwoAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 300:
        {
            self.classStr = @"正常";
            AddClassViewController *addVC = [[AddClassViewController alloc]init];
            addVC.styleStr = @"添加餐位分类";
            [self.navigationController pushViewController:addVC animated:YES];
            [self setClassBottomViewUI];
        }
            break;
        case 301:
        {
            self.classStr = @"编辑";
            //            [self.mainTableView setEditing:YES animated:YES];
            [self.mainTableView reloadData];
            [self setClassEditBottomViewUI];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 编辑底部按钮
- (void)setClassEditBottomViewUI
{
    [self.bottomClassView removeFromSuperview];
    [self.bottomEditClassButton removeFromSuperview];
    
    self.bottomEditClassButton = [JQXCustom creatButton:CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 45) backColor:BACKGROUNGCOLOR text:@"完成" textColor:[UIColor whiteColor] font:Font(15) addTarget:self Action:@selector(bottomEditClassAction)];
    [self.view addSubview:self.bottomEditClassButton];
}
#pragma mark - 编辑分类结束
- (void)bottomEditClassAction
{
    self.classStr = @"正常";
    //    [self.mainTableView setEditing:NO animated:YES];
    [self.mainTableView reloadData];
    [self setClassBottomViewUI];
}


- (UITableView *)mainTableView
{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarView.bottom - 45) style:UITableViewStylePlain];
        _mainTableView.backgroundColor = RGB_COLOR(239, 239, 239);
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 7.5)];
        view.backgroundColor = RGB_COLOR(239, 239, 239);
        _mainTableView.tableHeaderView = view;
        _mainTableView.tableFooterView = [UIView new];
        [_mainTableView setEditing:NO animated:YES];
    }
    return _mainTableView;
}
- (NSMutableArray *)classArray
{
    if(!_classArray){
        _classArray = [NSMutableArray array];
    }
    return _classArray;
}
- (NSDictionary *)classDic
{
    if(!_classDic){
        _classDic = [NSDictionary dictionary];
    }
    return _classDic;
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
