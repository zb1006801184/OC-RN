//
//  ShoppingManagerViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/23.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "ShoppingManagerViewController.h"
#import "AddShopViewController.h"//添加商品
#import "EditShopViewController.h"//批量管理
#import "ShopManagerTableViewCell.h"
#import "AddClassViewController.h"//添加新分类
#import "ClassShopViewController.h"//查询类别下的商品
#import "ClassTableViewCell.h"
@interface ShoppingManagerViewController ()<UITableViewDelegate,UITableViewDataSource,ClassDelegate>
{
    NSInteger pageIndex;
}
@property (nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIView *bottomClassView;
@property (nonatomic,strong)UIButton *bottomEditClassButton;
@property (nonatomic,strong)NSString *topStr;
@property (nonatomic,strong)NSString *smallStr;
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)NSString *classStr;
@property (nonatomic,strong)NSMutableArray *classArray;
@property (nonatomic,strong)NSMutableArray *shopArray;
@property (nonatomic,strong)NSDictionary *classDic;
@end

@implementation ShoppingManagerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    pageIndex = 1;
    if([self.topStr isEqualToString:@"分类"]){
        [self getClassListData];
    }else {
        [self getShopListData:pageIndex];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"" isBack:YES];
    self.topStr = @"出售中";
    self.classStr = @"正常";
    self.view.backgroundColor = RGB_COLOR(239, 239, 239);
    [self setNavSegment];
    [self setMainUI];
    [self.view addSubview:self.mainTableView];
    
    pageIndex = 1;
    [self getShopListData:pageIndex];
    [self setupRefresh];
    
}

#pragma mark - UITableViewDelegate

