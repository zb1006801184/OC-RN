//
//  JQXServiceViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/10/19.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "JQXServiceViewController.h"
#import "JQXServiceCollectionViewCell.h"
#import "ServiceSetUpViewController.h"
@interface JQXServiceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,JQXServiceDelegate>
@property (nonatomic,strong)UICollectionView *mainCollectionView;
@property (nonatomic,strong)NSMutableArray *mainArray;
@end

@implementation JQXServiceViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setMainUIData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"服务经理" isBack:YES];
    [self setMainUIData];
    [self.view addSubview:self.mainCollectionView];
    [self.mainCollectionView registerClass:[JQXServiceCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
  
}
#pragma mark -- UICollectionViewDataSource
/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mainArray.count +1;
}
/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JQXServiceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if(indexPath.row < self.mainArray.count){
        cell.addImage.hidden = YES;
        cell.delegate = self;
        [cell setMainUIData:[self.mainArray objectAtIndex:indexPath.row]];
    }if(indexPath.row == self.mainArray.count){
         cell.addImage.hidden = NO;
    }

    return cell;
}
//点击item事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceSetUpViewController *vc = [[ServiceSetUpViewController alloc]init];
    if(indexPath.row == self.mainArray.count){
        vc.styleStr = @"正常";
    }else{
        NSDictionary *dic = [self.mainArray objectAtIndex:indexPath.row];
        vc.styleStr = @"编辑";
        vc.mainDic = dic;
    }
     [self.navigationController pushViewController:vc animated:YES];
}
- (UICollectionView *)mainCollectionView
{
    if(!_mainCollectionView){
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        // 1.设置列间距
        layout.minimumInteritemSpacing = 5;
        // 2.设置行间距
        layout.minimumLineSpacing = 5;
        // 3.设置每个item的大小
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 5)/2, (SCREEN_WIDTH - 5)/2 + 20);
        
        _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarView.bottom) collectionViewLayout:layout];
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;

    }
    return _mainCollectionView;
}
#pragma mark - 删除
- (void)ServiceDelete:(NSDictionary *)dic
{
    NSLog(@"删除按钮点击事件");
    
    //UIAlertController风格：UIAlertControllerStyleAlert
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                             message:@"是否删除该服务经理"
                                                                      preferredStyle:UIAlertControllerStyleAlert ];
    
    //添加取消到UIAlertController中
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    
    //添加确定到UIAlertController中
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self DeleteManagerData:dic];
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}
#pragma mark - 打电话
- (void)ServiceCallDelete:(NSDictionary *)dic
{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@"
                           ,dic[@"telphone"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
#pragma mark - 请求数据列表
- (void)setMainUIData{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:UserID];
    NSDictionary *params = @{@"userId":userid,@"type":@"1"};
    
    [QJGlobalControl sendPOSTWithUrl:JQXServiceManager_Url parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data === %@",data);
        if([data[@"code"] integerValue] == 200){
            self.mainArray = data[@"data"];
            [self.mainCollectionView reloadData];
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        NSLog(@"error === %@",error);
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
}

#pragma mark - 删除
- (void)DeleteManagerData:(NSDictionary *)dic{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSString *managerid = [NSString stringWithFormat:@"%@",dic[@"id"]];
    NSDictionary *params = @{@"id":managerid,@"type":@"3"};
    
    [QJGlobalControl sendPOSTWithUrl:JQXServiceManager_Url parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data === %@",data);
        if([data[@"code"] integerValue] == 200){
            [self setMainUIData];
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        NSLog(@"data === %@",error);
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
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
