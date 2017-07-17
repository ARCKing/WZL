//
//  withDrawCashRecortCell.h
//  发发啦
//
//  Created by gxtc on 16/11/3.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "withDrawCashRecordModel.h"

@interface withDrawCashRecortCell : UITableViewCell
@property(nonatomic,strong)withDrawCashRecordModel * cashModel;
@property(nonatomic,strong)UILabel * reasonLabel;
@property(nonatomic,assign)BOOL isShow;

@property(nonatomic,strong)UIImageView * reasonImgView;

@end