//indexPath.row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.topStr isEqualToString:@"出售中"]){
        return self.shopArray.count;
    }else if ([self.topStr isEqualToString:@"已下架"]){
        return self.shopArray.count;
    }else{
        return self.classArray.count;
    }
    
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.topStr isEqualToString:@"出售中"]){
        static NSString *identifer = @"ShopManagerTableViewCellID";
        ShopManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(cell == nil){
            cell = [[ShopManagerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer style:self.topStr];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        if(self.shopArray.count != 0){
            NSDictionary *dic = [self.shopArray objectAtIndex:indexPath.row];
            [cell setDataListDic:dic];
        }
        return cell;
    }else if ([self.topStr isEqualToString:@"已下架"]){
        static NSString *identifer = @"ShopManagerTableViewCellID2";
        ShopManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(cell == nil){
            cell = [[ShopManagerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer style:self.topStr];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        if(self.shopArray.count != 0){
            NSDictionary *dic = [self.shopArray objectAtIndex:indexPath.row];
            [cell setDataListDic:dic];
        }
        return cell;
    }else{
        if( [self.classStr isEqualToString: @"正常"]){
            static NSString *identifer = @"ClassTableViewCellID";
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
            static NSString *identifer = @"ClassTableViewEditCellID";
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
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.topStr isEqualToString:@"分类"]){
        return 60;
    }else{
        return 81;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.topStr isEqualToString:@"分类"]){
        NSDictionary *dic = [self.classArray objectAtIndex:indexPath.row];
        NSString *idStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"id"])];
        NSString *titleStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"typeName"])];
        ClassShopViewController *vc = [[ClassShopViewController alloc]init];
        vc.dishTypeId = idStr;
        vc.titleStr = titleStr;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([self.topStr isEqualToString:@"已下架"]){
        NSDictionary *dic = [self.shopArray objectAtIndex:indexPath.row];
        AddShopViewController *addVC = [[AddShopViewController alloc]init];
        addVC.titleStr = @"编辑商品";
        addVC.idStr = [NSString stringWithFormat:@"%@",dic[@"pid"]];
        [self.navigationController pushViewController:addVC animated:YES];
    }
}
#pragma mark - 头部按钮
- (void)setNavSegment
{
    CGFloat buttonW = (SCREEN_WIDTH - 120)/3;
    NSArray *titleArray = @[@"出售中",@"已下架",@"分类"];
    @autoreleasepool {
        for (int i = 0; i < titleArray.count; i ++) {
            UIButton *navButton = [JQXCustom creatButton:CGRectMake(70 + i *buttonW + i *10, 8, buttonW, 44-16) backColor:BACKGROUNGCOLOR text:titleArray[i] textColor:[UIColor whiteColor] font:Font(15) addTarget:self Action:@selector(changeAction:)];
            navButton.tag = 1000 + i;
            navButton.layer.cornerRadius = 8;
            navButton.layer.masksToBounds = YES;
            if(i == 0){
                navButton.backgroundColor = [UIColor whiteColor];
                [navButton setTitleColor:BACKGROUNGCOLOR forState:UIControlStateNormal];
            }
            [self.navBarView addSubview:navButton];
            
        }
    }
    

}
#pragma mark - 头部按钮点击事件
- (void)changeAction:(UIButton *)sender
{
    UIButton *button = [UIButton new];
    
    for (int i = 0; i < 3; i++) {
        
        button = [self.view viewWithTag:1000 + i];
        
        if (button.tag == sender.tag) {
            
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:BACKGROUNGCOLOR forState:UIControlStateNormal];
            
        }else{
            
            button.backgroundColor = BACKGROUNGCOLOR;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        
        
    }
    
    NSInteger Index = (NSInteger)sender.tag;
    
    switch (Index) {
        case 1000:
            NSLog(@"点击了出售中");
            self.topStr = @"出售中";
            self.topView.hidden = NO;
//            [self.mainTableView setEditing:NO animated:YES];
            [self setBottomViewUI];
            [self.mainTableView setTop:self.navBarView.bottom + 40];
            [self.mainTableView setHeight:SCREEN_HEIGHT - self.navBarView.bottom - 45 - 40];
            [self setupRefresh];
            pageIndex = 1;
            [self getShopListData:pageIndex];
            break;
        case 1001:
            NSLog(@"点击了已下架");
            self.topStr = @"已下架";
            self.topView.hidden = NO;
//            [self.mainTableView setEditing:NO animated:YES];
            [self setBottomViewUI];
            [self.mainTableView setTop:self.navBarView.bottom + 40];
            [self.mainTableView setHeight:SCREEN_HEIGHT - self.navBarView.bottom - 45 - 40];
            [self setupRefresh];
            pageIndex = 1;
            [self getShopListData:pageIndex];
            break;
        case 1002:
            NSLog(@"点击了分类");
            self.topStr = @"分类";
            self.topView.hidden = YES;
            if([self.classStr isEqualToString:@"正常"]){
//                [self.mainTableView setEditing:NO animated:YES];
                [self setClassBottomViewUI];
            }else{
                [self setClassEditBottomViewUI];
//                [self.mainTableView setEditing:YES animated:YES];
            }
            [self.mainTableView setTop:self.navBarView.bottom];
            [self.mainTableView setHeight:SCREEN_HEIGHT - self.navBarView.bottom - 45];
            [self setupRefresh];
            //获取分类列表
            [self getClassListData];
            
            break;
        default:
            break;
    }

}
#pragma mark - 头试图 和 底部试图
- (void)setMainUI
{
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, 45)];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    
    NSArray *titleArray = @[@"添加时间",@"销量",@"库存"];
    for (int i = 0; i < titleArray.count; i ++) {
        UIButton *button = [JQXCustom creatButton:CGRectMake(i *SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, self.topView.height) backColor:[UIColor clearColor] text:titleArray[i] textColor:[UIColor colorWithHexString:@"#333333"] font:[UIFont systemFontOfSize:14] addTarget:self Action:@selector(ThiredAction:)];
        button.tag = 100 + i;
        [button setTitleColor:BACKGROUNGCOLOR forState:UIControlStateSelected];
        if(i == 0){
            button.selected = YES;
        }
        [self.topView addSubview:button];
    }
    [self setBottomViewUI];

}

