//
//  MessageViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/27.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageHeaderCell.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>
{
    NSString *replayStr;//回复的内容
}
@property (nonatomic,strong)UITableView *mainTableView;
@property (nonatomic,strong)NSDictionary *mainDic;
@property (nonatomic,strong)UIView *zheZhaoView_;
@property (nonatomic,strong)UITextField *textfiled;
@property (nonatomic,strong)UITextView *replyTextView;
@property (nonatomic,strong)UIView *replyView;
@property (nonatomic,strong)UIButton *sendButton;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"评论" isBack:YES];
    [self getReplyMessageData];
    [self.view addSubview:self.mainTableView];
    self.zheZhaoView_ = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREENSIZE.width, SCREENSIZE.height)];
    self.zheZhaoView_.backgroundColor = [UIColor grayColor];
    self.zheZhaoView_.alpha = .5;
    self.zheZhaoView_.hidden = YES;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CancelAction)];
    [self.zheZhaoView_ addGestureRecognizer:tapGesture];
    [self.view addSubview:self.zheZhaoView_];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeFirstResponder)
                                                 name:UIKeyboardWillShowNotification//将要显示键盘
                                               object:nil];
    
}
#pragma mark - UITableViewDelegate
//indexPath.row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"MessageHeaderCellID";
    MessageHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(cell == nil){
        cell = [[MessageHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    [cell setDataDic:self.mainDic];
    return cell;

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if([self.mainDic objectForKey:@"merchantName"]){
        
        NSArray *array = [self.mainDic objectForKey:@"cList"];
        //30 +45 + 30 + 内容的高度
        
        CGFloat contentH = [array[0][@"content"] CallateLabelSizeHeight:Font(14) lineWidth:SCREEN_WIDTH - 30 - 45];
        
        CGFloat replyH = 10;
        for (int i = 1; i < array.count; i ++) {
            
            CGFloat replyContentH = [array[i][@"content"] CallateLabelSizeHeight:Font(12) lineWidth:SCREEN_WIDTH - 30 - 45 - 20 - 60 - 10];
            
            replyH = replyH + replyContentH + 5;
            
        }
        
        
        return 130 + contentH + replyH;//30 +45 + 30 + 内容的高度 + jiujiu的高度 + 10
        
    }else{
        
        return 100;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 获取评论数据
- (void)getReplyMessageData
{
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    NSDictionary *params = @{@"orderId":self.orderID};
    
    [QJGlobalControl sendGETWithUrl:JQXHttp_AdvanceMessage parameters:params success:^(id data) {
        [JHHJView hideLoading];
        if([data[@"code"]integerValue] == 200){
            NSLog(@"data   ====     %@",data);
            self.mainDic = data[@"data"];
            [self.mainTableView reloadData];
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];

}

- (UITableView *)mainTableView
{
    if(!_mainTableView){
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarView.bottom)];
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        UIButton *replyButton = [JQXCustom creatButton:CGRectMake((SCREEN_WIDTH - 180)/2, 50, 180, 40) backColor:BACKGROUNGCOLOR text:@"回复" textColor:[UIColor whiteColor] font:Font(13) addTarget:self Action:nil];
        [footView addSubview:replyButton];
        replyButton.layer.cornerRadius = 8;
        replyButton.layer.masksToBounds = YES;
        
        self.textfiled = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 180)/2, 50, 180, 40)];
        self.textfiled.delegate = self;
        self.textfiled.inputAccessoryView = self.replyView;
        [footView addSubview:self.textfiled];
        
        _mainTableView.tableFooterView = footView;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}
- (NSDictionary *)mainDic
{
    if(!_mainDic){
        _mainDic = [NSDictionary dictionary];
    }
    return _mainDic;
}
#pragma mark - 回复按钮点击事件
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.zheZhaoView_.hidden = NO;
    self.sendButton.backgroundColor = RGB_COLOR(239, 239, 239);
    self.sendButton.userInteractionEnabled = NO;
}
#pragma mark -  改变第一响应者
-(void)changeFirstResponder
{
    self.replyTextView.text = @"";
    [self.replyTextView becomeFirstResponder]; //will return YES;
}
#pragma mark - 点击遮罩
- (void)CancelAction
{
    self.textfiled.text = @"";
    [self.replyTextView resignFirstResponder];
    self.zheZhaoView_.hidden = YES;
    [self.view endEditing:YES];
}
#pragma mark - 发送消息
- (void)SendAction
{
    self.sendButton.userInteractionEnabled = NO;
    [self SumbitReplyData];
}
#pragma mark - 提交信息
- (void)SumbitReplyData
{
    NSArray *array = [self.mainDic objectForKey:@"cList"];
    NSDictionary *dic = [array objectAtIndex:array.count - 1];
    NSString *commentid = [NSString stringWithFormat:@"%@",NULL_TO_NIL(dic[@"id"])];
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:UserID];
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    NSDictionary *params = @{@"commentid":commentid,@"merchantid":userID,@"content":self.replyTextView.text};
    [QJGlobalControl sendGETWithUrl:JQXHttp_AdvanceMessageReply  parameters:params success:^(id data) {
        [JHHJView hideLoading];
        
        if([data[@"code"]integerValue] == 200){
            NSLog(@"data   ====     %@",data);
            self.textfiled.text = @"";
            [self.replyTextView resignFirstResponder];
            self.zheZhaoView_.hidden = YES;
            [self.view endEditing:YES];
            [self getReplyMessageData];
            [ALToastView toastInView:self.view withText:@"评论成功"];
            
        }else{
            self.sendButton.userInteractionEnabled = YES;
            //    NSLog(@"%@",self.replyTextView.text);
            self.textfiled.text = @"";
            [self.replyTextView resignFirstResponder];
            self.zheZhaoView_.hidden = YES;
            [self.view endEditing:YES];
            
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        self.sendButton.userInteractionEnabled = YES;
        [ALToastView toastInView:self.zheZhaoView_ withText:@"请求失败"];
    }];

}
- (UIView *)replyView
{
    if(!_replyView){
        _replyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110)];
        _replyView.backgroundColor = [UIColor whiteColor];
        _replyTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 60)];
        _replyTextView.backgroundColor = [UIColor whiteColor];
        _replyTextView.layer.borderWidth = 1;
        _replyTextView.layer.borderColor = [RGB_COLOR(239, 239, 239) CGColor];
        _replyTextView.delegate = self;
        [_replyView addSubview:_replyTextView];
        
        UIButton *cancelButton = [JQXCustom creatButton:CGRectMake(30, _replyTextView.bottom + 10, 70, 25) backColor:RGB_COLOR(239, 239, 239) text:@"取消" textColor:[UIColor whiteColor] font:Font(13) addTarget:self Action:@selector(CancelAction)];
        cancelButton.layer.cornerRadius = 5;
        cancelButton.layer.masksToBounds = YES;
        [_replyView addSubview:cancelButton];
       
        
        _sendButton = [JQXCustom creatButton:CGRectMake(SCREEN_WIDTH - 30 - 70, _replyTextView.bottom + 10, 70, 25) backColor:BACKGROUNGCOLOR text:@"发送" textColor:[UIColor whiteColor] font:Font(13) addTarget:self Action:@selector(SendAction)];
        _sendButton.backgroundColor = RGB_COLOR(239, 239, 239);
        _sendButton.userInteractionEnabled = NO;
        _sendButton.layer.cornerRadius = 5;
        _sendButton.layer.masksToBounds = YES;
        [_replyView addSubview:_sendButton];
        
    }
    return _replyView;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if(textView == self.replyTextView){
        
        
        if([[self.replyTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
            
            self.sendButton.backgroundColor = RGB_COLOR(239, 239, 239);
            self.sendButton.userInteractionEnabled = NO;
            
        }else{
            
            self.sendButton.backgroundColor = BACKGROUNGCOLOR;
            self.sendButton.userInteractionEnabled = YES;
        }
        
    }
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
