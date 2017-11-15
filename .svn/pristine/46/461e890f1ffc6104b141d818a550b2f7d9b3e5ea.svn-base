//
//  AddShopViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/24.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "AddShopViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "ShopPhotoViewController.h"
#import "ShopClassView.h"//分类至
#import "AddClassViewController.h"//新建分类
#import "JQXChangePhotoController.h"
@interface AddShopViewController ()<UITextViewDelegate,SelectedClassDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    ShopClassView *shopView;
    NSString *editClassStr;
}
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic,strong)UIScrollView *headerScrollView;//头
@property (nonatomic,strong)UIImageView *photoImage;
@property (nonatomic,strong)UILabel *headImageLabel;// 第几张图片
@property (nonatomic,strong)UITextView *mainTextView;
@property (nonatomic,strong)UILabel *tsLabel;
@property (nonatomic,strong)UITextField *nameText;
@property (nonatomic,strong)UITextField *moneryText;
@property (nonatomic,strong)UITextField *bigText;//单位
@property (nonatomic,strong)UILabel *classLabel;
@property (nonatomic,strong)NSArray *imageArray;
@property (nonatomic,strong)NSArray *imageIDArray;
@property (nonatomic,strong)UILabel *haveLabel;
@property (nonatomic,strong)NSString *dishTypeId;
@property (nonatomic,strong)NSString *shopId;

@property (nonatomic,strong)UIButton *completeButton;


@end

