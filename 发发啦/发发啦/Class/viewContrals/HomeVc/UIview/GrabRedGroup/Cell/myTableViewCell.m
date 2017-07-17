//
//  myTableViewCell.m
//  hongbaoGroup
//
//  Created by gxtc on 16/9/2.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

#import "myTableViewCell.h"


@interface myTableViewCell()


@property(nonatomic,strong)UILabel * timeLabel;

@property(nonatomic,strong)UIImageView * iconImageView;
@property(nonatomic,strong)UILabel * nameLabel;

@property(nonatomic,strong)UIImageView * redImageView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * littlelabel;
@property(nonatomic,strong)UILabel * titleLabel2;



@property(nonatomic,strong)UILabel * attributeLabel1;
@property(nonatomic,strong)UILabel * attributeLabel2;
@property(nonatomic,strong)UILabel * attributeLabel3;



@end

@implementation myTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];

}



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
        _iconImageView.image = [UIImage imageNamed:@"icon100.png"];
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
        _titleLabel.text = @"午间红包";
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
        
        
        _attributeLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W*2/3, SCREEN_W/15)];
        _attributeLabel1.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(_redImageView.frame)+35);
        _attributeLabel1.backgroundColor = [UIColor lightGrayColor];
//        [self.contentView addSubview:_attributeLabel1];
        _attributeLabel1.layer.cornerRadius = 3;
        _attributeLabel1.clipsToBounds = YES;
        
        _attributeLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W*2/3, SCREEN_W/15)];
        _attributeLabel2.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(_attributeLabel1.frame)+25);
//        [self.contentView addSubview:_attributeLabel2];
        _attributeLabel2.backgroundColor = [UIColor lightGrayColor];
        _attributeLabel2.layer.cornerRadius = 3;
        _attributeLabel2.clipsToBounds = YES;
        
        _attributeLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W*2/3, SCREEN_W/15)];
        _attributeLabel3.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(_attributeLabel2.frame)+25);
//        [self.contentView addSubview:_attributeLabel3];
        _attributeLabel3.backgroundColor = [UIColor lightGrayColor];
        _attributeLabel3.layer.cornerRadius = 3;
        _attributeLabel3.clipsToBounds = YES;
        
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_W/16);
        _button.titleLabel.textAlignment = NSTextAlignmentCenter;
        _button.titleLabel.font = [UIFont systemFontOfSize:14];
//        _button.backgroundColor = [UIColor redColor];
        [_button setTitle:@"查看大家手气" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        
        
//            _button.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(self.contentView.frame) + SCREEN_W/16);
//            [self.contentView addSubview:_button];
        
//        [self.contentView addSubview:_button];
#pragma mark- button.tag-2222
        _button.tag = 2222;
        
        
    }

  
    return self;
}


#pragma mark- 添加信息
//- (void)messageWithTimeLabel:(NSString *)time andtitleLabel:(NSString *)title andCustomer:(NSDictionary *)dict{


//    
//    _timeLabel.text = time;
//    [self showMyString:@"笑傲江湖" andMoney:@"1.00元"];
    
    
//}


- (void)setRedModel:(redModel *)redModel{

    _timeLabel.text = redModel.friendTime;
    _titleLabel.text = redModel.title;
    

}

