//
//  bottomArticleCell.m
//  发发啦
//
//  Created by gxtc on 16/10/28.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "bottomArticleCell.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface bottomArticleCell()
@property(nonatomic,strong)UIImageView * iconImgView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIView * bgView;

@property(nonatomic,strong)UILabel * articleTitleLabel;
@property(nonatomic,strong)UIImageView * img1;
@property(nonatomic,strong)UIImageView * img2;
@property(nonatomic,strong)UIImageView * img3;

@property(nonatomic,strong)UIButton * button;

@end

@implementation bottomArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.iconImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AppIcon29x29.png"]];
        self.iconImgView.frame = CGRectMake(10, 20, SCREEN_W/10, SCREEN_W/10);
        [self.contentView addSubview:self.iconImgView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImgView.frame)+10, CGRectGetMinY(_iconImgView.frame) - 10,  50, SCREEN_W/16)];
        self.titleLabel.text = @"微转啦";
        [self.contentView addSubview:self.titleLabel];

        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImgView.frame), CGRectGetMaxY(_titleLabel.frame)+5, SCREEN_W * 2/3, SCREEN_W/3 + 20)];
        [self.contentView addSubview:self.bgView];
        
        
        self.articleTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.contentView addSubview:self.articleTitleLabel];
    }


    return self;

}












- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