@implementation AddShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:self.titleStr isBack:YES];
    self.view.backgroundColor = RGB_COLOR(239, 239, 239);
    [self setMainUI];
    [self setNAVRight];
    if([self.titleStr isEqualToString:@"编辑商品"]){
        //获取商品信息
        [self getShopMessage];

    }
    editClassStr = @"正常";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifActon:) name:@"JQXClassListData" object:nil];
    
}
- (void)notifActon:(NSNotification *)notif
{
    editClassStr = @"添加了新的分类";
    [self getClassListData];
}
- (void)setMainUI{
    
    self.scrollView = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.scrollView];
    
    self.photoImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 120)/2, 20, 120, 120)];
    self.photoImage.image = [UIImage imageNamed:@"addpic"];
    self.photoImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PhotoImage:)];
    [self.photoImage addGestureRecognizer:tap];
    [self.scrollView addSubview:self.photoImage];
    
    
    
    self.headerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    self.headerScrollView.delegate = self;
    self.headerScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 160);
    self.headerScrollView.showsHorizontalScrollIndicator = NO;
    self.headerScrollView.pagingEnabled = YES; //使用翻页属性
    self.headerScrollView.hidden = YES;
    [self.scrollView addSubview:self.headerScrollView];
    
    self.headImageLabel = [[UILabel alloc]init];
    self.headImageLabel.frame = CGRectMake((SCREEN_WIDTH - 40)/2, self.headerScrollView.bottom  - 30, 40, 20);
    self.headImageLabel.hidden = YES;
    self.headImageLabel.textColor = [UIColor whiteColor];
    self.headImageLabel.textAlignment = NSTextAlignmentCenter;
    self.headImageLabel.backgroundColor = RGBA_COLOR(0, 0, 0, .4);
    //    [self.scrollView insertSubview:self.headImageLabel atIndex:999];
    [self.scrollView addSubview:self.headImageLabel];
    
    
    
    //商品描述
    UIView *textView = [[UIView alloc]initWithFrame:CGRectMake(0, self.photoImage.bottom + 20, SCREEN_WIDTH, 100)];
    textView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:textView];
    
    self.tsLabel = [JQXCustom creatLabel:CGRectMake(15, 16, textView.width - 30, 15) backColor:[UIColor clearColor] text:@"请填写商品描述" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:0];
    [textView addSubview:self.tsLabel];

    
    //主textView
    self.mainTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 8, textView.width - 20, textView.height - 28)];
    self.mainTextView.font = Font(13);
    self.mainTextView.delegate = self;
    self.mainTextView.backgroundColor = [UIColor clearColor];
    [textView addSubview:self.mainTextView];
    
    //字数显示
    self.haveLabel = [JQXCustom creatLabel:CGRectMake(SCREEN_WIDTH - 210, self.mainTextView.bottom, 200, 20) backColor:[UIColor clearColor] text:@"0/30" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentRight numOnLines:0];
    [textView addSubview:self.haveLabel];

    //名称
    NSArray *titleArr = @[@"名称",@"价格",@"单位"];
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(0, textView.bottom + 10, SCREEN_WIDTH, 40 *titleArr.count)];
    nameView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:nameView];
    
    UIView *nameLineView = [[UIView alloc]initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH - 20, 1)];
    nameLineView.backgroundColor = RGB_COLOR(226, 226, 226);
    [nameView addSubview:nameLineView];
    
    UIView *nameLineView1 = [[UIView alloc]initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH - 20, 1)];
    nameLineView1.backgroundColor = RGB_COLOR(226, 226, 226);
    [nameView addSubview:nameLineView1];
    
    
    for (int i = 0; i < titleArr.count; i++ ) {
        UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(0, i *40, 60, 40) backColor:[UIColor clearColor] text:titleArr[i] textColor:[UIColor colorWithHexString:@"#888889"] font:Font(14) textAlignment:NSTextAlignmentCenter numOnLines:1];
        [nameView addSubview:tsLabel];
    }
    self.nameText = [JQXCustom creatTextFiled:CGRectMake(70, 0, SCREEN_WIDTH - 80, 40) placeholder:@"请填写商品名称"];
    self.nameText.delegate = self;
    self.nameText.textAlignment = NSTextAlignmentLeft;
    [self.nameText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [nameView addSubview:self.nameText];
    
    self.moneryText = [JQXCustom creatTextFiled:CGRectMake(70, self.nameText.bottom, SCREEN_WIDTH - 100, 40) placeholder:@"请填写商品价格"];
    self.moneryText.delegate  = self;
    self.moneryText.keyboardType = UIKeyboardTypeNumberPad;
    [self.moneryText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [nameView addSubview:self.moneryText];
    
    self.bigText= [JQXCustom creatTextFiled:CGRectMake(70, self.moneryText.bottom, SCREEN_WIDTH - 80, 40) placeholder:@"请填写商品单位"];
    self.bigText.delegate = self;
    self.bigText.textAlignment = NSTextAlignmentLeft;
    [self.bigText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [nameView addSubview:self.bigText];
    
    
    //分类
    UIView *classView = [[UIView alloc]initWithFrame:CGRectMake(0, nameView.bottom + 10, SCREEN_WIDTH, 50)];
    classView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:classView];
    
    UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(0, 0, 60, classView.height) backColor:[UIColor clearColor] text:@"分类至" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(14) textAlignment:NSTextAlignmentCenter numOnLines:1];
    [classView addSubview:tsLabel];
    
    UIImageView *moreimgf = [[UIImageView alloc]initWithFrame:CGRectMake(classView.width - 20, (classView.height - 13)/2, 7, 13)];
    moreimgf.image = [UIImage imageNamed:@"me_goon"];
    [classView addSubview:moreimgf];
    
    self.classLabel = [JQXCustom creatLabel:CGRectMake(80, 0, classView.width - 110, classView.height) backColor:[UIColor clearColor] text:@"未分类" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(14) textAlignment:NSTextAlignmentRight numOnLines:1];
    [classView addSubview:self.classLabel];
    
    UIButton *classButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, classView.width, classView.height)];
    [classButton addTarget:self action:@selector(ClassAction) forControlEvents:UIControlEventTouchUpInside];
    [classView addSubview:classButton];
}
#pragma mark - 添加商品图片
-(void)PhotoImage:(UIGestureRecognizer *)tap
{
    JQXChangePhotoController *vc = [[JQXChangePhotoController alloc]init];
    vc.mainArray = [NSMutableArray arrayWithArray:self.imageIDArray];
    [vc photoArray:^(NSMutableArray *photoArray) {
        self.imageArray = photoArray;
        self.imageIDArray = photoArray;
        
        if(photoArray.count != 0){
            
            self.photoImage.hidden = YES;
            self.headImageLabel.hidden = NO;
            self.headImageLabel.text = [NSString stringWithFormat:@"1/%ld",photoArray.count];
            self.headerScrollView.contentSize = CGSizeMake(SCREEN_WIDTH *photoArray.count, 160);
            
            self.headerScrollView.hidden = NO;
            [self.headerScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            
            for (int i = 0; i < photoArray.count; i ++) {
                UIImageView *image = [[UIImageView alloc]init];
                image.frame = CGRectMake(i *SCREEN_WIDTH, 0, SCREEN_WIDTH, self.headerScrollView.height);
                image.contentMode = UIViewContentModeScaleAspectFit;
                image.userInteractionEnabled = YES;
                [image sd_setImageWithURL:[NSURL URLWithString:photoArray[i]] placeholderImage:[UIImage imageNamed:@"JQXShi"]];
                
                
                UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PhotoImage:)];
                [image addGestureRecognizer:tap];
                [self.headerScrollView addSubview:image];
                self.headImageLabel.hidden = NO;
            }
        }else{
            self.photoImage.hidden = NO;
            self.headImageLabel.hidden = YES;
            self.headerScrollView.hidden = YES;
        }
    }];
    
    
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 分类
- (void)ClassAction
{
    
    [self getClassListData];
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
            
            [self.view endEditing:YES];
            shopView = [[ShopClassView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) ClassStr:@"商品添加分类" classArr:data[@"data"] editStr:editClassStr];

            shopView.SelectedDelegate = self;
            [self.view addSubview:shopView];
            
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}



