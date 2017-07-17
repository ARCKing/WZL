//
//  InComeRanKCell.m
//  cellDemo
//
//  Created by gxtc on 16/8/18.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "InComeRanKCell.h"
#import "UIImageView+WebCache.h"
@interface InComeRanKCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

//@property (weak, nonatomic) IBOutlet UILabel *rankNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *userNmaerLabel;

@property (weak, nonatomic) IBOutlet UILabel *inComeLabel;


@property (weak, nonatomic) IBOutlet UILabel *prentice_numLabel;


@end

@implementation InComeRanKCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

    
}


- (void)setModel:(userInComeRankModel *)model{

    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.headimgurl] placeholderImage:[UIImage imageNamed:@"icon_1.png"]];

    self.userNmaerLabel.text = model.nickname;
    
    self.inComeLabel.text = model.sum_money;
    
    self.prentice_numLabel.text = [NSString stringWithFormat:@"累计收徒%@名",model.prentice_num];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
