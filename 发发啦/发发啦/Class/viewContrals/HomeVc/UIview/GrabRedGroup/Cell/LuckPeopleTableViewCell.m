//
//  LuckPeopleTableViewCell.m
//  发发啦
//
//  Created by gxtc on 16/9/12.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "LuckPeopleTableViewCell.h"
#import "UIImageView+WebCache.h"
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width


@interface LuckPeopleTableViewCell ()

@property(nonatomic,strong)UIImageView * bigIcon;
@property(nonatomic,strong)UILabel * nameLabel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UILabel * moneyLabel;

@property(nonatomic,strong)UIImageView * littleIcon;

@property(nonatomic,strong)UILabel * iconTitleLabel;


@end


@implementation LuckPeopleTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.bigIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_W/5, SCREEN_W/5)];
        [self.contentView addSubview:_bigIcon];
        self.bigIcon.layer.cornerRadius = SCREEN_W/10;
        self.bigIcon.clipsToBounds = YES;
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_bigIcon.frame)+10, 20, SCREEN_W/2, 20)];
        [self.contentView addSubview:_nameLabel];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_bigIcon.frame)+10, SCREEN_W/4 - 20 -10, SCREEN_W/2, 20)];
        [self.contentView addSubview:_timeLabel];
        self.timeLabel.font = [UIFont systemFontOfSize:15];
        self.timeLabel.textColor = [UIColor lightGrayColor];

        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W - SCREEN_W/4 - 10, 20, SCREEN_W/4, 20)];
        [self.contentView addSubview:_moneyLabel];
        self.moneyLabel.textAlignment = NSTextAlignmentRight;
        self.moneyLabel.textColor = [UIColor orangeColor];
        
        self.iconTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W - SCREEN_W/6 - 5, SCREEN_W/4 - 20 - 10, SCREEN_W/6, 20)];
        [self.contentView addSubview:_iconTitleLabel];
        self.iconTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.iconTitleLabel.textColor =[UIColor redColor];
        self.iconTitleLabel.font = [UIFont systemFontOfSize:13];
        
        self.littleIcon = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_iconTitleLabel.frame) -17,CGRectGetMinY(_iconTitleLabel.frame)+2,15,15)];
        [self.contentView addSubview:_littleIcon];

        
        
    }
    
    return self;

}


- (void)addDataWithIconImage:(NSString *)iconUrl andUserName:(NSString *)userName andTime:(NSString *)time andMoney:(NSString *)moner andIconTitle:(NSString *)title andLittleIcon:(NSString *)littleIcon{

    
    if ([title isEqualToString:@"手气最佳"]) {
        self.littleIcon.image = [UIImage imageNamed:@"luck.png"];

    }else if ([title isEqualToString:@"幸运星"]){
        self.littleIcon.image = [UIImage imageNamed:@"best.png"];

    }else if ([title isEqualToString:@"手最快"]) {
        self.littleIcon.image = [UIImage imageNamed:@"fast.png"];

    }
    
    [self.bigIcon sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageNamed:@"icon_1.png"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",userName];
    self.timeLabel.text = time;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元",moner];
    self.iconTitleLabel.text = title;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
