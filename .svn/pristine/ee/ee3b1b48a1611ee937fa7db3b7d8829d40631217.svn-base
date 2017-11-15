//
//  RegisterAddressViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/22.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "RegisterAddressViewController.h"
#import "ShopAddressViewController.h"//门店定位
#import "RegisterPhotoViewController.h"//图片
@interface RegisterAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    RegisterView *provinceView;
    RegisterView *cityView;
    RegisterView *countyView;
    RegisterView *townView;
}
@property (nonatomic,strong)UITextField *mapLabel;//门店定位
@property (nonatomic,strong)NSString *longitudeStr;//经度
@property (nonatomic,strong)NSString *latitudeStr;//纬度
@property (nonatomic,strong)UITextField *provinceText;//省
@property (nonatomic,strong)UITextField *cityText;//市
@property (nonatomic,strong)UITextField *countryText;//县
@property (nonatomic,strong)UITextField *townText;//社区
@property (nonatomic,strong)UITableView *provinceTableView;//省的下拉框
@property (nonatomic,strong)UITableView *cityTableView;//市的下拉框
@property (nonatomic,strong)UITableView *countryTableView;//县的下拉框
@property (nonatomic,strong)UITableView *townTableView;//社区的下拉框
@property (nonatomic,strong)UITextField *detailsText;//详细地址
@property (nonatomic,strong)NSMutableArray *mainArray;//主数组
@property (nonatomic,strong)NSMutableArray *cityArray;//城市数组
@property (nonatomic,strong)NSMutableArray *countryArray;//县数组
@property (nonatomic,strong)NSMutableArray *townArray;//社区数组



@end

