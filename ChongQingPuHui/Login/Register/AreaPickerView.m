//
//  AreaPickerView.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/26.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "AreaPickerView.h"
@interface AreaPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,strong)NSMutableArray *areaList;
@property (nonatomic,strong)NSMutableDictionary *selectedDic;

@end
@implementation AreaPickerView

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
    self.areaList = mainArray;
    //默认选中的是第一个
    [self.selectedDic setValue:[self.areaList objectAtIndex:0] forKey:@"town"];
    
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
    return 1;
}
// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        return [self.areaList count];
        
    }
    
    return 0;
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return self.width - 40;
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        
        NSDictionary *dic = [self.areaList objectAtIndex:row];
        [self.selectedDic setValue:dic forKey:@"town"];
        return NULL_TO_NIL(dic[@"townName"]);
        
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AreaPickerViewSure" object:nil userInfo:self.selectedDic];
}


- (NSMutableArray *)areaList
{
    if(!_areaList){
        _areaList = [NSMutableArray array];
    }
    return _areaList;
}
- (NSMutableDictionary *)selectedDic
{
    if(!_selectedDic){
        _selectedDic = [NSMutableDictionary dictionary];
    }
    return _selectedDic;
}


@end
