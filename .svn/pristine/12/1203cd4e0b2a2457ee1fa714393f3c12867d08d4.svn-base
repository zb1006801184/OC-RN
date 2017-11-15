//
//  QuickRechargeController.m
//  ChongQingPuHui
//
//  Created by 易商通 on 2017/8/15.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "QuickRechargeController.h"

@interface QuickRechargeController ()

@end

@implementation QuickRechargeController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavBarWithTitle:@"快捷充值" isBack:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatWebView];
    
}
-(void)creatWebView{
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - 64;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,64, width, height)];
    NSURL *url = [NSURL URLWithString:self.webUrl];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];

}


@end
