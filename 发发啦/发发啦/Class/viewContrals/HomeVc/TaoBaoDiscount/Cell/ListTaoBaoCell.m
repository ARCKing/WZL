//
//  ListTaoBaoCell.m
//  发发啦
//
//  Created by gxtc on 2017/8/3.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "ListTaoBaoCell.h"
#import "UIImageView+WebCache.h"
@interface ListTaoBaoCell()

@property (weak, nonatomic) IBOutlet UILabel *headTitle;

@property (weak, nonatomic) IBOutlet UILabel *skyCat;

@property (weak, nonatomic) IBOutlet UILabel *sellCount;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet UIImageView *icon_image;

@end

@implementation ListTaoBaoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(TaoBaoDiscountClassifyListModel *)model{

    [self.icon_image sd_setImageWithURL:[NSURL URLWithString:model.itempic] placeholderImage:nil];

    self.headTitle.text = model.itemtitle;
    
    self.skyCat.text = [NSString stringWithFormat:@"天猫价:%@元",model.itemprice];
    
    self.money.text = [NSString stringWithFormat:@"%@元",model.itemendprice];
    
    self.discount.text = [NSString stringWithFormat:@"￥%@",model.couponmoney];
    
    self.sellCount.text = [NSString stringWithFormat:@"月销%@",model.itemsale];
}

@end
