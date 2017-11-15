//
//  BuyTimeViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/9/25.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "BuyTimeViewController.h"
#import "BuyTimeTableViewCell.h"
#import "DateTimePickerView.h"
@interface BuyTimeViewController ()<UITableViewDelegate,UITableViewDataSource,ButtonClassDelegate,DateTimePickerViewDelegate>
{
    NSInteger customSection;
    NSInteger customRow;
    NSString *styleStr;
}
@property (nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)NSMutableArray *mainArray;
@property (nonatomic,strong)DateTimePickerView *pickerView;
@property (nonatomic,strong)NSArray *fixedArray;
@property (nonatomic,strong)UIButton *sumbitButton;
@end

@implementation BuyTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"消费时段" isBack:NO];
    [self.view addSubview:self.mainTableView];
    [self FindDissipate];
    [self setNAVBackButton];
    
}
- (void)setNAVBackButton
{
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 11, 22, 22)];
    backImg.image = [UIImage imageNamed:@"nav_icon"];
    [self.navBarView addSubview:backImg];
    
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBut setFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, NAVHeight)];
    [backBut addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView addSubview:backBut];
}
- (void)backButtonAction
{
    int changeInt = [self editArray:self.mainArray];;
    if(changeInt == 2){
        [UIAlertView alertViewTitle:@"提示" message:@"还未保存，确认要离开么" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定"];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
   
}
 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
     
     if(buttonIndex == 1){
         [self.navigationController popViewControllerAnimated:YES];
     }
 }

#pragma mark - 查询用户消费时段
- (void)FindDissipate
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSDictionary *params = @{@"merchantId":self.merchantId};
    [QJGlobalControl sendGETWithUrl:JQXHttp_TableFindDissipate parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"🍉🍉data =====   %@",data);
        if([data[@"code"] integerValue] == 200){
            NSMutableArray *array = [NSMutableArray arrayWithArray:data[@"data"]];
            self.mainArray = array;
            self.fixedArray = data[@"data"];
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        [self.mainTableView reloadData];
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//indexPath.row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    }else{
        return self.mainArray.count - 1;
    }
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        static NSString *identifer = @"BuyTimeTableViewCellID";
        BuyTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(cell == nil){
            cell = [[BuyTimeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
       [cell addSubview:cell.addButton];
        cell.ButtonDelegate = self;
        if(self.mainArray.count !=0){
            NSDictionary *dic = [self.mainArray objectAtIndex:0];
            [cell setData:dic];
        }
        return cell;
        
    }else{
        static NSString *identifer = @"BuyTimeTableViewCellID2";
        BuyTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if(cell == nil){
            cell = [[BuyTimeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.ButtonDelegate = self;
        
        if(self.mainArray.count > 0){
            NSDictionary *dic = [self.mainArray objectAtIndex:indexPath.row + 1];
            [cell setData:dic];
        }
        
        [cell addSubview:cell.deleteButton];
        return cell;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - 点击开始时间
- (void)StartTimeClassSure:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    customSection = indexPath.section;
    customRow = indexPath.row;
    styleStr = @"开始时间";
    self.pickerView = [[DateTimePickerView alloc] init];
    self.pickerView.titleL.text = @"请选择时间";
    self.pickerView.delegate = self;
    self.pickerView.pickerViewMode = DatePickerViewTimeMode;
    [self.view addSubview:self.pickerView];
    [self.pickerView showDateTimePickerView];
}
#pragma mark - 点击结束时间
- (void)EndTimeTimeClassSure:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    customSection = indexPath.section;
    customRow = indexPath.row;
    styleStr = @"结束时间";
    self.pickerView = [[DateTimePickerView alloc] init];
    self.pickerView.titleL.text = @"请选择时间";
    self.pickerView.delegate = self;
    self.pickerView.pickerViewMode = DatePickerViewTimeMode;
    [self.view addSubview:self.pickerView];
    [self.pickerView showDateTimePickerView];
}
#pragma mark - 选择的时间
- (void)didClickFinishDateTimePickerView:(NSString *)date{
   
    if([styleStr isEqualToString:@"开始时间"]){
        if(customSection == 0){
            
            if(self.mainArray.count ==0){
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"startTime":date}];
                [self.mainArray addObject:dic];
                
            }else{
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.mainArray objectAtIndex:0]];
                
                //判断开始时间是否小于结束时间
                NSString *endTime = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"endTime"])];
                if([endTime isEqualToString:@"(null)"]){
                    endTime = @"23:59";
                }
                int timeResult = [self compareOneDay:date withAnotherDay:endTime];
                NSLog(@"🍊%d",timeResult);
                if(timeResult == -1){
                    [dic setObject:date forKey:@"startTime"];
                    [self.mainArray replaceObjectAtIndex:0 withObject:dic];
                }else{
                    [ALToastView toastInView:self.view withText:@"开始时间不得大于结束时间"];
                }
                
            }
            
        }else{
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.mainArray objectAtIndex:customRow + 1]];
            //判断开始时间是否小于结束时间
            NSString *endTime = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"endTime"])];
            if([endTime isEqualToString:@"(null)"]){
                endTime = @"23:59";
            }
            int timeResult = [self compareOneDay:date withAnotherDay:endTime];
            NSLog(@"🍊%d",timeResult);
            if(timeResult == -1){
                //判断该时间是否在某个时间段内
                int timeSlotint = [self compareOneDay:date withArray:self.mainArray Row:customRow + 1];
                if(timeSlotint == 2){
                    //判断开始时间是否小于开始时间
                    int startInt = [self compareDaywithArray:self.mainArray withDic:dic day:date styleStr:@"开始时间" Row:customRow + 1];
                    if(startInt == 2){
                        [dic setObject:date forKey:@"startTime"];
                        [self.mainArray replaceObjectAtIndex:customRow + 1 withObject:dic];
                    }else{
                        [ALToastView toastInView:self.view withText:@"时间不可重复，请重新选择"];
                    }

                }else{
                    [ALToastView toastInView:self.view withText:@"时间不可重复，请重新选择"];
                }
 
            }else{
                [ALToastView toastInView:self.view withText:@"开始时间不得大于结束时间"];
            }
 
        }
    }else if([styleStr isEqualToString:@"结束时间"]){
        
        if(customSection == 0){
            
            if(self.mainArray.count ==0){
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"endTime":date}];
                [self.mainArray addObject:dic];
            }else{
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.mainArray objectAtIndex:0]];
                
                
                //判断结束时间要大于开始时间
                NSString *startTime = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"startTime"])];
                if([startTime isEqualToString:@"(null)"]){
                    startTime = @"00:00";
                }
                int timeResult = [self compareOneDay:date withAnotherDay:startTime];
                NSLog(@"🍊%d",timeResult);
                if(timeResult == 1){
                    [dic setObject:date forKey:@"endTime"];
                    [self.mainArray replaceObjectAtIndex:0 withObject:dic];
                }else{
                    [ALToastView toastInView:self.view withText:@"结束时间要大于开始时间"];
                }
                
            }
        }else{
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[self.mainArray objectAtIndex:customRow + 1]];
            
            //判断结束时间要大于开始时间
            NSString *startTime = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"startTime"])];
            if([startTime isEqualToString:@"(null)"]){
                startTime = @"00:00";
            }
            int timeResult = [self compareOneDay:date withAnotherDay:startTime];
            NSLog(@"🍊%d",timeResult);
            if(timeResult == 1){

                //判断该时间是否在某个时间段内
                int timeSlotint = [self compareOneDay:date withArray:self.mainArray Row:customRow + 1];
                if(timeSlotint == 2){
                    //判断结束时间是否大于结束时间
                    int endInt = [self compareDaywithArray:self.mainArray withDic:dic day:date styleStr:@"结束时间" Row:customRow + 1];
                    if(endInt == 2){
                        [dic setObject:date forKey:@"endTime"];
                        [self.mainArray replaceObjectAtIndex:customRow + 1 withObject:dic];
                    }else{
                        [ALToastView toastInView:self.view withText:@"时间不可重复，请重新选择"];
                    }
   
                }else{
                    [ALToastView toastInView:self.view withText:@"时间不可重复，请重新选择"];
                }
                
            }else{
                [ALToastView toastInView:self.view withText:@"结束时间要大于开始时间"];
            }
            
        }
        
    }
    
    int changeInt = [self editArray:self.mainArray];;
    if(changeInt == 2){
        self.sumbitButton.backgroundColor =BACKGROUNGCOLOR;
        self.sumbitButton.userInteractionEnabled = YES;
    }else{
        self.sumbitButton.backgroundColor =RGB_COLOR(221, 221, 221);
        self.sumbitButton.userInteractionEnabled = NO;
    }
    
    
    [self.mainTableView reloadData];
    
}
#pragma mark - 添加
- (void)AddClassSure:(UITableViewCell *)cell
{
    NSDictionary *dic = @{};
    [self.mainArray addObject:dic];
    [self.mainTableView reloadData];
}
#pragma mark - 删除
- (void)DeleteClassSure:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
//    NSDictionary *dic = [self.mainArray objectAtIndex:indexPath.row + 1];
//    [self deleteCellData:dic removeCell:indexPath.row + 1];
    [self.mainArray removeObjectAtIndex:indexPath.row + 1];
    int changeInt = [self editArray:self.mainArray];;
    if(changeInt == 2){
        self.sumbitButton.backgroundColor =BACKGROUNGCOLOR;
        self.sumbitButton.userInteractionEnabled = YES;
    }else{
        self.sumbitButton.backgroundColor =RGB_COLOR(221, 221, 221);
        self.sumbitButton.userInteractionEnabled = NO;
    }
    
    [self.mainTableView reloadData];
}
//#pragma mark - 删除按钮点击事件
//- (void)deleteCellData:(NSDictionary *)dic removeCell:(NSInteger)index{
//
//    [JHHJView showLoadingOnTheKeyWindowWithType:2];
//    NSString *timeId = [NSString stringWithFormat:@"%@",dic[@"id"]];
//    NSDictionary *param = @{@"id":timeId};
//    [QJGlobalControl sendGETWithUrl:JQXHttp_TableDeleteDissipate parameters:param success:^(id data) {
//        [JHHJView hideLoading];
//        if([data[@"code"] integerValue] == 200){
//            [self.mainArray removeObjectAtIndex:index];
//             [self.mainTableView reloadData];
//        }else{
//             [ALToastView toastInView:self.view withText:data[@"message"]];
//        }
//
//    } fail:^(NSError *error) {
//        [JHHJView hideLoading];
//        [ALToastView toastInView:self.view withText:@"请求失败"];
//    }];
//
//}