@implementation RegisterAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"申请商户" isBack:YES];
    [self getCityAreaListData];
    
    [self setMainUI];
}
- (void)setMainUI
{
    NSString *phoneStr = [[NSUserDefaults standardUserDefaults]objectForKey:LoginRegistphone];
    NSString *loginStr = [NSString stringWithFormat:@"登录账号 %@",phoneStr];
    UILabel *loginLabel = [JQXCustom creatLabel:CGRectMake(30,TOPALLHeight + 20, SCREEN_WIDTH - 20, 30) backColor:[UIColor clearColor] text:loginStr textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentLeft numOnLines:1];
    [self.view addSubview:loginLabel];
    
    UILabel *xingLabel = [JQXCustom creatLabel:CGRectMake(10,loginLabel.bottom + 20, 20, SCALE_HEIGHT(30)) backColor:[UIColor clearColor] text:@"*" textColor:BACKGROUNGCOLOR font:Font(13) textAlignment:NSTextAlignmentCenter numOnLines:1];
    [self.view addSubview:xingLabel];
    
    UILabel *addressLabel = [JQXCustom creatLabel:CGRectMake(30,xingLabel.top, 80, SCALE_HEIGHT(30)) backColor:[UIColor clearColor] text:@"门店地址" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
    [self.view addSubview:addressLabel];
    
    CGFloat viewWidth = (SCREEN_WIDTH - 80 - 30 - 20 - 20)/2;
    //省
    provinceView = [[RegisterView alloc]initWithFrame:CGRectMake(addressLabel.right + 10,xingLabel.top,viewWidth , SCALE_HEIGHT(30)) lineStr:@""];
    
    self.provinceText = [JQXCustom creatTextFiled:CGRectMake(0, 0, provinceView.width -SCALE_WIDTH(30), provinceView.height)  placeholder:@"省"];
    self.provinceText.textAlignment = NSTextAlignmentCenter;
    self.provinceText.userInteractionEnabled = NO;
    [provinceView addSubview:self.provinceText];
    provinceView.jButton.tag = 100;
    [provinceView.jButton addTarget:self action:@selector(provinceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:provinceView];
    
    //市
    cityView = [[RegisterView alloc]initWithFrame:CGRectMake(provinceView.right + 20,xingLabel.top,viewWidth , SCALE_HEIGHT(30)) lineStr:@""];
    
    
    self.cityText = [JQXCustom creatTextFiled:CGRectMake(0, 0, provinceView.width -SCALE_WIDTH(30), provinceView.height)  placeholder:@"市"];
    self.cityText.textAlignment = NSTextAlignmentCenter;
    self.cityText.userInteractionEnabled = NO;
    [cityView addSubview:self.cityText];
    cityView.jButton.tag = 200;
    [cityView.jButton addTarget:self action:@selector(CityAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cityView];
    
    
    //县
    countyView = [[RegisterView alloc]initWithFrame:CGRectMake(addressLabel.right + 10, provinceView.bottom + 10 ,viewWidth , SCALE_HEIGHT(30)) lineStr:@""];
    
    
    self.countryText = [JQXCustom creatTextFiled:CGRectMake(0, 0, provinceView.width -SCALE_WIDTH(30), provinceView.height)  placeholder:@"县"];
    self.countryText.textAlignment = NSTextAlignmentCenter;
    self.countryText.userInteractionEnabled = NO;
    [countyView addSubview:self.countryText];
    countyView.jButton.tag = 300;
    [countyView.jButton addTarget:self action:@selector(CountryAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:countyView];
    
    //社区
    townView = [[RegisterView alloc]initWithFrame:CGRectMake(countyView.right + 20,provinceView.bottom + 10,viewWidth , SCALE_HEIGHT(30)) lineStr:@""];
    
    self.townText = [JQXCustom creatTextFiled:CGRectMake(0, 0, provinceView.width -SCALE_WIDTH(30), provinceView.height)  placeholder:@"社区"];
    self.townText.textAlignment = NSTextAlignmentCenter;
    self.townText.userInteractionEnabled = NO;
    [townView addSubview:self.townText];
    townView.jButton.tag = 400;
    [townView.jButton addTarget:self action:@selector(TownAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:townView];

    //详细地址✨
    UILabel *xingLabel1 = [JQXCustom creatLabel:CGRectMake(10,townView.bottom + 30, 20, SCALE_HEIGHT(30)) backColor:[UIColor clearColor] text:@"*" textColor:BACKGROUNGCOLOR font:Font(13) textAlignment:NSTextAlignmentCenter numOnLines:1];
    [self.view addSubview:xingLabel1];
    
     //详细地址
    UILabel *detailsLabel = [JQXCustom creatLabel:CGRectMake(30,townView.bottom + 30, 80, SCALE_HEIGHT(30)) backColor:[UIColor clearColor] text:@"详细地址" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
    [self.view addSubview:detailsLabel];
    
    UIView *detailsView = [[UIView alloc]initWithFrame:CGRectMake(detailsLabel.right + 10, townView.bottom + 30, SCREEN_WIDTH - detailsLabel.width - 60, SCALE_HEIGHT(30))];
    detailsView.layer.borderWidth = 1;
    detailsView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
    [self.view addSubview:detailsView];
    
    self.detailsText = [JQXCustom creatTextFiled:CGRectMake(10, 0, detailsView.width - 20, detailsView.height) placeholder:@"请输入您的详细地址"];
    self.detailsText.textAlignment = NSTextAlignmentLeft;
    [detailsView addSubview:self.detailsText];
    
    //门店定位
    
    UILabel *xingLabel2 = [JQXCustom creatLabel:CGRectMake(10,detailsView.bottom + 40, 20, SCALE_HEIGHT(30)) backColor:[UIColor clearColor] text:@"*" textColor:BACKGROUNGCOLOR font:Font(13) textAlignment:NSTextAlignmentCenter numOnLines:1];
    [self.view addSubview:xingLabel2];
    
    //门店定位
    UILabel *mapTsLabel = [JQXCustom creatLabel:CGRectMake(30,detailsView.bottom + 40, 80, SCALE_HEIGHT(30)) backColor:[UIColor clearColor] text:@"门店定位" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft numOnLines:1];
    [self.view addSubview:mapTsLabel];
    
    UIImageView *mapImg = [[UIImageView alloc]initWithFrame:CGRectMake(mapTsLabel.right + 10, detailsView.bottom + 43, 23, 23)];
    mapImg.image = [UIImage imageNamed:@"positioning"];
    [self.view addSubview:mapImg];
    
    UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(mapImg.right + 10,detailsView.bottom + 40, 100, SCALE_HEIGHT(30)) backColor:[UIColor clearColor] text:@"定位  >>" textColor:[UIColor blackColor] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:1];
    [self.view addSubview:tsLabel];
    
    UIButton *mapButton = [[UIButton alloc]initWithFrame:CGRectMake(mapTsLabel.right + 10, detailsView.bottom + 40,150 , SCALE_HEIGHT(30))];
    [mapButton addTarget:self action:@selector(MapAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mapButton];
    
    UIImageView *mapImg2 = [[UIImageView alloc]initWithFrame:CGRectMake(mapTsLabel.right + 15, mapImg.bottom + 2, 9, 9)];
    mapImg2.image = [UIImage imageNamed:@"jiujiu"];
    [self.view addSubview:mapImg2];
    
    self.mapLabel = [JQXCustom creatTextFiled:CGRectMake(mapTsLabel.right + 10, mapImg2.bottom, detailsView.width, SCALE_HEIGHT(30))  placeholder:@""];
    self.mapLabel.backgroundColor = RGB_COLOR(243, 244, 245);
    self.mapLabel.textAlignment = NSTextAlignmentCenter;
    self.mapLabel.userInteractionEnabled = NO;
    [self.view addSubview:self.mapLabel];
    


    UIButton *sumbitButton = [JQXCustom creatButton:CGRectMake(60, self.mapLabel.bottom + 50 , SCREEN_WIDTH - 120, 40) backColor:BACKGROUNGCOLOR text:@"下一步" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14] addTarget:self Action:@selector(sumbitAction)];
    sumbitButton.layer.masksToBounds = YES;
    sumbitButton.layer.cornerRadius = 5;
    
    [self.view addSubview:sumbitButton];
    
}

#pragma mark - UITableViewDelegate
//indexPath.row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.provinceTableView){
        return self.mainArray.count;
    }else if (tableView == self.cityTableView){
        return self.cityArray.count;
    }else if (tableView == self.countryTableView){
        return self.countryArray.count;
    }else if (tableView == self.townTableView){
        return self.townArray.count;
    }else{
        return 10;
    }
    
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.provinceTableView){
        NSDictionary *dic = [self.mainArray objectAtIndex:indexPath.row];
        static NSString *identifer = @"provinceTableViewCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.textLabel.font = Font(12);
        cell.textLabel.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"areaName"])];
        return cell;
    }else if(tableView == self.cityTableView){
        NSDictionary *dic = [self.cityArray objectAtIndex:indexPath.row];
        static NSString *identifer = @"cityTableViewCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.textLabel.font = Font(12);
        cell.textLabel.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"areaName"])];
        return cell;
        
    }else if(tableView == self.countryTableView){
        NSDictionary *dic = [self.countryArray objectAtIndex:indexPath.row];
        static NSString *identifer = @"countryTableViewCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.textLabel.font = Font(12);
        cell.textLabel.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"areaName"])];
        return cell;
    }else{
        NSDictionary *dic = [self.townArray objectAtIndex:indexPath.row];
        static NSString *identifer = @"townTableViewCellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.textLabel.font = Font(12);
        cell.textLabel.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"townName"])];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.provinceTableView){
        NSDictionary *dic = [self.mainArray objectAtIndex:indexPath.row];
        if(self.cityArray.count > 0){
            [self.cityArray removeAllObjects];
        }
        self.cityArray = [NSMutableArray arrayWithArray:dic[@"cities"]];
        self.provinceTableView.hidden = YES;
        provinceView.jButton.tag = 100;
        self.provinceText.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"areaName"])];
        [self.cityTableView reloadData];
        //添加到字典中留着注册使用
        NSString *areaID = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"areaId"])];
        [self.registerDic setValue:areaID forKey:@"provinceId"];
        
        self.cityText.text = @"";
        self.countryText.text = @"";
        self.townText.text = @"";
        
    }else if(tableView == self.cityTableView){
        NSDictionary *dic = [self.cityArray objectAtIndex:indexPath.row];
        if(self.countryArray.count > 0){
            [self.countryArray removeAllObjects];
        }
        self.countryArray = [NSMutableArray arrayWithArray:dic[@"counties"]];
        self.cityTableView.hidden = YES;
        cityView.jButton.tag = 200;
        self.cityText.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"areaName"])];
        [self.countryTableView reloadData];
        
        //添加到字典中留着注册使用
        NSString *areaID = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"areaId"])];
        [self.registerDic setValue:areaID forKey:@"cityId"];
        self.countryText.text = @"";
        self.townText.text = @"";
        
    }else if(tableView == self.countryTableView){
        NSDictionary *dic = [self.countryArray objectAtIndex:indexPath.row];
        self.countryTableView.hidden = YES;
        countyView.jButton.tag = 300;
        self.countryText.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"areaName"])];
        NSString *countryID = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"areaId"])];
        [self getAreaListData:countryID];
        
        //添加到字典中留着注册使用
        [self.registerDic setValue:countryID forKey:@"countyId"];
        self.townText.text = @"";
        
    }else{
        NSDictionary *dic = [self.townArray objectAtIndex:indexPath.row];
        self.townTableView.hidden = YES;
        townView.jButton.tag = 400;
        self.townText.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"townName"])];
        
        //添加到字典中留着注册使用
        NSString *ID = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"id"])];
        NSNumber *longNumberPo = [NSNumber numberWithLong:[ID longLongValue]];
        NSString *longStrPo = [longNumberPo stringValue];
        [self.registerDic setValue:longStrPo forKey:@"positionId"];
        
        NSString *townID = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"townId"])];

        NSNumber *longNumberT = [NSNumber numberWithLong:[townID longLongValue]];
        NSString *longStrT = [longNumberT stringValue];
        [self.registerDic setValue:longStrT forKey:@"townId"];
    }
}

