//
//  ChoosePhoController.h
//  testPhoto
//
//  Created by WHISPERS on 2017/7/25.
//  Copyright © 2017年 WHISPERS. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void (^sendArrblock)(NSMutableArray *photoArray);
@interface ChoosePhoController : UIViewController
@property (nonatomic, copy) NSString *sendStr;
@property (nonatomic,copy) sendArrblock block;
- (void)PhotoArray:(sendArrblock)block;

/*
 number     上传的最大数量
 
 */
- (void)sendStrFunc:(CGSize)size maxNumber:(int)maxNumber showNumber:(int)showNumber;


@end
