//
//  MessageCell.m
//  发发啦
//
//  Created by gxtc on 16/9/12.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation MessageCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

}


- (void)setModel:(systemMessageModel *)model{

    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
    
    if ([model.read isEqualToString:@"1"]) {
        self.titleLabel.textColor = [UIColor lightGrayColor];
    }else{
        self.titleLabel.textColor = [UIColor blackColor];
    }
    
    
    NSString *str=model.ptime;//时间戳
//    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval time=[str doubleValue];

    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"MM-dd HH:mm:ss"];

    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];

    self.dateLabel.text = currentDateStr;

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
