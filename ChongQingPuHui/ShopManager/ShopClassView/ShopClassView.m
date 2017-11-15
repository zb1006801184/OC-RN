//
//  ShopClassView.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/24.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "ShopClassView.h"
@interface ShopClassView ()<UIScrollViewDelegate>
@property (nonatomic,strong)NSDictionary *classDic;
@end
@implementation ShopClassView

- (instancetype)initWithFrame:(CGRect)frame ClassStr:(NSString *)str classArr:(NSArray *)array
                      editStr:(NSString *)edit
{
    if([super initWithFrame:frame]){
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.4];
        self.classStr = str;
        self.classArray = [NSMutableArray arrayWithArray:array];
        self.editStr = edit;
        [self setMainUI];
        
    }
    return self;
}

- (void)setMainUI
{
    UIButton *removeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - SCALE_HEIGHT(50)*6 - 64)];
    [removeButton addTarget:self action:@selector(removeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:removeButton];
    
    UIView *BigView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - SCALE_HEIGHT(50)*6 - 64, SCREEN_WIDTH, SCALE_HEIGHT(50)*6)];
    BigView.backgroundColor = RGB_COLOR(243, 243, 243);
    [self addSubview:BigView];
    
    //提示
    UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(10, 0, SCREEN_WIDTH - 20, SCALE_HEIGHT(50)) backColor:[UIColor clearColor] text:@"" textColor:[UIColor colorWithHexString:@"#333333"] font:Font(15) textAlignment:NSTextAlignmentLeft numOnLines:1];
    tsLabel.attributedText = [self String:@"分类至(按分类展示商品，方便买家筛选)" RangeString:@"(按分类展示商品，方便买家筛选)"];
    [BigView addSubview:tsLabel];
    
    //滑动试图中间分类
    CGFloat scrollHeight = 0;
    if(self.classArray.count < 3){
        scrollHeight = SCALE_HEIGHT(50) *self.classArray.count;
        
    }else{
        scrollHeight = SCALE_HEIGHT(50) * 3;
    }
    UIScrollView *mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SCALE_HEIGHT(50), SCREEN_WIDTH, scrollHeight)];
    mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCALE_HEIGHT(50) *self.classArray.count);
    mainScrollView.delegate = self;
    mainScrollView.backgroundColor = [UIColor whiteColor];
    [BigView addSubview:mainScrollView];
    
    for (int i = 0; i < self.classArray.count; i ++) {
        
        NSDictionary *dic = [self.classArray objectAtIndex:i];
        UIView *classView = [[UIView alloc]initWithFrame:CGRectMake(0, i *SCALE_HEIGHT(50), SCREEN_WIDTH, SCALE_HEIGHT(50))];
        [mainScrollView addSubview:classView];
        
        UIButton *selecteButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, SCALE_HEIGHT(50), SCALE_HEIGHT(50))];
        [selecteButton setImage:[UIImage imageNamed:@"tianjiashangpin-fenlei-normal"] forState:UIControlStateNormal];
        [selecteButton setImage:[UIImage imageNamed:@"tianjiashangpin-fenlei-selected"] forState:UIControlStateSelected];
        selecteButton.tag = 100 + i;
        [selecteButton addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
        [classView addSubview:selecteButton];
        
        UILabel *titleLabel = [JQXCustom creatLabel:CGRectMake(selecteButton.right + 10, 0, 150, SCALE_HEIGHT(50)) backColor:[UIColor clearColor] text:dic[@"typeName"] textColor:[UIColor blackColor] font:Font(15) textAlignment:NSTextAlignmentLeft numOnLines:1];
        [classView addSubview:titleLabel];
        if([self.editStr isEqualToString:@"正常"]){
            if(i == 0){
                selecteButton.selected = YES;
            }
        }else{
            if(i == self.classArray.count - 1){
                selecteButton.selected = YES;
            }
        }
        
//        mainScrollView.pagingEnabled = YES;
        
        
        
        //库存
        //        UILabel *numLabel = [JQXCustom creatLabel:CGRectMake(SCREEN_WIDTH - 130, 0, 120, SCALE_HEIGHT(50)) backColor:[UIColor clearColor] text:[NSString stringWithFormat:@"共%@件商品",dic[@"num"]] textColor:RGB_COLOR(227, 227, 227) font:Font(13) textAlignment:NSTextAlignmentRight numOnLines:1];
        //        [classView addSubview:numLabel];
        
        //        if([self.classStr isEqualToString:@"餐位添加分类"]){
        //
        //            UIButton *deleteButton = [JQXCustom creatButton:CGRectMake(SCREEN_WIDTH - 60,0, 60, SCALE_HEIGHT(50)) backColor:[UIColor clearColor] text:@"删除" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(15) addTarget:self Action:@selector(deleteClassAction:)];
        //            deleteButton.tag = 200 + i;
        //            [classView addSubview:deleteButton];
        //
        //        }
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, SCALE_HEIGHT(50) - 1, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = RGB_COLOR(227, 227, 227);
        [classView addSubview:lineView];
    }
    
    if(![self.editStr isEqualToString:@"正常"]){
        if(self.classArray.count > 3){
            [mainScrollView setContentOffset:CGPointMake(0, SCALE_HEIGHT(50) *(self.classArray.count - 3))];
        }
    }
    
    if([self.classStr isEqualToString:@"商品添加分类"] ||[self.classStr isEqualToString:@"餐位添加分类"]){
        //        新建分类
        UIButton *newClassButton = [JQXCustom creatButton:CGRectMake(0, BigView.height - SCALE_HEIGHT(50)*2, SCREEN_WIDTH, SCALE_HEIGHT(50)) backColor:[UIColor clearColor] text:@"  新建分类" textColor:BACKGROUNGCOLOR font:Font(15) addTarget:self Action:@selector(newClassAction)];
        
        [newClassButton setImage:[UIImage imageNamed:@"addclassification"] forState:UIControlStateNormal];
        
        [BigView addSubview:newClassButton];
    }
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, BigView.height - SCALE_HEIGHT(50), SCREEN_WIDTH, 1)];
    lineView.backgroundColor = RGB_COLOR(227, 227, 227);
    [BigView addSubview:lineView];
    
    //取消按钮
    UIButton *cancleButton = [JQXCustom creatButton:CGRectMake(50, BigView.height - SCALE_HEIGHT(50) + 10, (SCREEN_WIDTH - 150)/2, SCALE_HEIGHT(50) - 20) backColor:[UIColor clearColor] text:@"取消" textColor:[UIColor lightGrayColor] font:Font(15) addTarget:self Action:@selector(removeAction)];
    cancleButton.layer.masksToBounds = YES;
    cancleButton.layer.cornerRadius = 5;
    cancleButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cancleButton.layer.borderWidth = 1;
    [BigView addSubview:cancleButton];
    //确定按钮
    UIButton *sureButton = [JQXCustom creatButton:CGRectMake(cancleButton.right + 50, BigView.height - SCALE_HEIGHT(50) + 10, (SCREEN_WIDTH - 150)/2, SCALE_HEIGHT(50) - 20) backColor:BACKGROUNGCOLOR text:@"确定" textColor:[UIColor whiteColor] font:Font(15) addTarget:self Action:@selector(sureAction)];
    sureButton.layer.masksToBounds = YES;
    sureButton.layer.cornerRadius = 5;
    [BigView addSubview:sureButton];
    
    if([self.editStr isEqualToString:@"正常"]){
        if(self.classArray.count != 0){
            self.classDic = [self.classArray objectAtIndex:0];
        }
    }else{
        if(self.classArray.count != 0){
            self.classDic = [self.classArray objectAtIndex:self.classArray.count - 1];
        }
    }
    
}
#pragma mark - 选择分类
-(void)selectedAction:(UIButton *)sender{
    
    UIButton *button = [UIButton new];
    
    for (int i = 0; i < self.classArray.count; i++) {
        
        button = [self viewWithTag:100 + i];
        
        if (button.tag == sender.tag) {
            
            button.selected = YES;
            
        }else{
            
            button.selected = NO;
            
        }
        
        
    }
    NSDictionary *dic = [self.classArray objectAtIndex:sender.tag - 100];
    self.classDic = dic;
    NSLog(@"----------->%ld",sender.tag);
}
#pragma mark - 确定按钮点击事件
- (void)sureAction
{
    
    [self.SelectedDelegate SelectedClassSure:self.classDic];
    
    [self removeFromSuperview];
}
#pragma mark - 新建分类
- (void)newClassAction
{
    [self.SelectedDelegate NewClassController];
}

- (void)removeAction
{
    [self removeFromSuperview];
}


- (NSMutableAttributedString *)String:(NSString *)String RangeString:(NSString *)RangeString
{
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:String];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:RangeString];
    [hintString addAttribute:NSFontAttributeName value:Font(12) range:range1];
    
    return hintString;
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
@end

