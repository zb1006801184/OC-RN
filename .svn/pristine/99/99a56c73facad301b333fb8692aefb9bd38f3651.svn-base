//
//  AddTableViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/25.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "AddTableViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "ShopPhotoViewController.h"
#import "ShopClassView.h"//分类至
#import "AddClassViewController.h"//添加分类
#import "JQXChangePhotoController.h"
@interface AddTableViewController ()<UITextViewDelegate,SelectedClassDelegate,UIScrollViewDelegate,UITextFieldDelegate>
{
    NSString *editClassStr;
    ShopClassView *shopView;
}
@property (nonatomic,strong)TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic,strong)UIScrollView *headerScrollView;//头
@property (nonatomic,strong)UIImageView *photoImage;
@property (nonatomic,strong)UILabel *headImageLabel;// 第几张图片
@property (nonatomic,strong)UITextView *mainTextView;
@property (nonatomic,strong)UILabel *tsLabel;
@property (nonatomic,strong)UITextField *nameText;//名称
@property (nonatomic,strong)UITextField *peopleText;//人数
@property (nonatomic,strong)UITextField *moneryText;//最低消费
@property (nonatomic,strong)UITextField *timeText;//预定时长
@property (nonatomic,strong)UILabel *classLabel;
@property (nonatomic,strong)NSArray *imageArray;
@property (nonatomic,strong)NSArray *imageIDArray;
@property (nonatomic,strong)UILabel *haveLabel;
@property (nonatomic,strong)NSString *classID;

@property (nonatomic,strong)UIButton *completeButton;

@end