#pragma mark - 省的按钮点击事件
- (void)provinceAction:(UIButton *)sender
{
    self.cityTableView.hidden = YES;
    cityView.jButton.tag = 200;
    self.countryTableView.hidden = YES;
    countyView.jButton.tag = 300;
    self.townTableView.hidden = YES;
    townView.jButton.tag = 400;
    
    switch (sender.tag) {
        case 100:
            self.provinceTableView.hidden = NO;
            provinceView.jButton.tag = 101;
            break;
        case 101:
            self.provinceTableView.hidden = YES;
            provinceView.jButton.tag = 100;
            break;
        default:
            break;
    }
}
#pragma mark - 市的按钮点击事件
- (void)CityAction:(UIButton *)sender
{
    self.provinceTableView.hidden = YES;
    provinceView.jButton.tag = 100;
    self.countryTableView.hidden = YES;
    countyView.jButton.tag = 300;
    self.townTableView.hidden = YES;
    townView.jButton.tag = 400;
    
    if(self.provinceText.text.length == 0){
        [ALToastView toastInView:self.view withText:@"请先选择省"];
    }else{
        switch (sender.tag) {
            case 200:
                self.cityTableView.hidden = NO;
                cityView.jButton.tag = 201;
                break;
            case 201:
                self.cityTableView.hidden = YES;
                cityView.jButton.tag = 200;
                break;
            default:
                break;
        }

    }
    
    
   
    
}
#pragma mark - 县的按钮点击事件
- (void)CountryAction:(UIButton *)sender
{
    self.provinceTableView.hidden = YES;
    provinceView.jButton.tag = 100;
    self.cityTableView.hidden = YES;
    cityView.jButton.tag = 200;
    self.townTableView.hidden = YES;
    townView.jButton.tag = 400;
    
    if(self.provinceText.text.length == 0){
        [ALToastView toastInView:self.view withText:@"请先选择省"];
    }else if (self.cityText.text.length == 0){
        [ALToastView toastInView:self.view withText:@"请先选择市"];
    }else{
        switch (sender.tag) {
            case 300:
                self.countryTableView.hidden = NO;
                countyView.jButton.tag = 301;
                break;
            case 301:
                self.countryTableView.hidden = YES;
                countyView.jButton.tag = 300;
                break;
            default:
                break;
        }

        
    }
    
}

