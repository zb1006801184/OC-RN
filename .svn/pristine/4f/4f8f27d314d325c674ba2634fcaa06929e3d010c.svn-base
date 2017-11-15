
//
//  BankViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "BankViewController.h"
#import "EditBankViewController.h"
@interface BankViewController ()
@property (nonatomic,strong)UIView *cardBgView;
@property (nonatomic,strong)UIView *bgNullView;
@property (nonatomic,strong)NSDictionary *mainDic;
@end

@implementation BankViewController
- (void)viewWillAppear:(BOOL)animated
{
    [self setDataCard];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"我的银行卡" isBack:YES];
    self.view.backgroundColor = BACKGrayColor;
    [self setDataCard];
}
- (void)setDataCard
{
    
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    [QJGlobalControl sendGETWithUrl:httpBankListURL parameters:nil success:^(id data) {
        [JHHJView hideLoading];
        NSLog(@"🍉：%@",data);
        if([data[@"code"]integerValue] == 200){
            self.mainDic = data[@"data"];
            
            [self setCardUI];
        }else if ([data[@"code"]integerValue] == 60033){
            //暂无银行卡信息
            [self setNullView];
        }else{
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }

    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
    
}
#pragma mark - 银行卡
- (void)setCardUI
{
    [self.bgNullView removeFromSuperview];
    [self.cardBgView removeFromSuperview];
    self.cardBgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, 250 *SCALEHEIGHT)];
    self.cardBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cardBgView];
    
    UIImageView *cardImage = [[UIImageView alloc]initWithFrame:CGRectMake(20,10, SCREEN_WIDTH - 40, 180 * SCALEHEIGHT)];
    cardImage.image = [UIImage imageNamed:@"IDCard"];
    [self.cardBgView addSubview:cardImage];
    
    NSString *nameStr = [NSString stringWithFormat:@"%@",self.mainDic[@"ownerName"]];
    NSString *hiddenStr = nameStr;
    hiddenStr = [NSString stringWithFormat:@"*%@",[nameStr substringFromIndex:1]];

    
    CGFloat nameWidth = [hiddenStr CallatelabelSizeWidth:[UIFont systemFontOfSize:18] lineHeight:30];
    UILabel *nameLabel = [JQXCustom creatLabel:CGRectMake(35, 20, nameWidth, 30) backColor:[UIColor clearColor] text:hiddenStr textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentLeft numOnLines:1];
    [cardImage addSubview:nameLabel];
    
    NSString *bankStr = [NSString stringWithFormat:@"%@",self.mainDic[@"bankName"]];
    CGFloat bankWidth = [bankStr CallatelabelSizeWidth:[UIFont systemFontOfSize:18] lineHeight:30];
    UILabel *bankLabel = [JQXCustom creatLabel:CGRectMake(cardImage.width - bankWidth - 10, 20, bankWidth, 30) backColor:[UIColor clearColor] text:bankStr textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18] textAlignment:NSTextAlignmentRight numOnLines:1];
    [cardImage addSubview:bankLabel];
    
    
    NSString *telStr = [NSString stringWithFormat:@"%@",self.mainDic[@"cardNo"]];
    
    NSString *newTel = [QJGlobalControl countNumAndChangeformat:telStr];
    UILabel *numLabel = [JQXCustom creatLabel:CGRectMake(0,cardImage.height - 50 , cardImage.width, 30) backColor:[UIColor clearColor] text:newTel textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:22] textAlignment:NSTextAlignmentCenter numOnLines:1];
    [cardImage addSubview:numLabel];
    
    //编辑按钮
    UIButton *editBtn = [JQXCustom creatButton:CGRectMake((SCREEN_WIDTH - 235)/2, cardImage.bottom + 15 , 100 , 30) backColor:[UIColor whiteColor] text:@"编辑" textColor:BACKGROUNGCOLOR font:[UIFont systemFontOfSize:15] addTarget:self Action:@selector(EditCardAction)];
    editBtn.layer.masksToBounds = YES;
    editBtn.layer.cornerRadius = 10;
    editBtn.layer.borderWidth = 1;
    editBtn.layer.borderColor = BACKGROUNGCOLOR.CGColor;
    [self.cardBgView addSubview:editBtn];
    
    //删除按钮
    UIButton *delegateBtn = [JQXCustom creatButton:CGRectMake( editBtn.right + 35, cardImage.bottom + 15 , 100 , 30) backColor:[UIColor whiteColor] text:@"删除" textColor:BACKGROUNGCOLOR font:[UIFont systemFontOfSize:15] addTarget:self Action:@selector(DelegateAction)];
    delegateBtn.layer.masksToBounds = YES;
    delegateBtn.layer.cornerRadius = 10;
    delegateBtn.layer.borderWidth = 1;
    delegateBtn.layer.borderColor = BACKGROUNGCOLOR.CGColor;
    [self.cardBgView addSubview:delegateBtn];
    
}
#pragma mark - 未绑定银行卡
- (void)setNullView
{
    [self.bgNullView removeFromSuperview];
    [self.cardBgView removeFromSuperview];
    self.bgNullView = [[UIView alloc]initWithFrame:CGRectMake(0, self.navBarView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarView.bottom)];
    self.bgNullView.backgroundColor = [UIColor colorWithRed:0.90f green:0.90f blue:0.91f alpha:1.00f];
    ;
    [self.view addSubview:self.bgNullView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, 150, 100, 100)];
    imageView.image = [UIImage imageNamed:@"nullimg"];
    
    [self.bgNullView addSubview:imageView];
    
    UILabel *tsLabel = [JQXCustom creatLabel:CGRectMake(0, imageView.bottom+10, SCREEN_WIDTH, 30) backColor:[UIColor clearColor] text:@"您还未绑定银行卡" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentCenter numOnLines:1];
    [self.bgNullView addSubview:tsLabel];
    
    //提交认证按钮
    UIButton *submitBtn = [JQXCustom creatButton:CGRectMake((SCREEN_WIDTH - 150)/2, tsLabel.bottom + 10,150, 30) backColor:BACKGROUNGCOLOR text:@"立即去绑定银行卡" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15] addTarget:self Action:@selector(CardAction)];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 10;
    [self.bgNullView addSubview:submitBtn];
    
    
}
#pragma mark - 立即绑定银行卡
- (void)CardAction
{
    EditBankViewController *editVC = [[EditBankViewController alloc]init];
    editVC.type = @"1";
    [self.navigationController pushViewController:editVC animated:YES];
}
#pragma mark - 编辑银行卡
- (void)EditCardAction
{
    EditBankViewController *editVC = [[EditBankViewController alloc]init];
    editVC.type = @"2";
    [self.navigationController pushViewController:editVC animated:YES];
}
#pragma mark - 删除银行卡
-(void)DelegateAction{
    
    
    [UIAlertView alertViewTitle:@"提示" message:@"确定删除该银行卡么" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定"];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    
    if(buttonIndex == 1){
        
        [self setDelegateData];
    }
    
    
}
- (void)setDelegateData
{
    NSString *nameStr = [[NSUserDefaults standardUserDefaults]objectForKey:RealName];
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:UserID];
    NSString *bankName = [NSString stringWithFormat:@"%@",self.mainDic[@"bankName"]];
    NSString *bankID = [NSString stringWithFormat:@"%@",self.mainDic[@"cardNo"]];
    NSString *telStr = [[NSUserDefaults standardUserDefaults]objectForKey:LoginPhone];
    NSDictionary *params = @{@"ownerName":nameStr,@"bankName":bankName,@"cardNo":bankID,@"telPhone":telStr,@"operator":@"3",@"userId":userID};
    [JHHJView showLoadingOnTheKeyWindowWithType:2];
    
    [QJGlobalControl sendPOSTWithUrl:httpBankURL parameters:params success:^(id data) {
        NSLog(@"data === %@",data);
        [JHHJView hideLoading];
        if([data[@"code"]integerValue] == 200){
            
            [self setDataCard];
            
        }else{
            
            [ALToastView toastInView:self.view withText:data[@"message"]];
        }
        
    } fail:^(NSError *error) {
        [JHHJView hideLoading];
        [ALToastView toastInView:self.view withText:@"请求失败"];
    }];
}
- (NSDictionary *)mainDic
{
    if(!_mainDic){
        _mainDic = [NSDictionary dictionary];
    }
    return _mainDic;
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