@implementation AddTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:self.styleStr isBack:YES];
    self.view.backgroundColor = RGB_COLOR(239, 239, 239);
    [self setMainUI];
    
    [self setNAVRight];
    editClassStr = @"正常";
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifActon:) name:@"JQXClassListData" object:nil];
    if([self.styleStr isEqualToString:@"编辑餐位"]){
        [self messageDataShow];//餐位回显
    }
}
- (void)notifActon:(NSNotification *)notif
{
    editClassStr = @"添加了新分类";
    [self getClassListData];
}
- (void)setMainUI{
    self.scrollView = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.scrollView];
    
    self.photoImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 120)/2, 20, 120, 120)];
    self.photoImage.image = [UIImage imageNamed:@"AddTable"];
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
    
    self.tsLabel = [JQXCustom creatLabel:CGRectMake(15, 16, textView.width - 30, 15) backColor:[UIColor clearColor] text:@"请填写餐位描述" textColor:[UIColor colorWithHexString:@"#888889"] font:Font(13) textAlignment:NSTextAlignmentLeft numOnLines:0];
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
    
   
    
    NSArray *titleArr = @[@"名称",@"人数",@"人均"];//,@"预定时长"
    //名称
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(0, textView.bottom + 10, SCREEN_WIDTH, 40 *titleArr.count)];
    nameView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:nameView];
    for (int i = 0; i < titleArr.count; i++ ) {
        UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(20, i *40, 60, 40) backColor:[UIColor clearColor] text:titleArr[i] textColor:[UIColor blackColor] font:Font(14) textAlignment:NSTextAlignmentLeft numOnLines:1];
        [nameView addSubview:tsLabel];
        if(i == titleArr.count -1){
            
        }else{
            UIView *nameLineView = [[UIView alloc]initWithFrame:CGRectMake(10, (i + 1) * 40, SCREEN_WIDTH - 20, 1)];
            nameLineView.backgroundColor = RGB_COLOR(226, 226, 226);
            [nameView addSubview:nameLineView];
        }
    }
    
    self.nameText = [JQXCustom creatTextFiled:CGRectMake(90, 0, SCREEN_WIDTH - 100, 40) placeholder:@"请填写餐位名称"];
    self.nameText.delegate = self;
    [self.nameText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [nameView addSubview:self.nameText];
    
    self.peopleText = [JQXCustom creatTextFiled:CGRectMake(90, 40, SCREEN_WIDTH - 100, 40) placeholder:@"请填写餐位可使用人数"];
    self.peopleText.delegate = self;
    self.peopleText.keyboardType = UIKeyboardTypeNumberPad;
    [self.peopleText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [nameView addSubview:self.peopleText];
    
    self.moneryText = [JQXCustom creatTextFiled:CGRectMake(90, 40*2, SCREEN_WIDTH - 100, 40) placeholder:@"请填写餐位人均消费"];
    self.moneryText.delegate = self;
    self.moneryText.keyboardType = UIKeyboardTypeNumberPad;
    [self.moneryText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
    [nameView addSubview:self.moneryText];
    
//    self.timeText = [JQXCustom creatTextFiled:CGRectMake(90, 40*3, SCREEN_WIDTH - 100, 40) placeholder:@"请填写餐位预定时长／分钟"];
//    self.timeText.keyboardType = UIKeyboardTypeNumberPad;
//    [self.timeText addTarget:self action:@selector(TextChange:) forControlEvents:UIControlEventEditingChanged];
//    [nameView addSubview:self.timeText];
    
    //分类
    UIView *classView = [[UIView alloc]initWithFrame:CGRectMake(0, nameView.bottom + 10, SCREEN_WIDTH, 50)];
    classView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:classView];
    
    UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(20, 0, 60, classView.height) backColor:[UIColor clearColor] text:@"分类至" textColor:[UIColor blackColor] font:Font(14) textAlignment:NSTextAlignmentLeft numOnLines:1];
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
#pragma mark - 添加餐位图片
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
    
    NSDictionary *params = @{@"merchantId":self.merchantId};
    [QJGlobalControl sendGETWithUrl:JQXHttp_TableClassList parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data =====   %@",data);
        if([data[@"code"] integerValue] == 200){
            
            [self.view endEditing:YES];
            shopView = [[ShopClassView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) ClassStr:@"餐位添加分类" classArr:data[@"data"] editStr:editClassStr];//餐位添加分类
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
    NSString *classStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"typeName"])];
    if([classStr isEqualToString:@"(null)"]){
        classStr = @"未分类";
    }
    self.classLabel.text = classStr;
    self.classID = [NSString stringWithFormat:@"%@",dic[@"id"]];
    if([classStr isEqualToString:@"打包"]){
        self.timeText.userInteractionEnabled = NO;
        self.timeText.text = @"";
    }else{
        self.timeText.userInteractionEnabled = YES;
    }
}

