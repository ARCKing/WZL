//
//  inComeDetailCell.h
//  inComeDetailDemo
//
//  Created by gxtc on 16/8/25.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userProFitModel.h"
#import "withDrawCashRecordModel.h"
@interface inComeDetailCell : UITableViewCell
@property(nonatomic,strong)userProFitModel * model;
@property(nonatomic,strong)withDrawCashRecordModel * cashModel;
@end
