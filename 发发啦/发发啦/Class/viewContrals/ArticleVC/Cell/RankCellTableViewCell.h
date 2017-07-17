//
//  RankCellTableViewCell.h
//  发发啦
//
//  Created by gxtc on 16/8/27.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "articleRankModel.h"
@interface RankCellTableViewCell : UITableViewCell
@property (nonatomic,copy)articleRankModel * model;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end