/** 3人信息 */
- (void)showThreePeople:(NSArray *)peopleArray{

    if (peopleArray.count == 0) {
        
        
        _button.center = CGPointMake(SCREEN_W/2, SCREEN_H/2 - 3 * SCREEN_W/7 + 5);
        [self.contentView addSubview:_button];
        
//        [self.button removeFromSuperview];
        [self.attributeLabel1 removeFromSuperview];
        [self.attributeLabel2 removeFromSuperview];
        [self.attributeLabel3 removeFromSuperview];
        return;
    }else if (peopleArray.count == 1) {
    
        [self.attributeLabel2 removeFromSuperview];
        [self.attributeLabel3 removeFromSuperview];
    
    }else if (peopleArray.count == 2){
        
        [self.attributeLabel3 removeFromSuperview];

    }
    
    
    NSArray * labelArray = @[self.attributeLabel1,self.attributeLabel2,self.attributeLabel3];
    
    NSArray * array = @[@"手气最佳领取了红包",@"幸运星领取了红包",@"手最快领取了红包"];
    
    NSArray * imgArray = @[[UIImage imageNamed:@"best.png"],[UIImage imageNamed:@"luck.png"],[UIImage imageNamed:@"fast.png"]];
    
    for (int i = 0; i <peopleArray.count && i < 3; i++) {
        
        userRedModel * model = peopleArray[i];
        
        if (model) {
            
            NSString * money = [NSString stringWithFormat:@"%@元",model.money];
            
            if ([model.type isEqualToString:@"2"]) {
                
                [self showWithString:model.nickname andMoney:money andType:array[0] andLabel:labelArray[i] andImg:imgArray[0]];

            }else if ([model.type isEqualToString:@"3"]){

                [self showWithString:model.nickname andMoney:money andType:array[1] andLabel:labelArray[i] andImg:imgArray[1]];

            }else{
                [self showWithString:model.nickname andMoney:money andType:array[2] andLabel:labelArray[i] andImg:imgArray[2]];
            
            }
            
            
        }else{
        
//            [self.button removeFromSuperview];
            [self.attributeLabel1 removeFromSuperview];
            [self.attributeLabel2 removeFromSuperview];
            [self.attributeLabel3 removeFromSuperview];
            
        }
        
    }
    

}


#pragma mark- 添加富文本
- (void)showWithString:(NSString *)name andMoney:(NSString *)money andType:(NSString *)type andLabel:(UILabel *)label andImg:(UIImage *)img{
    
   
    
    //    创建富文本对象
    NSMutableAttributedString * attrstring1 = [[NSMutableAttributedString alloc]initWithString:name];
    
    NSMutableAttributedString * attrstring2 = [[NSMutableAttributedString alloc]initWithString:money];
    
    NSMutableAttributedString * attrstring3 = [[NSMutableAttributedString alloc]initWithString:type];
    

    //获取字符串本身的 ranges.length 与 ranges.location
    NSRange range1 = [name rangeOfString:name];
    NSRange range2 = [money rangeOfString:money];
    NSRange range3 = [type rangeOfString:type];

    NSLog(@"rang3 = %ld %ld",range3.length,range3.location);
    
    //    设置富文本属性-字体-颜色-大小。。。
    [attrstring3 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, range3.length)];
    [attrstring3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, range3.length)];
    
    [attrstring1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, range1.length)];
    [attrstring1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, range1.length)];
    
    [attrstring2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, range2.length)];
    [attrstring2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, range2.length)];
    
    //   label图片对象设置
    NSTextAttachment * attch1 = [[NSTextAttachment alloc]init];
    
    attch1.image = img;
    //    位置
    attch1.bounds = CGRectMake(0, -2, 15,15);
    
    //    转变成富文本对象
    NSAttributedString * imgString1 = [NSAttributedString attributedStringWithAttachment:attch1];
    
    NSLog(@"%ld",range3.length);
    
    if (range3.length > 8) {
        
        [attrstring3 insertAttributedString:attrstring1 atIndex:4];

    }else{
    //    富文本拼接
        [attrstring3 insertAttributedString:attrstring1 atIndex:3];
    }
    
    [attrstring3 appendAttributedString:attrstring2];
    
    [attrstring3 insertAttributedString:imgString1 atIndex:0];
    
    //    显示富文本
    label.attributedText = attrstring3;
    
  

    // 自适应
    
    [label sizeToFit];
 
    [self.contentView addSubview:label];
    
    _button.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(label.frame) + SCREEN_W/16);
    [self.contentView addSubview:_button];

    
    _attributeLabel1.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(self.redImageView.frame) + _attributeLabel1.bounds.size.height + 10);
    _attributeLabel2.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(self.attributeLabel1.frame) + _attributeLabel2.bounds.size.height + 5);
    _attributeLabel3.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(self.attributeLabel2.frame) + _attributeLabel3.bounds.size.height + 5);



}












- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
