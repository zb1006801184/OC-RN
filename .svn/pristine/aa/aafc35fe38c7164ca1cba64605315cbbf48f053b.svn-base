//
//  CityPickerView.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/26.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "CityPickerView.h"
@interface CityPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,strong)NSMutableArray *provinceList;
@property (nonatomic,strong)NSMutableArray *cityList;
@property (nonatomic,strong)NSMutableArray *countyList;
@property (nonatomic,strong)NSMutableDictionary *selectedDic;

@end

@implementation CityPickerView

- (instancetype)initWithFrame:(CGRect)frame mainArray:(NSMutableArray *)mainArray_
{
    if([super initWithFrame:frame]){
        //180
        [self setMainUI:mainArray_];
    }
    return self;
}
- (void)setMainUI:(NSMutableArray *)mainArray
{
   

    self.provinceList = mainArray;
    NSDictionary *provinceDic = [self.provinceList objectAtIndex:0];
    self.cityList = provinceDic[@"cities"];
    NSDictionary *cityDic = [self.cityList objectAtIndex:0];
    self.countyList = cityDic[@"counties"];
    
    //默认选中的是第一个
    [self.selectedDic setValue:[self.provinceList objectAtIndex:0] forKey:@"province"];
    [self.selectedDic setValue:[self.cityList objectAtIndex:0] forKey:@"city"];
    [self.selectedDic setValue:[self.countyList objectAtIndex:0] forKey:@"country"];
    
    //背景条
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10 + (self.height - 65 - 30)/2, self.width, 30)];
    img.image = [UIImage imageNamed:@"img_city"];
    [self addSubview:img];
    
    //定义pickerView
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 10, self.width - 40, self.height - 65)];
    // 显示选中框
    self.pickerView.showsSelectionIndicator=YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self addSubview:self.pickerView];
    
    //取消按钮
    UIButton *cancleButton = [JQXCustom creatButton:CGRectMake(20, self.height - 55, 60, 35) backColor:BACKGROUNGCOLOR text:@"取消" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:13] addTarget:self Action:@selector(cancleAction)];
    cancleButton.layer.masksToBounds = YES;
    cancleButton.layer.cornerRadius = 5;
    [self addSubview:cancleButton];
    
    //确定按钮
    UIButton *sureButton = [JQXCustom creatButton:CGRectMake(self.width - 20 - 60, self.height - 55, 60, 35) backColor:BACKGROUNGCOLOR text:@"确定" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14] addTarget:self Action:@selector(sureAction)];
    sureButton.layer.masksToBounds = YES;
    sureButton.layer.cornerRadius = 5;
    [self addSubview:sureButton];
}

// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        return [self.provinceList count];
        
    }else if(component == 1){
        
        return [self.cityList count];
        
    }else if (component == 2){
        
        if(self.countyList.count != 0){
            
            return [self.countyList count];
        }
    }
    
    return 0;
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return (self.width - 40)/3;
}


// 滑动哪行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        
        NSDictionary *provinceDic = [self.provinceList objectAtIndex:row];
        self.cityList = provinceDic[@"cities"];
        NSDictionary *cityDic = [self.cityList objectAtIndex:0];
        self.countyList = cityDic[@"counties"];
        [self.pickerView reloadAllComponents];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        
    } else if(component == 1){
        
        NSDictionary *cityDic = [self.cityList objectAtIndex:row];
        self.countyList = cityDic[@"counties"];
        [self.pickerView reloadAllComponents];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
    }
    
}
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        
        NSDictionary *dic = [self.provinceList objectAtIndex:row];
        [self.selectedDic setValue:dic forKey:@"province"];
        return NULL_TO_NIL(dic[@"areaName"]);
        
    }else if(component == 1){
        
        NSDictionary *dic = [self.cityList objectAtIndex:row];
        [self.selectedDic setValue:dic forKey:@"city"];
        [self.selectedDic setValue:[self.countyList objectAtIndex:0] forKey:@"country"];
        return NULL_TO_NIL(dic[@"areaName"]);
        
        
    }else if (component == 2){
        
        NSDictionary *dic = [self.countyList objectAtIndex:row];
         [self.selectedDic setValue:dic forKey:@"country"];
        return NULL_TO_NIL(dic[@"areaName"]);
        
    }else{
        return 0;
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15]];
    }
    // Fill the label text here
    
    
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - 取消
- (void)cancleAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PickerViewCancle" object:nil userInfo:nil];
}
#pragma mark - 确定
- (void)sureAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PickerViewSure" object:nil userInfo:self.selectedDic];
    
}


- (NSMutableArray *)provinceList
{
    if(!_provinceList){
        _provinceList = [NSMutableArray array];
    }
    return _provinceList;
}
- (NSMutableArray *)cityList
{
    if(!_cityList){
        _cityList = [NSMutableArray array];
    }
    return _cityList;
}
- (NSMutableArray *)countyList
{
    if(!_countyList){
        _countyList = [NSMutableArray array];
    }
    return _countyList;
}
- (NSMutableDictionary *)selectedDic
{
    if(!_selectedDic){
        _selectedDic = [NSMutableDictionary dictionary];
    }
    return _selectedDic;
}

@end
