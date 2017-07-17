//
//  RankCellTableViewCell.m
//  发发啦
//
//  Created by gxtc on 16/8/27.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "RankCellTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface RankCellTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;


@property (weak, nonatomic) IBOutlet UILabel *readNumber;

@property (weak, nonatomic) IBOutlet UILabel *shareLabel;

@end
@implementation RankCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(articleRankModel *)model{

    self.titleLabel.text = model.title;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"load.png"]];
    self.readNumber.text = [NSString stringWithFormat:@"%@",model.view_count];
    self.shareLabel.text = model.addtime;
}

@end