#pragma mark - 保存按钮点击事件
- (void)SumbitAction
{
    NSMutableArray *startTimeArray = [NSMutableArray array];
    NSMutableArray *endTimeArray = [NSMutableArray array];
    NSString *styleStr = @"完整时间段";
    for (int i = 0; i < self.mainArray.count; i ++) {
        NSDictionary *dic = [self.mainArray objectAtIndex:i];
        NSString *startTime = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"startTime"])];
        NSString *endTime = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"endTime"])];
        
        if(![dic objectForKey:@"startTime"]){
            styleStr = @"非完整时间段";
        }
        
        if(![dic objectForKey:@"endTime"]){
            styleStr = @"非完整时间段";
        }
        
        [startTimeArray addObject:startTime];
        [endTimeArray addObject:endTime];
        
    }
    
    if([styleStr isEqualToString:@"非完整时间段"]){
        [ALToastView toastInView:self.view withText:@"请填写完整时间段"];
        
    }else{
        [JHHJView showLoadingOnTheKeyWindowWithType:2];
        NSString *startText = [startTimeArray componentsJoinedByString:@","];
        NSString *endText = [endTimeArray componentsJoinedByString:@","];
        
        NSDictionary *params = @{@"merchantId":self.merchantId,@"startTime":startText,@"endTime":endText};
        [QJGlobalControl sendGETWithUrl:JQXHttp_TableNewDissipate parameters:params success:^(id data) {
            [JHHJView hideLoading];
            NSLog(@"🍉🍉data =====   %@",data);
            if([data[@"code"] integerValue] == 200){
                [ALToastView toastInView:self.view withText:data[@"message"]];
                self.fixedArray = self.mainArray;
                self.sumbitButton.backgroundColor =RGB_COLOR(221, 221, 221);
                self.sumbitButton.userInteractionEnabled = NO;
                
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
    }
}

- (UITableView *)mainTableView
{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarView.bottom) style:UITableViewStylePlain];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        headerView.backgroundColor = [UIColor whiteColor];
        
        UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(20, 30, 200, 20) backColor:[UIColor clearColor] text:@"每日消费时段：" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentLeft numOnLines:0];
        [headerView addSubview:tsLabel];
        _mainTableView.tableHeaderView = headerView;
        
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        footerView.backgroundColor = [UIColor whiteColor];
        self.sumbitButton = [JQXCustom creatButton:CGRectMake(60, 20 , SCREEN_WIDTH - 120, 40) backColor:RGB_COLOR(221, 221, 221) text:@"保存" textColor:[UIColor whiteColor] font:Font(14) addTarget:self Action:@selector(SumbitAction)];
        self.sumbitButton.layer.masksToBounds = YES;
        self.sumbitButton.layer.cornerRadius = 5;
        self.sumbitButton.userInteractionEnabled = NO;
        [footerView addSubview:self.sumbitButton];

        _mainTableView.tableFooterView = footerView;
        
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
#pragma mark - 判断开始时间不得结束时间
-(int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay
{

    NSComparisonResult result = [oneDay compare:anotherDay];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result ==NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
        
    }else{
        //NSLog(@"Both dates are the same");
        return 0;
    }
 
}
#pragma mark - 时间不得在某个时间段内
- (int)compareOneDay:(NSString *)oneDay withArray:(NSMutableArray *)array Row:(NSInteger)rows
{
    
    int timeSlot = 2;  //正常
    
    for (int i = 0; i< array.count; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        
        if(rows != i){
            NSString *startTime = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"startTime"])];
            
            NSString *endTime = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"endTime"])];
            
            NSComparisonResult result = [oneDay compare:startTime];
            NSComparisonResult result1 = [oneDay compare:endTime];
            
            //        if(![startTime isEqualToString:@"(null)"]){
            //当开始时间或者结束时间在某个时间段内
            //NSOrderedDescending  NSOrderedAscending
            if(result == NSOrderedDescending && result1 == NSOrderedAscending){
                timeSlot = 1;
            }