#pragma mark - 分类代理方法(选择的分类)
- (void)SelectedClassSure:(NSDictionary *)dic
{
    self.classLabel.text = [NSString stringWithFormat:@"%@",dic[@"typeName"]];
    self.dishTypeId = [NSString stringWithFormat:@"%@",dic[@"id"]];
}
#pragma mark - 分类代理方法(新建分类)
- (void)NewClassController
{
    [shopView removeFromSuperview];
    AddClassViewController *vc = [[AddClassViewController alloc]init];
    vc.styleStr = @"添加商品分类";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark textField的字数限制
- (void)TextChange:(UITextField *)textFiled
{
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textFiled.text options:0 range:NSMakeRange(0, textFiled.text.length) withTemplate:@""];
    

    if (![noEmojiStr isEqualToString:textFiled.text]) {
        
        textFiled.text = noEmojiStr;
        
    }
    if(textFiled == self.moneryText){
        NSInteger monery = [textFiled.text integerValue];
        if(monery > 99999){
            NSString *str = textFiled.text;
            textFiled.text = [str substringToIndex:5];
        }
    }

}
#pragma mark textView的字数限制
//在这个地方计算输入的字数
- (void)textViewDidChange:(UITextView *)textView
{
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textView.text options:0 range:NSMakeRange(0, textView.text.length) withTemplate:@""];
    
    
    
    if (![noEmojiStr isEqualToString:textView.text]) {
        
        textView.text = noEmojiStr;
        
    }
    NSInteger MAX = 30;
    NSString *nsTextContent = textView.text;
    NSInteger Num = nsTextContent.length;

    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];

    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制,防止中文被截断
    if (!position){
        if (nsTextContent.length > MAX){
            //中文和emoj表情存在问题，需要对此进行处理
            NSRange rangeRange = [nsTextContent rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX)];
            self.mainTextView.text = [nsTextContent substringWithRange:rangeRange];
        }
    }

    if(Num == 0){
        self.tsLabel.text = @"请填写商品描述";
    }else
    {
        self.tsLabel.text = @"";


    }
    if(Num > MAX){
        Num = MAX;
    }
    NSString *allCount = [NSString stringWithFormat:@"%ld/30",(long)Num];
    self.haveLabel.text = allCount;
    
}
#pragma mark - 头部滚动试图代理事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"--------------------%zd",self.imageArray.count);
    if (scrollView == self.headerScrollView) {
        CGPoint  offset = scrollView.contentOffset;//偏移量
        if (offset.x < 0 ) {
            scrollView.contentOffset = CGPointMake(0, offset.y);
        }
        if (offset.x > scrollView.frame.size.width*(self.imageArray.count -1)) {
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width*(self.imageArray.count-1) , offset.y);
        }
        NSUInteger  index = round(offset.x/scrollView.frame.size.width);
        //设置分页控件中处于被激活的提示符的下标
        self.headImageLabel.text = [NSString stringWithFormat:@"%ld/%ld",index+1,self.imageArray.count];
    }else{
        
    }
    
}
#pragma mark - 获取商品信息
- (void)getShopMessage
{
    
    NSDictionary *params = @{@"id":self.idStr};
    
    [QJGlobalControl sendGETWithUrl:JQXHttp_ShopMessage parameters:params success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"] integerValue] == 200){
            NSDictionary *dic = data[@"data"];
            self.tsLabel.text = @"";
            //商品描述
            self.mainTextView.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"description"])];
            self.haveLabel.text = [NSString stringWithFormat:@"%ld/30",self.mainTextView.text.length];
            if(self.mainTextView.text.length == 0){
                self.tsLabel.text = @"请填写商品描述";
            }
            
            //名称
            self.nameText.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"dishName"])];
            //价格
            self.moneryText.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"money"])];
            //单位
            NSString *bigStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"moneyUnit"])];
            if([bigStr isEqualToString:@"(null)"]){
                bigStr = @"";
            }
            self.bigText.text = bigStr;
            //分类至
            self.classLabel.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"typeName"])];
            
            NSString *addressStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"imgAddress"])];
            
            self.dishTypeId =  [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"dishTypeId"])];
            
            self.shopId = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"id"])];
            
            
            NSArray* imgArray = [addressStr componentsSeparatedByString:@","];
            NSMutableArray *newImgArray = [NSMutableArray array];
            for (int x = 0; x < imgArray.count; x ++) {
                NSString *imgStr = [NSString stringWithFormat:@"%@",imgArray[x]];
                if(x <imgArray.count - 1){
                    [newImgArray addObject:imgStr];
                }
            }
 
             self.photoImage.hidden = YES;
             self.headImageLabel.text = [NSString stringWithFormat:@"1/%ld",newImgArray.count];
             self.headerScrollView.contentSize = CGSizeMake(SCREEN_WIDTH *newImgArray.count, 110);
             self.headerScrollView.hidden = NO;
             self.imageArray = [NSMutableArray arrayWithArray:newImgArray];
             self.imageIDArray  = [NSMutableArray arrayWithArray:newImgArray];
             for (int i = 0; i < newImgArray.count; i ++) {
                 UIImageView *image = [[UIImageView alloc]init];
                 image.frame = CGRectMake(i *SCREEN_WIDTH, 0, SCREEN_WIDTH, self.headerScrollView.height);
                 [image sd_setImageWithURL:[NSURL URLWithString:newImgArray[i]] placeholderImage:[UIImage imageNamed:@"JQXShi"]];
                 image.userInteractionEnabled = YES;
                 image.contentMode = UIViewContentModeScaleAspectFit;
                 UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PhotoImage:)];
                 [image addGestureRecognizer:tap];
                 [self.headerScrollView addSubview:image];
                 
             }
            self.headImageLabel.hidden = NO;
            
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];

}


