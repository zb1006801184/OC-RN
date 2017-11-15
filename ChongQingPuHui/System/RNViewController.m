//
//  RNViewController.m
//  ChongQingPuHui
//
//  Created by 朱标 on 2017/11/7.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "RNViewController.h"
#import "RCTRootView.h"
#import "RCTBridgeModule.h"
#import "MainViewController.h"
#import "AppDelegate.h"
@interface RNViewController ()<RCTBridgeModule>

@end

@implementation RNViewController
RCT_EXPORT_MODULE()
// RN跳转原生界面
RCT_EXPORT_METHOD(RNViewControllerClick:(NSString *)msg){
    
    NSLog(@"RN传入原生界面的数据为:%@",msg);
    //主要这里必须使用主线程发送,不然有可能失效
    dispatch_async(dispatch_get_main_queue(), ^{
        MainViewController *one = [[MainViewController alloc]init];
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app.nav popViewControllerAnimated:YES];//返回到上一层VC
        //跳转到VC push
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initRNView];
}

- (void)initRNView {
    NSURL *jsCodeLocation;
    jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=false"];
//    jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
    //jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
    //输入rn的数据
    NSDictionary*msg = @{@"name":@"a",@"age":@"12"};
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"ChongQingPuHui"
                                                 initialProperties:msg
                                                     launchOptions:nil];
    self.view = rootView;
}
@end
