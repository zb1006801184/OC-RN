//
//  RegisterWebViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/7/28.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "RegisterWebViewController.h"

@interface RegisterWebViewController ()
{
    NSURL *fileURL;
}
@property (nonatomic,strong)UIWebView *webView_;
@property (nonatomic,strong)UITextView *mainText;
@end

@implementation RegisterWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBarWithTitle:@"用户协议" isBack:YES];
    
    self.webView_ = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREENSIZE.width, SCREEN_HEIGHT - 64)];
    
//    fileURL = [[NSBundle mainBundle] URLForResource:@"MerchantAgreement.html" withExtension:nil];
  
    fileURL = [NSURL URLWithString:JQXHttp_RegisterService];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    [self.webView_ loadRequest:request];
    [self.view addSubview:self.webView_];
    
    
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
