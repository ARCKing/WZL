//
//  oneTypeCell.m
//  发发啦
//
//  Created by gxtc on 16/9/13.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "oneTypeCell.h"
#import "UIImageView+WebCache.h"
@interface oneTypeCell()



@end

@implementation oneTypeCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

}


- (void)setModel:(shareEarnModel *)model{

    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"load.png"]];

    self.titleLabel.text = model.title;
    self.titleLabel2.text = model.sort;

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
