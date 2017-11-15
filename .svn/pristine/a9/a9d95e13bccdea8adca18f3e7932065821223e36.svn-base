//
//  TableNewViewController.m
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/9/25.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import "TableNewViewController.h"
#import "TableManagerViewController.h"
#import "EditLabelViewController.h"
#import "BuyTimeViewController.h"
@interface TableNewViewController ()

@end

@implementation TableNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavBarWithTitle:@"餐位管理" isBack:YES];
    self.view.backgroundColor = BACKGrayColor;
    NSArray *titleArray = @[@"编辑餐位",@"用户消费时段",@"修改标签名称"];//
    for (int i = 0; i < titleArray.count; i ++) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,self.navBarView.bottom + (i + 1) *10 + i * 45, SCREEN_WIDTH, 45)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgView];
        
        
        UILabel *tsLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, bgView.height)];
        tsLabel.font = [UIFont systemFontOfSize:13];
        tsLabel.textAlignment = NSTextAlignmentLeft;
        tsLabel.text = titleArray[i];
        [bgView addSubview:tsLabel];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 13.5, 18, 18)];
        img.image = [UIImage imageNamed:@"me_more"];
        [bgView addSubview:img];
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, bgView.width, bgView.height)];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];
        
        
    }
    
}

- (void)buttonAction:(UIButton *)sender
{
    if(sender.tag == 100){//编辑餐位
        TableManagerViewController *tableVC = [[TableManagerViewController alloc]init];
        [self.navigationController pushViewController:tableVC animated:YES];
        
    }else if (sender.tag == 101){//用户消费时段
        BuyTimeViewController *vc = [[BuyTimeViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (sender.tag == 102){//修改标签名称
        EditLabelViewController *vc = [[EditLabelViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
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
