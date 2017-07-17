//
//  InComeRanKCell.h
//  cellDemo
//
//  Created by gxtc on 16/8/18.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "userInComeRankModel.h"

@interface InComeRanKCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rankNumberLabel;

@property(nonatomic,strong)userInComeRankModel * model;


@end
