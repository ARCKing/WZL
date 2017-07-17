//
//  oneTypeCell.h
//  发发啦
//
//  Created by gxtc on 16/9/13.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shareEarnModel.h"

@interface oneTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;

@property (nonatomic,strong) shareEarnModel * model;

@end
