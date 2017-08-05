//
//  TaoBaoListDetailCell.m
//  发发啦
//
//  Created by gxtc on 2017/8/5.
//  Copyright © 2017年 gxtc. All rights reserved.
//

#import "TaoBaoListDetailCell.h"

@interface TaoBaoListDetailCell()

@property (weak, nonatomic) IBOutlet UILabel *headTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentMoney;
@property (weak, nonatomic) IBOutlet UILabel *oraingeMoney;
@property (weak, nonatomic) IBOutlet UILabel *discountMoney;
@property (weak, nonatomic) IBOutlet UILabel *monthSaleCount;

@end

@implementation TaoBaoListDetailCell

- (void)setModel:(TaoBaoDiscountClassifyListModel *)model{

    
    

    self.headTitleLabel.text = model.itemtitle;
    self.currentMoney.text = [NSString stringWithFormat:@"￥%@",model.itemendprice];
    self.oraingeMoney.text = [NSString stringWithFormat:@"￥%@",model.itemprice];
    self.discountMoney.text = [NSString stringWithFormat:@"优惠券:%@元",model.couponmoney];
    self.monthSaleCount.text = [NSString stringWithFormat:@"月销%@", model.itemsale];
    

    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.oraingeMoney.frame.size.width, 1)];
    [self.oraingeMoney addSubview:line];
    line.backgroundColor = [UIColor blackColor];
}

@end
