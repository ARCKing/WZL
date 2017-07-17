//
//  grabMoneyCell.m
//  发发啦
//
//  Created by gxtc on 16/11/5.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "grabMoneyCell.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface grabMoneyCell()

@property(nonatomic,strong)UILabel * timeLabel;

@property(nonatomic,strong)UIImageView * iconImageView;
@property(nonatomic,strong)UILabel * nameLabel;

@property(nonatomic,strong)UIImageView * redImageView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * littlelabel;
@property(nonatomic,strong)UILabel * titleLabel2;

@end

@implementation grabMoneyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/4, SCREEN_W/14)];
        _timeLabel.center = CGPointMake(SCREEN_W/2, 20);
        _timeLabel.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:0.8];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.layer.cornerRadius = 3;
        _timeLabel.clipsToBounds = YES;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_timeLabel];
        
        
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_timeLabel.frame)+10, SCREEN_W/10, SCREEN_W/10)];
        _iconImageView.image = [UIImage imageNamed:@"AppIcon29x29.png"];
        [self.contentView addSubview:_iconImageView];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame)+10, CGRectGetMinY(_iconImageView.frame) - 10, 50, SCREEN_W/16)];
        _nameLabel.textColor = [UIColor lightGrayColor];
        _nameLabel.text = @"微转啦";
        _nameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_nameLabel];
        
        
        _redImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame), CGRectGetMaxY(_nameLabel.frame)+5, SCREEN_W/2, SCREEN_W/4)];
        _redImageView.image = [[UIImage imageNamed:@"red.png"]stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        _redImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_redImageView];
        
        
        //        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/7 , 10, _redImageView.bounds.size.width/2, SCREEN_W/16)];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, _redImageView.bounds.size.width/2, SCREEN_W/16)];
        _titleLabel.center = CGPointMake(_redImageView.bounds.size.width/2 + _redImageView.bounds.size.width/12, _redImageView.bounds.size.height/4);
        _titleLabel.text = @"抢红包...";
        _titleLabel.font = [UIFont systemFontOfSize:13];
        [self.redImageView addSubview:_titleLabel];
        
        
        _titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0,0, _redImageView.bounds.size.width/2, SCREEN_W/16)];
        _titleLabel2.center = CGPointMake(_redImageView.bounds.size.width/2 + _redImageView.bounds.size.width/12, CGRectGetMidY(_titleLabel.frame) + SCREEN_W/20);
        _titleLabel2.text = @"领取红包";
        _titleLabel2.textColor = [UIColor whiteColor];
        _titleLabel2.font = [UIFont systemFontOfSize:14];
        [self.redImageView addSubview:_titleLabel2];
        
        
        
        
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _littlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _redImageView.bounds.size.height - 25, _redImageView.bounds.size.width, SCREEN_W/16)];
        _littlelabel.text = @"每日准点红包";
        _littlelabel.font = [UIFont systemFontOfSize:13];
        _littlelabel.textColor = [UIColor lightGrayColor];
        [_redImageView addSubview:_littlelabel];
        
        _getButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getButton setImage:[UIImage imageNamed:@"packet.png"] forState:UIControlStateNormal];
        //        [_getButton setTitle:@"领取红包" forState:UIControlStateNormal];
        _getButton.frame = CGRectMake(SCREEN_W/21, 0, _redImageView.bounds.size.width , _redImageView.bounds.size.height * 2 / 3);
        //        _getButton.backgroundColor = [UIColor blackColor];
        _getButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        //        _getButton.titleEdgeInsets = UIEdgeInsetsMake(20, 2, 0, 0);
        //        _getButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _getButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_redImageView addSubview:_getButton];
#pragma mark- getbutton.tag-1111
        _getButton.tag = 1111;
    }
    
    return self;
}

    
    
    
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
