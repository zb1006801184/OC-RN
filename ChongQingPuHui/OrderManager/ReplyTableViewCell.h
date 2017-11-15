//
//  ReplyTableViewCell.h
//  ChongQingPuHui
//
//  Created by 节庆霞 on 2017/8/27.
//  Copyright © 2017年 节庆霞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReplyTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *jiaoView;
@property (nonatomic,strong)UIView *replyView;
- (void)setDataArray:(NSArray *)array;
@end
