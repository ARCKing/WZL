//
//  inComeDetailCell.m
//  inComeDetailDemo
//
//  Created by gxtc on 16/8/25.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "inComeDetailCell.h"

@interface inComeDetailCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *monerLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end


@implementation inComeDetailCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

}


- (void)setModel:(userProFitModel *)model{
    
    if ([model.type isEqualToString:@"3"]) {
        
        self.titleLabel.text = model.title_;

    }else{
    
        self.titleLabel.text = model.remark;
        
    }
    
    self.monerLabel.text = model.money;

    NSString *str=model.addtime;//时间戳
//    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval time=[str doubleValue];

    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];

    self.timeLabel.text = currentDateStr;
}



- (void)setCashModel:(withDrawCashRecordModel *)cashModel{

    self.titleLabel.text = cashModel.bank_name;
    self.monerLabel.text = cashModel.cash_amount;
    
    NSString *str=cashModel.addtime;//时间戳
//    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval time=[str doubleValue];

    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    self.timeLabel.text = currentDateStr;


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