#pragma mark - 社区的按钮点击事件
- (void)TownAction:(UIButton *)sender
{
    self.provinceTableView.hidden = YES;
    provinceView.jButton.tag = 100;
    self.cityTableView.hidden = YES;
    cityView.jButton.tag = 200;
    self.countryTableView.hidden = YES;
    countyView.jButton.tag = 300;
    
    if(self.provinceText.text.length == 0){
        [ALToastView toastInView:self.view withText:@"请先选择省"];
    }else if (self.cityText.text.length == 0){
        [ALToastView toastInView:self.view withText:@"请先选择市"];
    }else if (self.countryText.text.length == 0){
        [ALToastView toastInView:self.view withText:@"请先选择县"];
    }else{
        switch (sender.tag) {
            case 400:
                self.townTableView.hidden = NO;
                townView.jButton.tag = 401;
                break;
            case 401:
                self.townTableView.hidden = YES;
                townView.jButton.tag = 400;
                break;
            default:
                break;
        }

    }
    
}


#pragma mark - 门店定位
- (void)MapAction
{
    [self.view endEditing:YES];
    ShopAddressViewController *shopVC = [[ShopAddressViewController alloc]init];
    shopVC.styleStr = @"不保存";
    [shopVC messageText:^(NSMutableDictionary *messageDic) {
        NSString *mapStr = [NSString stringWithFormat:@"%@",messageDic[@"name"]];
        if([mapStr isEqualToString:@"(null)"]){
            mapStr = @"";
        }
        self.mapLabel.text = mapStr;
        self.longitudeStr = [NSString stringWithFormat:@"%@",messageDic[@"longitude"]];
        self.latitudeStr = [NSString stringWithFormat:@"%@",messageDic[@"latitude"]];
        
        //经度
        [self.registerDic setValue:self.longitudeStr forKey:@"longitude"];
        //纬度
        [self.registerDic setValue:self.latitudeStr forKey:@"latitude"];
    }];
    [self.navigationController pushViewController:shopVC animated:YES];
}
#pragma mark - 下一步
- (void)sumbitAction
{
    [self.view endEditing:YES];
    if(self.provinceText.text.length == 0 || self.cityText.text.length == 0 ||self.countryText.text.length == 0 || self.townText.text.length == 0 ||self.detailsText.text.length == 0 ||self.mapLabel.text.length == 0){

        [ALToastView toastInView:self.view withText:@"信息不全，请补充"];

    }else if([[self.detailsText.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0){
         [ALToastView toastInView:self.view withText:@"请输入正确信息"];
    } else{
        //详细地址
        BOOL special = [QJGlobalControl isIncludeSpecialCharact:self.detailsText.text];
        if(special){
            [ALToastView toastInView:self.view withText:@"不可以输入特殊字符"];
        }else{
            [self.registerDic setValue:self.detailsText.text forKey:@"address"];
            
            RegisterPhotoViewController *vc = [[RegisterPhotoViewController alloc]init];
            vc.registerDic = self.registerDic;
            [self.navigationController pushViewController:vc animated:YES];
        }

    }

    
}

- (UITableView *)provinceTableView
{
    if(!_provinceTableView){
        _provinceTableView = [[UITableView alloc]initWithFrame:CGRectMake(provinceView.left, provinceView.bottom, provinceView.width, SCALE_HEIGHT(100)) style:UITableViewStylePlain];
        _provinceTableView.layer.borderWidth = 1;
        _provinceTableView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
        _provinceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _provinceTableView.delegate = self;
        _provinceTableView.dataSource = self;
        _provinceTableView.tableFooterView = [UIView new];
        [self.view addSubview:_provinceTableView];
    }
    return _provinceTableView;
}
- (UITableView *)cityTableView
{
    if(!_cityTableView){
        _cityTableView = [[UITableView alloc]initWithFrame:CGRectMake(cityView.left, cityView.bottom, cityView.width, SCALE_HEIGHT(100)) style:UITableViewStylePlain];
        _cityTableView.layer.borderWidth = 1;
        _cityTableView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
        _cityTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;
        _cityTableView.tableFooterView = [UIView new];
        [self.view addSubview:_cityTableView];
    }
    return _cityTableView;
}
- (UITableView *)countryTableView
{
    if(!_countryTableView){
        _countryTableView = [[UITableView alloc]initWithFrame:CGRectMake(countyView.left, countyView.bottom, countyView.width, SCALE_HEIGHT(100)) style:UITableViewStylePlain];
        _countryTableView.layer.borderWidth = 1;
        _countryTableView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
        _countryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _countryTableView.delegate = self;
        _countryTableView.dataSource = self;
        _countryTableView.tableFooterView = [UIView new];
        [self.view addSubview:_countryTableView];
    }
    return _countryTableView;
}
- (UITableView *)townTableView
{
    if(!_townTableView){
        _townTableView = [[UITableView alloc]initWithFrame:CGRectMake(townView.left, townView.bottom, townView.width, SCALE_HEIGHT(100)) style:UITableViewStylePlain];
        _townTableView.layer.borderWidth = 1;
        _townTableView.layer.borderColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f].CGColor;
        _townTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _townTableView.delegate = self;
        _townTableView.dataSource = self;
        _townTableView.tableFooterView = [UIView new];
        [self.view addSubview:_townTableView];
    }
    return _townTableView;
}
#pragma mark - 点击空白处
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.provinceTableView.hidden = YES;
    provinceView.jButton.tag = 100;
    self.cityTableView.hidden = YES;
    cityView.jButton.tag = 200;
    self.countryTableView.hidden = YES;
    countyView.jButton.tag = 300;
    self.townTableView.hidden = YES;
    townView.jButton.tag = 400;
    //点击空白收起键盘
    [self.view endEditing:YES];
}