//            else if (result == NSOrderedSame || result1 == NSOrderedSame){
//                timeSlot = 1;
//            }
            //        }
            
        }
        
        
    }
    return timeSlot;
}
#pragma mark - 当开始时间小于开始时间 结束时间大于结束时间
- (int)compareDaywithArray:(NSMutableArray *)array withDic:(NSMutableDictionary *)dic day:(NSString *)oneDay styleStr:(NSString *)styleStr1 Row:(NSInteger)rows
{
    
    int timeSlot = 2;  //正常
    NSString *startTime = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"startTime"])];
    NSString *endTime = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"endTime"])];
    
    if([styleStr1 isEqualToString:@"开始时间"]){
        if([startTime isEqualToString:@"(null)"]){
            startTime = oneDay;
        }
    }else{
        if([endTime isEqualToString:@"(null)"]){
            endTime = oneDay;
        }
    }
    
    for (int i = 0; i< array.count; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        NSString *startSmallTime = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dict[@"startTime"])];
        NSString *endSmallTime = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dict[@"endTime"])];
        
        NSComparisonResult result = [startSmallTime compare:startTime];
        NSComparisonResult result1 = [endSmallTime compare:endTime];
        
        if(rows != i){
            if(![startTime isEqualToString:@"(null)"] && ![endTime isEqualToString:@"(null)"]){
                //当开始时间小于开始时间并且结束时间大于结束时间
                if(result == NSOrderedDescending && result1 == NSOrderedAscending){
                    timeSlot = 1;
                }else if(result == NSOrderedSame && result1 == NSOrderedSame){
                    timeSlot = 1;
                }else if(result == NSOrderedDescending && result1 == NSOrderedSame){
                    timeSlot = 1;
                }else if(result == NSOrderedSame && result1 == NSOrderedAscending){
                    timeSlot = 1;
                }
            }
        }
 
    }

     return timeSlot;
}
//判断两个数组是否一样
- (int)editArray:(NSMutableArray *)array1
{
    int change = 1;//正常
    
    if(self.fixedArray.count == array1.count){
        for (int i = 0; i < self.fixedArray.count; i++) {
            NSDictionary *dic = [self.fixedArray objectAtIndex:i];
            BOOL isbool = [array1 containsObject:dic];
            //isbool是1的时候就代表数组中有这个字典 0就是没有
            if(isbool == 0){
                change = 2;
            }
        }
    }else{
        change = 2;
    }
    return change;
}
- (NSArray *)fixedArray
{
    if(!_fixedArray){
        _fixedArray = [NSArray array];
    }
    return _fixedArray;
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
