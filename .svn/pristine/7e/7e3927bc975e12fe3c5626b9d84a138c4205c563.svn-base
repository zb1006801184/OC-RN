//
//  ShopAddressViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/24.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "ShopAddressViewController.h"
#import "ShopAddressCell.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface ShopAddressViewController ()<AMapLocationManagerDelegate,MAMapViewDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)AMapLocationManager *locationManager;

@property (nonatomic,strong)MAMapView *mapView;

@property (nonatomic,strong)AMapSearchAPI *search;

@property (nonatomic,strong)NSMutableArray *dataArray;      //结果数组

@property (nonatomic,strong)UITableView *listTableview;     // 结果列表
@property (nonatomic) NSInteger selectedIndex;//选择的是哪个
@property (nonatomic,strong) NSString *selectedName;//选择的名称
@property (nonatomic,strong) NSString *selectedAddress;//选择的地址
@property (nonatomic,strong) NSString *longitudeStr;//经度
@property (nonatomic,strong) NSString *latitudeStr;//纬度
@property (nonatomic,strong) NSMutableDictionary *messageDic;



@end

@implementation ShopAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"门店地址" isBack:NO];
    [self setLeftNavButton];
    if([self.styleStr isEqualToString:@"保存"]){
        [self setRightButton];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ///初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH,(SCREEN_HEIGHT - self.navBarView.bottom)/2)];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    [self.mapView setZoomLevel:17.5 animated:YES];
    
    ///把地图添加至view
    [self.view addSubview:self.mapView];
    
    [self addImage];
    
    [self.view addSubview:self.listTableview];
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;

    self.selectedIndex = 0;
    
    
   
}
//block语句传值
- (void)messageText:(MessageBlock)block
{
    self.block = block;
}

//添加中心点图 和 右下角当前位置按钮
-(void)addImage{
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_55"]];
    image.frame = CGRectMake((SCREEN_WIDTH - 13) / 2, (self.mapView.height - 29) / 2 - 5, 13, 29);
    [self.mapView addSubview:image];
    
    UIButton *backCenter = [UIButton buttonWithType:UIButtonTypeCustom];
    backCenter.frame = CGRectMake(SCREEN_WIDTH - 40, self.mapView.height - 40, 36, 36);
    [backCenter setImage:[UIImage imageNamed:@"icon_loca"] forState:UIControlStateNormal];
    [backCenter addTarget:self action:@selector(backLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:backCenter];
    
}

#pragma mark - 返回自己的位置
- (void)backLocation
{
    
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
}



//地图拖动结束调用此方法
-(void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    [self searchAroundWithcenterCoordinate:centerCoordinate];
    
}

- (void)searchAroundWithcenterCoordinate:(CLLocationCoordinate2D )centerCoordinate{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
    request.types = @"汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施";
    request.sortrule = 0;
    request.requireExtension = YES;
    
//    NSLog(@"周边搜索");
    
    //发起周边搜索
    [self.search AMapPOIAroundSearch: request];
}

// 实现POI搜索对应的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
//    NSLog(@"周边搜索回调");
    if(response.pois.count == 0)
    {
        
        
        return;
    }
    
    self.dataArray = [NSMutableArray arrayWithArray:response.pois];
    [self.listTableview reloadData];
    
}

//=============== TableView 相关