#pragma mark - 右上角完成按钮
- (void)setNAVRight
{
    self.completeButton = [JQXCustom creatButton:CGRectMake(SCREEN_WIDTH - 60, 0, 60, 44) backColor:[UIColor clearColor]  text:@"完成" textColor:[UIColor whiteColor] font:Font(14) addTarget:self Action:@selector(finashAction)];
    [self.navBarView addSubview:self.completeButton];
    
}

#pragma mark - 添加商品
- (void)finashAction
{
    [self.view endEditing:YES];
    if(self.imageArray.count == 0 || self.nameText.text.length == 0 || self.moneryText.text.length == 0 || self.dishTypeId.length == 0 || [self.classLabel.text isEqualToString:@"未分类"]){
        
         [ALToastView toastInView:self.view withText:@"信息填写不全，请补充"];
        
    }else if (![self isPureInt:self.moneryText.text]){
        
        [ALToastView toastInView:self.view withText:@"商品金额为正整数"];
        
    }else{
        
        self.completeButton.enabled = NO;
        
        NSString *idStr = [self.imageIDArray componentsJoinedByString:@","];
        
        if([self.titleStr isEqualToString:@"添加商品"]){
            [self addShopData:idStr];
        }else{
            [self upDateShopData:idStr];
        }
    }
    
    
}
#pragma mark - 添加商品数据请求
- (void)addShopData:(NSString *)imgStr
{
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSString *addressStr = [self.imageIDArray componentsJoinedByString:@","];
    
    NSDictionary *params = @{@"description":self.mainTextView.text,@"dishName":self.nameText.text,@"money":self.moneryText.text,@"merchantId":self.merchantId,@"typeName":self.classLabel.text,@"imgAddress":addressStr,@"dishTypeId":self.dishTypeId,@"type":@"0",@"isDelete":@"0",@"moneyUnit":self.bigText.text};
    
    [QJGlobalControl sendGETWithUrl:JQXHttp_AddShop parameters:params success:^(id data) {
        [JHHJView hideLoading];
        
        NSLog(@"data =====   %@",data);
        if([data[@"code"] integerValue] == 200){
            
            [ALToastView toastInView:self.view withText:@"添加菜品成功"];
            dispatch_time_t delayTime = dispatch_time
            (DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
            
            dispatch_after
            (delayTime, dispatch_get_main_queue(),
             ^{
                 [self.navigationController popViewControllerAnimated:YES];
                 
                 
             }
             );
        }else{
            
            self.completeButton.enabled = YES;
            
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
        
    } fail:^(NSError *error) {
        self.completeButton.enabled = YES;
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}

#pragma mark - 编辑商品数据请求
- (void)upDateShopData:(NSString *)imgStr
{
        [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
        NSDictionary *params = @{@"description":self.mainTextView.text,@"dishName":self.nameText.text,@"money":self.moneryText.text,@"dishTypeId":self.dishTypeId,@"imgAddress":imgStr,@"id":self.shopId,@"moneyUnit":self.bigText.text};
    
        [QJGlobalControl sendGETWithUrl:JQXHttp_UpDateShop parameters:params success:^(id data) {
            [JHHJView hideLoading];
            NSLog(@"data =====   %@",data);
            if([data[@"code"] integerValue] == 200){
                [ALToastView toastInView:self.view withText:@"编辑商品成功"];
    
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

- (NSArray *)imageArray
{
    if(!_imageArray){
        _imageArray = [NSArray array];
    }
    return _imageArray;
}
- (NSArray *)imageIDArray
{
    if(!_imageIDArray){
        _imageIDArray = [NSArray array];
    }
    return _imageIDArray;
}
- (void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField == self.moneryText){
        //禁止用户输入字母
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c]) {
                return NO;
            }
        }
    }
    //不支持系统表情的输入
    if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //不支持系统表情的输入
    if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    return YES;
}

//判断是否为整形：
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
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
