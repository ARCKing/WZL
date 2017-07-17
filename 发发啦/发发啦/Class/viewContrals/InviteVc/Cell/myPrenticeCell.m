//
//  myPrenticeCell.m
//  发发啦
//
//  Created by gxtc on 16/11/23.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "myPrenticeCell.h"
#import "UIImageView+WebCache.h"
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface myPrenticeCell()

@property(nonatomic,strong)UIImageView * imageV;

@property(nonatomic,strong)UILabel * nickNameLabel;
@property(nonatomic,strong)UILabel * levelLabel;

@property(nonatomic,strong)UIImageView * littleImageView;

@property(nonatomic,strong)UILabel * sumIncomeMoney;

@property(nonatomic,strong)UILabel * timeLabel;

@end


@implementation myPrenticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{


    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/5, SCREEN_W/5)];
        self.imageV.center = CGPointMake(SCREEN_W/10 + 10, SCREEN_W/8);
        self.imageV.layer.cornerRadius = SCREEN_W/10;
        self.imageV.clipsToBounds = YES;
        [self.contentView addSubview:self.imageV];
        
        self.nickNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageV.frame) + 15, 10, SCREEN_W/2, SCREEN_W/15)];
        self.nickNameLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.nickNameLabel];
        
        self.levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageV.frame) + 15, CGRectGetMaxY(self.nickNameLabel.frame), SCREEN_W/7, SCREEN_W/15)];
        self.levelLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.levelLabel];
        self.levelLabel.textColor = [UIColor lightGrayColor];
        self.levelLabel.font = [UIFont systemFontOfSize:14];
        
        self.littleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageV.frame) + 15, CGRectGetMaxY(self.levelLabel.frame)+SCREEN_W/80, SCREEN_W/25, SCREEN_W/25)];
        [self.contentView addSubview:self.littleImageView];

        self.sumIncomeMoney = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.littleImageView.frame) + 10, CGRectGetMaxY(self.levelLabel.frame), SCREEN_W/2, SCREEN_W/15)];
        self.sumIncomeMoney.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.sumIncomeMoney];
        self.sumIncomeMoney.textColor = [UIColor lightGrayColor];
        self.sumIncomeMoney.font = [UIFont systemFontOfSize:14];
        
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.levelLabel.frame) + 10, CGRectGetMaxY(self.nickNameLabel.frame), SCREEN_W *2/3, SCREEN_W/15)];
        self.timeLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.timeLabel];
        self.timeLabel.textColor = [UIColor lightGrayColor];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        
        
    }



    return self;

}


- (void)setModel:(myPrenticeModel *)model{

    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.headimgurl] placeholderImage:[UIImage imageNamed:@"load.png"]];
    self.nickNameLabel.text = [NSString stringWithFormat:@"%@",model.name];
    self.levelLabel.text =[ NSString stringWithFormat:@"等级:%@",model.level];
    self.sumIncomeMoney.text = [NSString stringWithFormat:@"累计收益:%@元",model.sum_money];
    self.littleImageView.image = [UIImage imageNamed:@"home_cash.png"];
    
    NSString * time = [self timeStringWitmAddTime:model.inputtime];
    self.timeLabel.text = [NSString stringWithFormat:@"注册时间:%@",time];
}



- (NSString *)timeStringWitmAddTime:(NSString *)times{

    NSString *str=times;//时间戳
    //    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval time=[str doubleValue];
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yy-MM-dd HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];

    return currentDateStr;
}



@end
