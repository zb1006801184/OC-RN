//
//  ClassView.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/27.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "ClassView.h"
#import "JQXButton.h"
@interface ClassView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,strong)NSMutableArray *classList;
@property (nonatomic,strong)NSMutableArray *childrenList;
//allArray 是 pickerView滚动就会把选中的存起来（点击选择按钮的时候选择的是最后一个添加到endArray 里面）
@property (nonatomic,strong)NSMutableDictionary *selectedDic;
@property (nonatomic,strong)NSMutableArray *endArray;//最终选择的行业分类
@property (nonatomic,strong)UIView *redView;

@end
@implementation ClassView

- (instancetype)initWithFrame:(CGRect)frame mainArray:(NSMutableArray *)mainArray_ selectedArray:(NSMutableArray *)selecterArr
{
    if([super initWithFrame:frame]){
        //180
        [self setMainUI:mainArray_ selectArr:selecterArr];
    }
    return self;
}

- (void)setMainUI:(NSMutableArray *)mainArray selectArr:(NSMutableArray *)arr
{
    self.classList = mainArray;
    NSDictionary *classDic = [self.classList objectAtIndex:0];
    [self.selectedDic setObject:classDic forKey:@"selectedClass"];
    self.childrenList = classDic[@"children"];
    if(self.childrenList.count != 0){
        NSDictionary *childrenDic = [self.childrenList objectAtIndex:0];
        [self.selectedDic setObject:childrenDic forKey:@"selectedChildren"];
    }
    
    
    CGFloat grayW = (self.width - 60)/5;
    for (int i = 0; i < 5; i ++) {
        UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(i * grayW + (i + 1) * 10, 15, grayW, 20)];
        grayView.layer.masksToBounds = YES;
        grayView.layer.borderWidth = 1;
        grayView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        grayView.layer.cornerRadius = grayView.height/2;
        [self addSubview:grayView];
    }
    self.endArray = arr;
    [self setSelectedButton];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, self.width, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    
    //背景条
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 60 + (self.height - 65 - 50 - 30)/2, self.width, 30)];
    img.image = [UIImage imageNamed:@"img_city"];
    img.userInteractionEnabled = YES;
    [self addSubview:img];
    
    //选择按钮
    UIButton *chooseButton = [JQXCustom creatButton:CGRectMake(self.width - 20 - 50, 5, 40, 20) backColor:BACKGROUNGCOLOR text:@"选择" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:13] addTarget:self Action:@selector(ChooseAction)];
    chooseButton.layer.masksToBounds = YES;
    chooseButton.layer.cornerRadius = 5;
    [img addSubview:chooseButton];
    
    
    //定义pickerView
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 60, self.width - 100, self.height - 65 - 50)];
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
    return 2;
}
// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        return [self.classList count];
        
    }else if(component == 1){
        
        return [self.childrenList count];
        
    }
    
    return 0;
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return (self.width - 100)/2;
}


// 滑动哪行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        
        NSDictionary *classDic = [self.classList objectAtIndex:row];
        self.childrenList = classDic[@"children"];
        [self.pickerView reloadAllComponents];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        
        if(self.childrenList.count == 0){
            [self.selectedDic removeAllObjects];
        }else{
            [self.selectedDic setValue:classDic forKey:@"selectedClass"];
            
            NSDictionary *dic = [self.childrenList objectAtIndex:0];
            [self.selectedDic setValue:dic forKey:@"selectedChildren"];
        }
        
    }else if(component == 1){
        
//        NSLog(@"row =====   %ld",row);
        if(self.childrenList.count != 0){
            
            NSDictionary *dic = [self.childrenList objectAtIndex:row];
            [self.selectedDic setValue:dic forKey:@"selectedChildren"];
        }
        
    }
    
}
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        
        NSDictionary *dic = [self.classList objectAtIndex:row];
        
        return NULL_TO_NIL(dic[@"merchantTypeName"]);
        
    }else if(component == 1){
        NSDictionary *dic = [self.childrenList objectAtIndex:row];
        return NULL_TO_NIL(dic[@"merchantTypeName"]);
        
        
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ClassPickerViewSure" object:nil userInfo:@{@"classSure":self.endArray}];
    
}
#pragma mark - 选择
- (void)ChooseAction
{
    if([[self.selectedDic allKeys] containsObject:@"selectedChildren"]){
        
        NSDictionary *dic = [self.selectedDic objectForKey:@"selectedChildren"];
        NSDictionary *classDic = [self.selectedDic objectForKey:@"selectedClass"];
        BOOL isbool = [self.endArray containsObject:self.selectedDic];
        
        //isbool是1的时候就代表数组中有这个字典 0就是没有
        if(isbool == 1){
            
        }else{
            if(self.endArray.count < 5){
                
                NSMutableDictionary *Alldic = [NSMutableDictionary dictionary];
                [Alldic setValue:dic forKey:@"selectedChildren"];
                [Alldic setValue:classDic forKey:@"selectedClass"];
                
               [self.endArray addObject:Alldic];
                
            }
        }
        [self setSelectedButton];
        
    }
}
#pragma mark - 删除该行业
- (void)DeleteAction:(UIButton *)sender
{
    [self.endArray removeObjectAtIndex:sender.tag - 100];
    
    [self setSelectedButton];
    
}
- (void)setSelectedButton
{
    [self.redView removeFromSuperview];
    self.redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.redView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
    [self addSubview:self.redView];
    CGFloat grayW = (self.width - 60)/5;
    for (int i = 0; i < self.endArray.count; i ++) {
        NSDictionary *dic = [self.endArray objectAtIndex:i];
        NSDictionary *childrenDic = [dic objectForKey:@"selectedChildren"];
        JQXButton *button = [[JQXButton alloc]initWithFrame:CGRectMake(i * grayW + (i + 1) * 10, 15, grayW, 20) styleStr:@"选择"];
        
        button.btnStyleBtnLabel.text = [NSString stringWithFormat:@"%@",childrenDic[@"merchantTypeName"]];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(DeleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.redView addSubview:button];
    }
}
- (NSMutableArray *)classList
{
    if(!_classList){
        _classList = [NSMutableArray array];
    }
    return _classList;
}

- (NSMutableArray *)childrenList
{
    if(!_childrenList){
        _childrenList = [NSMutableArray array];
    }
    return _childrenList;
}
- (NSMutableDictionary *)selectedDic
{
    if(!_selectedDic){
        _selectedDic = [NSMutableDictionary dictionary];
    }
    return _selectedDic;
}

- (NSMutableArray *)endArray
{
    if(!_endArray){
        _endArray = [NSMutableArray array];
    }
    return _endArray;
}
@end
