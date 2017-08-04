//
//  ListTaoBaoCell.m
//  发发啦
//
//  Created by gxtc on 2017/8/3.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "ListTaoBaoCell.h"

@interface ListTaoBaoCell()

@property (weak, nonatomic) IBOutlet UILabel *headTitle;

@property (weak, nonatomic) IBOutlet UILabel *skyCat;

@property (weak, nonatomic) IBOutlet UILabel *sellCount;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *discount;

@end

@implementation ListTaoBaoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