#pragma mark - 添加时间，销量，库存按钮点击事件
- (void)ThiredAction:(UIButton *)sender
{
    
    UIButton *button = [UIButton new];
    
    for (int i = 0; i < 4; i++) {
        
        button = [self.view viewWithTag:100 + i];
        
        if (button.tag == sender.tag) {
            
            button.selected = YES;
            
        }else{
            
            button.selected = NO;
            
        }
        
        
    }
    switch (sender.tag) {
        case 100:
            self.smallStr = @"添加时间";
            break;
        case 101:
            self.smallStr = @"销量";
            break;
        case 102:
            self.smallStr = @"库存";
            break;
        default:
            break;
    }
    [self getShopListData:pageIndex];
    NSLog(@"%ld",sender.tag);
}
- (void)setBottomViewUI{
    [self.bottomView removeFromSuperview];
    [self.bottomClassView removeFromSuperview];
    [self.bottomEditClassButton removeFromSuperview];
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 45)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = RGB_COLOR(226, 226, 226);
    [self.bottomView addSubview:lineView];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, 0.5, 25)];
    lineView1.backgroundColor = RGB_COLOR(226, 226, 226);
    [self.bottomView addSubview:lineView1];
    
    NSArray *titleArray1 = @[@"  添加新商品",@"  批量管理"];
    NSArray *imgArray = @[@"jia",@"piliang"];
    for (int i = 0; i < titleArray1.count; i ++) {
        UIButton *button = [JQXCustom creatButton:CGRectMake(i *SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, self.bottomView.height) backColor:[UIColor clearColor] text:titleArray1[i] textColor:[UIColor colorWithHexString:@"#333333"] font:[UIFont systemFontOfSize:15] addTarget:self Action:@selector(BottomTwoAction:)];
        [button setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        button.tag = 200 + i;
        [self.bottomView addSubview:button];
    }

}
- (void)setClassBottomViewUI{
    
    [self.bottomView removeFromSuperview];
    [self.bottomClassView removeFromSuperview];
    [self.bottomEditClassButton removeFromSuperview];
    
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
#pragma mark - 编辑底部按钮
- (void)setClassEditBottomViewUI
{
    [self.bottomView removeFromSuperview];
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
#pragma mark - 添加新商品，批量管理按钮点击事件
- (void)BottomTwoAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 200:
        {
            AddShopViewController *addVC = [[AddShopViewController alloc]init];
            addVC.titleStr = @"添加商品";
            [self.navigationController pushViewController:addVC animated:YES];
        }
            break;
        case 201:
        {
            EditShopViewController *editVC = [[EditShopViewController alloc]init];
            if([self.topStr isEqualToString:@"出售中"]){
                editVC.styleStr = @"下架";
            }else if ([self.topStr isEqualToString:@"已下架"]){
                editVC.styleStr = @"上架";
            }
            [self.navigationController pushViewController:editVC animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)ClassBottomTwoAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 300:
        {
            self.classStr = @"正常";
            AddClassViewController *addVC = [[AddClassViewController alloc]init];
            addVC.styleStr = @"添加商品分类";
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

#pragma mark - 编辑分类代理事件ClassDetegate
#pragma mark - 编辑该Cell
- (void)EditClassCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    NSDictionary *dic = [self.classArray objectAtIndex:indexPath.row];
    NSString *classStr = [NSString stringWithFormat:@"%@",dic[@"typeName"]];
    NSString *idStr = [NSString stringWithFormat:@"%@",dic[@"id"]];
    AddClassViewController *addVC = [[AddClassViewController alloc]init];
    addVC.styleStr = @"编辑商品分类";
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
#pragma mark - 移动该Cell
- (void)ScrollCell:(UITableViewCell *)cell
{
    NSLog(@"移动该分类");
}
////打开编辑模式后，默认情况下每行左边会出现红的删除按钮，这个方法就是关闭这些按钮的
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
//           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return UITableViewCellEditingStyleNone;
//}
////这个方法用来告诉表格 这一行是否可以移动
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
////这个方法就是执行移动操作的
//-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
//{
//    //    需要的移动行
//    NSInteger fromRow = [sourceIndexPath row];
//    //    获取移动某处的位置
//    NSInteger toRow = [destinationIndexPath row];
//    //    从数组中读取需要移动行的数据
////    id object = [self.listData objectAtIndex:fromRow];
//    //    在数组中移动需要移动的行的数据
////    [self.listData removeObjectAtIndex:fromRow];
//    //    把需要移动的单元格数据在数组中，移动到想要移动的数据前面
////    [self.listData insertObject:object atIndex:toRow];
//}


//下拉刷新
- (void)setupRefresh
{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(header)];
    
    self.mainTableView.mj_header = header;
    
    MJRefreshBackStateFooter *footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(footer)];
    
    self.mainTableView.mj_footer = footer;
    
    
    if([self.topStr isEqualToString:@"分类"]){
        [self.mainTableView.mj_header setHidden:YES];
         [self.mainTableView.mj_footer setHidden:YES];
        
    }else{
        [self.mainTableView.mj_header setHidden:NO];
         [self.mainTableView.mj_footer setHidden:NO];
        
    }
   
    
}

-(void)header{
    
    pageIndex = 1;
    
    //请求出售中／已下架列表接口
    [self getShopListData:pageIndex];
    
}

-(void)footer{
    
    
    pageIndex +=1;
    
    //请求出售中／已下架列表接口
    [self getShopListData:pageIndex];
    
}

- (UITableView *)mainTableView
{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom + 45, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarView.bottom - 45 - 45) style:UITableViewStylePlain];
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
#pragma mark - 获取商品列表
- (void)getShopListData:(NSInteger)page
{
    NSString *isDelete = @"";//0出售中1下架
    if([self.topStr isEqualToString:@"出售中"]){
        isDelete = @"0";
    }else if ([self.topStr isEqualToString:@"已下架"]){
        isDelete = @"1";
    }
    
    NSString *sort = @"";//2：添加时间降序，3添加时间升序，4销量降序，5销量升序，6库存降序，7库存降序(目前只做135)
    if([self.smallStr isEqualToString:@"添加时间"]){
        sort = @"2";
    }else if ([self.smallStr isEqualToString:@"销量"]){
        sort = @"4";
    }else if ([self.smallStr isEqualToString:@"库存"]){
        sort = @"6";
    }
    
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    NSString *pageStr = [NSString stringWithFormat:@"%ld",page];
    NSDictionary *params = @{@"merchantid":self.merchantId,@"isDelete":isDelete,@"sort":sort,@"pageNum":pageStr,@"pageSize":@10};
    [QJGlobalControl sendGETWithUrl:JQXHttp_ShopList parameters:params success:^(id data) {
        [JHHJView hideLoading];
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        NSLog(@"data =====   %@",data);
        if([data[@"code"] integerValue] == 200){
            
            [self ListSuccess:data[@"data"]];
            
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
            [self.mainTableView reloadData];
        }
        
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
        [ALToastView toastInView:self.view withText:@"请求失败"];
        [self.mainTableView reloadData];
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
    
    if(self.shopArray.count == 0){
        
        UIView *imgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 45 - 45)];
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


#pragma mark - 获取分类列表
- (void)getClassListData
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    NSDictionary *params = @{@"merchantId":self.merchantId,@"type":@"0"};
    [QJGlobalControl sendGETWithUrl:JQXHttp_ShopClassList parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data =====   %@",data);
        if([data[@"code"] integerValue] == 200){
            
            self.classArray = data[@"data"];
            
            if(self.classArray.count == 0){
                
                UIView *imgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 45 - 35)];
                imgView.backgroundColor = RGB_COLOR(239, 239, 239);
                UIImageView *nullImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 240)/2, (SCREEN_HEIGHT - 64 - 45 - 45 - 245)/2, 240, 245)];
                nullImage.image = [UIImage imageNamed:@"NullBgImage"];
                [imgView addSubview:nullImage];
                self.mainTableView.tableFooterView = imgView;
                
            }else{
                
                self.mainTableView.tableFooterView = [UIView new];
            }

            
            
            
            [self.mainTableView reloadData];
            
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
            [self.mainTableView reloadData];
        }
        
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
        [self.mainTableView reloadData];
    }];
    
}
#pragma mark - 删除该分类
- (void)getDeleteClass
{
    NSString *idStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(self.classDic[@"id"])];
    //添加分类
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSDictionary *params = @{@"id":idStr,@"merchantid":self.merchantId,@"type":@"0"};
    [QJGlobalControl sendGETWithUrl:JQXHttp_DeleteClass parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data =====   %@",data);
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

- (NSMutableArray *)classArray
{
    if(!_classArray){
        _classArray = [NSMutableArray array];
    }
    return _classArray;
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