#pragma mark - 获取三级联动信息
- (void)getCityAreaListData{
    //http_CityList   https://api-merchant.phds315.com/position/getMerchantAppCounty
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendGETWithUrl:http_CityList parameters:nil success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"]integerValue] == 200){
//            NSLog(@"%@",data);
            self.mainArray = [NSMutableArray arrayWithArray:data[@"data"]];
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}

#pragma mark - 获取区域列表
- (void)getAreaListData:(NSString *)countyCodeID
{
    //http_AreaList   https://api-merchant.phds315.com/position/getTownsByCountyCode
    NSString *url = [NSString stringWithFormat:@"%@/%@",http_AreaList,countyCodeID];
    [QJGlobalControl sendGETWithUrl:url parameters:nil success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"]integerValue] == 200){
            if(self.townArray.count != 0){
                [self.townArray removeAllObjects];
            }
            self.townArray = [NSMutableArray arrayWithArray:data[@"data"]];
            [self.townTableView reloadData];
            
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
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
- (NSMutableArray *)cityArray
{
    if(!_cityArray){
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}
- (NSMutableArray *)countryArray
{
    if(!_countryArray){
        _countryArray = [NSMutableArray array];
    }
    return _countryArray;
}
- (NSMutableArray *)townArray
{
    if(!_townArray){
        _townArray = [NSMutableArray array];
    }
    return _townArray;
}
- (NSMutableDictionary *)registerDic
{
    if(!_registerDic){
        _registerDic = [NSMutableDictionary dictionary];
    }
    return _registerDic;
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