-(UITableView *)listTableview {
    
    if (!_listTableview) {
        
        _listTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom + self.mapView.height, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarView.bottom - self.mapView.height) style:UITableViewStylePlain];
        _listTableview.delegate = self;
        _listTableview.dataSource = self;
        _listTableview.tableFooterView = [UIView new];
    }
    
    return _listTableview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (self.dataArray.count != 0) {
        
        return self.dataArray.count;
    }
    
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ImageOnRightCell";
    
    ShopAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ShopAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
    }
    
    AMapPOI *poi = self.dataArray[indexPath.row];
    
    cell.titleLabel.text = poi.name;
    
    cell.contentLabel.text = poi.address;
    [cell sureImgHidden:indexPath.row selected:self.selectedIndex];
 
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
    [self.listTableview reloadData];
    
    AMapPOI *poi = self.dataArray[indexPath.row];
    self.selectedName = [NSString stringWithFormat:@"%@",poi.name];
    self.selectedAddress = [NSString stringWithFormat:@"%@",poi.address];
    self.longitudeStr = [NSString stringWithFormat:@"%f",poi.location.longitude];
    self.latitudeStr = [NSString stringWithFormat:@"%f",poi.location.latitude];

    [self.messageDic setValue:self.selectedName forKey:@"name"];
    [self.messageDic setValue:self.longitudeStr forKey:@"longitude"];
    [self.messageDic setValue:self.latitudeStr forKey:@"latitude"];

    if(![self.styleStr isEqualToString:@"保存"]){
        
        
        if(self.block !=nil){
            self.block(self.messageDic);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma - mark - 右上角保存按钮
- (void)setRightButton
{
    UIButton *keepButton = [JQXCustom creatButton:CGRectMake(SCREEN_WIDTH - 80, 0, 80, 44) backColor:[UIColor clearColor] text:@"保存" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14] addTarget:self Action:@selector(keepAction)];
    [self.navBarView addSubview:keepButton];
}
#pragma  - mark - 保存按钮点击事件
- (void)keepAction
{
    if(self.dataArray.count != 0){
        if(self.selectedName.length == 0){
            AMapPOI *poi = self.dataArray[0];
            self.selectedName = [NSString stringWithFormat:@"%@",poi.name];
            self.selectedAddress = [NSString stringWithFormat:@"%@",poi.address];
            self.longitudeStr = [NSString stringWithFormat:@"%f",poi.location.longitude];
            self.latitudeStr = [NSString stringWithFormat:@"%f",poi.location.latitude];
        }
    }
    NSLog(@"选择的是 %@ -------- %@",self.selectedName,self.selectedAddress);
    [self keepData];
}
- (void)keepData
{
    
    if(self.selectedAddress.length != 0 && self.latitudeStr.length != 0 && self.longitudeStr.length != 0){
        [JHHJView showLoadingOnTheKeyWindowWithType:2];
        NSDictionary *params = @{@"address":self.selectedAddress,@"latitude":self.latitudeStr,@"longitude":self.longitudeStr};
        [QJGlobalControl sendPOSTWithUrl:http_ShopAddressNew parameters:params success:^(id data) {
            [JHHJView hideLoading];
            
            if([data[@"success"]intValue] == 1){
                [ALToastView toastInView:self.view withText:@"保存成功"];
                dispatch_time_t delayTime = dispatch_time
                (DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
                
                dispatch_after
                (delayTime, dispatch_get_main_queue(),
                 ^{
                     [self.navigationController popViewControllerAnimated:YES];
                     
                 }
                 );
            }else{
                [ALToastView toastInView:self.view withText:data[@"message"]];
            }
            
            
            
        } fail:^(NSError *error) {
            [JHHJView hideLoading];
            [ALToastView toastInView:self.view withText:@"请求失败"];
        }];
    }else{
        [ALToastView toastInView:self.view withText:@"地址信息不正确"];
    }
   
}


- (void)setLeftNavButton
{
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 11, 22, 22)];
    backImg.image = [UIImage imageNamed:@"nav_icon"];
    [self.navBarView addSubview:backImg];
    
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 44)];
    [backBut addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView addSubview:backBut];
}
#pragma mark - 返回按钮
- (void)backButtonAction
{
    
    if(![self.styleStr isEqualToString:@"保存"]){
        
        if(self.dataArray.count != 0){
            if(![self.messageDic objectForKey:@"name"]){
                AMapPOI *poi = self.dataArray[0];
                self.selectedName = [NSString stringWithFormat:@"%@",poi.name];
                self.selectedAddress = [NSString stringWithFormat:@"%@",poi.address];
                self.longitudeStr = [NSString stringWithFormat:@"%f",poi.location.longitude];
                self.latitudeStr = [NSString stringWithFormat:@"%f",poi.location.latitude];
                
                [self.messageDic setValue:self.selectedName forKey:@"name"];
                [self.messageDic setValue:self.longitudeStr forKey:@"longitude"];
                [self.messageDic setValue:self.latitudeStr forKey:@"latitude"];
            }
        }
        
        if(self.block !=nil){
            self.block(self.messageDic);
            
        }
    }
   
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSMutableDictionary *)messageDic
{
    if(!_messageDic){
        _messageDic = [NSMutableDictionary dictionary];
        
    }
    return _messageDic;
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