#pragma mark - 分类代理方法(新建分类)
- (void)NewClassController
{
    [shopView removeFromSuperview];
    AddClassViewController *addVC = [[AddClassViewController alloc]init];
    addVC.styleStr = @"添加餐位分类";
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark textField的字数限制
- (void)TextChange:(UITextField *)textFiled
{
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    NSString *noEmojiStr = [regularExpression stringByReplacingMatchesInString:textFiled.text options:0 range:NSMakeRange(0, textFiled.text.length) withTemplate:@""];
    
    
    if (![noEmojiStr isEqualToString:textFiled.text]) {
        
        textFiled.text = noEmojiStr;
        
    }

    
    if(textFiled == self.peopleText){
        
        NSInteger monery = [textFiled.text integerValue];
        if(monery > 999){
            
            NSString *str = textFiled.text;
            textFiled.text = [str substringToIndex:3];
        }
        
    }else if (textFiled == self.moneryText){
        
        NSInteger monery = [textFiled.text integerValue];
        if(monery > 9999999){
            
            NSString *str = textFiled.text;
            textFiled.text = [str substringToIndex:7];
        }
        
    }else if (textFiled == self.timeText){
        
        NSInteger monery = [textFiled.text integerValue];
        if(monery > 999){
            
            NSString *str = textFiled.text;
            textFiled.text = [str substringToIndex:3];
        }
        
    }
}

#pragma mark textField的字数限制
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
        self.tsLabel.text = @"请填写餐位描述";
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

#pragma mark - 右上角完成按钮
- (void)setNAVRight
{
    self.completeButton = [JQXCustom creatButton:CGRectMake(SCREEN_WIDTH - 60, 0, 60, 44) backColor:[UIColor clearColor]  text:@"完成" textColor:[UIColor whiteColor] font:Font(14) addTarget:self Action:@selector(finashAction)];
    [self.navBarView addSubview:self.completeButton];
    
}
#pragma mark - 完成按钮点击事件
- (void)finashAction
{
    [self.view endEditing:YES];
    
    if(self.imageArray.count == 0 || self.nameText.text.length == 0 || self.moneryText.text.length == 0 || self.peopleText.text.length == 0 || [self.classLabel.text isEqualToString:@"未分类"]){
        
        [ALToastView toastInView:self.view withText:@"信息填写不全，请补充"];
        
        
    }else{
        if([self.peopleText.text floatValue] == 0){
            
            [ALToastView toastInView:self.view withText:@"人数不能为零"];
            
        }else if (![self isPureInt:self.moneryText.text]){
            
            [ALToastView toastInView:self.view withText:@"餐位最低消费为正整数"];
            
        }else{
            
            self.completeButton.enabled =NO;
            
            if([self.styleStr isEqualToString:@"编辑餐位"]){
                [self setUpdateTableData];
            }else{
                [self setAddTableData];
            }
        }
        
    }
    
    
}
#pragma mark - 添加餐位数据请求
- (void)setAddTableData
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSString *imgStr = [self.imageIDArray componentsJoinedByString:@","];
    
    NSDictionary *params = @{@"dishName":self.nameText.text,@"count":self.peopleText.text,@"money":self.moneryText.text,@"merchantId":self.merchantId,@"address":imgStr,@"description":self.mainTextView.text,@"hopeTime":@"20",@"dishTypeId":self.classID};
    
    [QJGlobalControl sendGETWithUrl:JQXHttp_TableAddPhone parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data =====   %@",data);
        if([data[@"code"] integerValue] == 200){
            
            [ALToastView toastInView:self.view withText:@"添加餐位成功"];
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

#pragma mark - 编辑餐位数据请求
- (void)setUpdateTableData
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSString *imgStr = [self.imageIDArray componentsJoinedByString:@","];
    
    NSDictionary *params = @{@"id":self.tableID,@"dishName":self.nameText.text,@"count":self.peopleText.text,@"subscriptionMoney":self.moneryText.text,@"merchantId":self.merchantId,@"address":imgStr,@"description":self.mainTextView.text,@"dishTypeId":self.classID};
    
    [QJGlobalControl sendGETWithUrl:JQXHttp_TableUpdate parameters:params success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"data =====   %@",data);
        if([data[@"code"] integerValue] == 200){
            
            [ALToastView toastInView:self.view withText:@"编辑餐位成功"];
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



#pragma mark - 信息回显
- (void)messageDataShow
{
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSDictionary *params = @{@"id":self.tableID};
    [QJGlobalControl sendPOSTWithUrl:JQXHttp_TableMessageShow parameters:params success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"] integerValue] == 200){
            
            NSDictionary *dic = data[@"data"];
            self.tsLabel.text = @"";
            //商品描述
            self.mainTextView.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"description"])];
            self.haveLabel.text = [NSString stringWithFormat:@"%ld/30",self.mainTextView.text.length];
            if(self.mainTextView.text.length == 0){
                self.tsLabel.text = @"请填写餐位描述";
            }
            //名称
            self.nameText.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"dishName"])];
            //人数
            self.peopleText.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"count"])];
            //价格
            NSString *moneyStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"subscriptionMoney"])];
            if([moneyStr isEqualToString:@"(null)"]){
                moneyStr = @"";
            }
            self.moneryText.text =moneyStr;
            //分类至
            self.classLabel.text = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"typeName"])];
            self.classID = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"dishTypeId"])];
            
            NSString *addressStr = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"address"])];
            
   
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if(textField == self.peopleText || textField == self.moneryText){
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


- (void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
