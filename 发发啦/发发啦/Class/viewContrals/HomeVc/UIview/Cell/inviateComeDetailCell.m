//
//  inviateComeDetailCell.m
//  inComeDetailDemo
//
//  Created by gxtc on 16/8/25.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "inviateComeDetailCell.h"

@interface inviateComeDetailCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *money1;
@property (weak, nonatomic) IBOutlet UILabel *money2;

@end

@implementation inviateComeDetailCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

}


- (void)setModel:(inviteProFitModel *)model{

    
    
    
    
    
    self.nameLabel.text = model.nickname;
    self.money1.text = model.inviter_money;
    self.money2.text = model.money;
    
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



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
