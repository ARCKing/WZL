//
//  typeOneCell.m
//  发发啦
//
//  Created by gxtc on 16/10/18.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "typeOneCell.h"
#import "UIImageView+WebCache.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface typeOneCell()
@property (nonatomic,strong)UIImageView * iconImageView;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UILabel * sumRead;
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UILabel * hight_money;

@property (nonatomic,strong)UILabel * hight_money2;
@end

@implementation typeOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_W/3, SCREEN_W/4 - 10)];
//        self.iconImageView.layer.cornerRadius = 5;
//        self.iconImageView.clipsToBounds = YES;
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+5, 0, SCREEN_W *2/3 - 15, 60)];
        self.titleLabel.textColor =[ UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.numberOfLines = 0;
        
        self.sumRead = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+5, SCREEN_W/4 - 25, 100, 10)];
        self.sumRead.font = [UIFont systemFontOfSize:13];
        self.sumRead.textColor = [UIColor lightGrayColor];
        
        self.timeLabel =[[ UILabel alloc]initWithFrame:CGRectMake(SCREEN_W - 110, SCREEN_W/4 - 25, 100, 10)];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        self.timeLabel.textColor = [UIColor lightGrayColor];

        
        self.hight_money =[[ UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.iconImageView.frame)-15, SCREEN_W/3, 15)];
        self.hight_money.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        self.hight_money.textAlignment = NSTextAlignmentCenter;
        self.hight_money.textColor = [UIColor lightGrayColor];
        self.hight_money.backgroundColor = [UIColor redColor];
        self.hight_money.textColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.sumRead];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.hight_money];

        
    }

    return self;
}

- (void)setModel:(articleModel *)model{

    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb_1] placeholderImage:[UIImage imageNamed:@"load.png"]];
    self.titleLabel.text = model.title;
    self.sumRead.text =[NSString stringWithFormat:@"阅读:%@",model.view_count];
    
//    NSArray * currentTimeArray = [self getCurrentTime];
//    NSArray * articleTimeArray = [self articleTime:model.addtime];
//
//    self.timeLabel.text = [self compareTimeNewTime:currentTimeArray andYetTime:articleTimeArray];
    
    self.timeLabel.text = [self finallyTime:model.addtime];
        
    if ([model.height_money isEqualToString:@"0"] || [model.height_money isEqualToString:@"(null)"]) {
//        self.hight_money.alpha = 0;
        self.hight_money.hidden = YES;
        
    }else{
//        self.hight_money.alpha = 1;
        self.hight_money.hidden = NO;

        self.hight_money.text = [NSString stringWithFormat:@"转发%@元/阅读",model.height_money];
        [self.hight_money sizeToFit];
    }

}



#pragma mark- 时间戳计算
- (NSString *)finallyTime:(NSString *)yetTime{
    
    NSDate * nowDate = [NSDate date];
    
    NSTimeInterval now = [nowDate timeIntervalSince1970];
    NSTimeInterval yet = [yetTime doubleValue];
    
//    NSLog(@"yet = %.f",yet);
//    NSLog(@"now = %.f",now);
    
    
    NSTimeInterval newTime = now - yet;
//    NSLog(@"new = %.f",newTime);
    
    NSString * mm = [NSString stringWithFormat:@"%.2f",newTime/60];
    NSString * hh = [NSString stringWithFormat:@"%.2f",newTime/60/60];
    NSString * dd = [NSString stringWithFormat:@"%.2f",newTime/60/60/24];
    NSString * MM = [NSString stringWithFormat:@"%.2f",newTime/60/60/24/30];
    
    
//    NSLog(@"mm =%@",mm);
//    NSLog(@"hh =%@",hh);
//    NSLog(@"dd =%@",dd);
//    NSLog(@"MM =%@",MM);
    
    NSString * date;
    
    if ([MM floatValue] >= 1) {
        
        date = [NSString stringWithFormat:@"发布于%.f个月前",[MM floatValue]];
        
    }else if ([dd floatValue] >= 1) {
        
        date = [NSString stringWithFormat:@"发布于%.f天前",[dd floatValue]];
        
    }else if ([hh floatValue] >= 1) {
        
        date = [NSString stringWithFormat:@"发布于%.f小时前",[hh floatValue]];
        
    }else if ([mm floatValue] >= 1) {
        
        date = [NSString stringWithFormat:@"发布于%.f分钟前",[mm floatValue]];
        
    }else {
        
        date = [NSString stringWithFormat:@"发布于%.f秒前",newTime];
    }
    
//    NSLog(@"%@",date);
    
    return date;
}



#pragma mark- 比较时间
- (NSString *)compareTimeNewTime:(NSArray *)now andYetTime:(NSArray *)yet{


    NSInteger month_now = [now[1] integerValue];
    NSInteger day_now = [now[2] integerValue];
    NSInteger hour_now = [now[3] integerValue];
    NSInteger minute_now = [now[4] integerValue];
    NSInteger second_now = [now[5] integerValue];
    
    NSInteger month_yet = [yet[1] integerValue];
    NSInteger day_yet = [yet[2] integerValue];
    NSInteger hour_yet = [yet[3] integerValue];
    NSInteger minute_yet = [yet[4] integerValue];
    NSInteger second_yet = [yet[5] integerValue];
    
    NSInteger month = month_now - month_yet;
    NSInteger day = day_now -day_yet;
    NSInteger hour = hour_now - hour_yet;
    NSInteger minute = minute_now - minute_yet;
    NSInteger second = second_now - second_yet;
    
    
    if (month >0) {
        
        return [NSString stringWithFormat:@"发布于%ld个月前",month];
        
    }else if(day > 0) {
        
        return [NSString stringWithFormat:@"发布于%ld天前",day];
        
    }else if (hour > 0) {
        
        return [NSString stringWithFormat:@"发布于%ld小时前",hour];
        
    }else if (minute > 0) {
        
        return [NSString stringWithFormat:@"发布于%ld分钟前",minute];
    }else{
        
        return [NSString stringWithFormat:@"发布于%ld秒",second];
        
    }
    
    

}


#pragma mark- 文章发布时间
- (NSArray * )articleTime:(NSString *)times{

    NSString *str=times;//时间戳
    //    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval time=[str doubleValue];
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yy:MM:dd:HH:mm:ss"];
    NSString * dateStr = [dateFormatter stringFromDate: detaildate];

    NSArray * timeArray = [dateStr componentsSeparatedByString:@":"];
    
    NSLog(@"%@",timeArray);
    
    return timeArray;


}


#pragma mark- 获取当前时间

- (NSArray *)getCurrentTime{

    NSDate * date = [NSDate date];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yy:MM:dd:HH:mm:ss"];
    
    NSString * currentTime = [formatter stringFromDate:date];
    
    NSLog(@"%@",currentTime);
    
    NSArray * timeArray = [currentTime componentsSeparatedByString:@":"];
    
    NSLog(@"%@",timeArray);

    return timeArray;
}



- (void)setModel2:(articleOneTypeModel *)model2{

    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model2.thumb] placeholderImage:[UIImage imageNamed:@"load.png"]];
    self.titleLabel.text = model2.title;
    self.sumRead.text =[NSString stringWithFormat:@"阅读:%@",model2.view_count];
    
//    NSArray * currentTimeArray = [self getCurrentTime];
//    NSArray * articleTimeArray = [self articleTime:model2.addtime];
//    
//    self.timeLabel.text = [self compareTimeNewTime:currentTimeArray andYetTime:articleTimeArray];
    self.timeLabel.text = [self finallyTime:model2.addtime];
    
    if ([model2.height_money isEqualToString:@"0"] || [model2.height_money isEqualToString:@"(null)"]) {
//        self.hight_money.alpha = 0;
        self.hight_money.hidden = YES;
        self.iconImageView.layer.borderWidth = 0.0;
        
        self.timeLabel.hidden = NO;
        self.hight_money2.hidden = YES;
        
    }else{
//        self.hight_money.alpha = 1;
        self.hight_money.hidden = NO;

        self.hight_money.text = [NSString stringWithFormat:@"高价%@元/分享",model2.height_money];
//        [self.hight_money sizeToFit];

        self.iconImageView.layer.borderWidth = 2.0;
        self.iconImageView.layer.borderColor = [UIColor redColor].CGColor;
        
        self.timeLabel.hidden = YES;
        

        if (self.hight_money2 == nil) {
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W - SCREEN_W/3 - 25, SCREEN_W/5 - 10, SCREEN_W/3 + 15, 15)];
            [self.contentView addSubview:label];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor redColor];
            label.textAlignment = NSTextAlignmentRight;
            label.font = [UIFont systemFontOfSize:14.0];
            self.hight_money2 = label;
        }
        
        self.hight_money2.text = [NSString stringWithFormat:@"高价%@元/分享",model2.height_money];
        
        self.hight_money2.hidden = NO;
        
        
    }
}


- (void)setModel3:(userCollectionArticleModel *)model3{
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model3.thumb] placeholderImage:[UIImage imageNamed:@"load.png"]];
    self.titleLabel.text = model3.title;
    self.sumRead.text =[NSString stringWithFormat:@"阅读:%@",model3.view_count];
    
//    NSArray * currentTimeArray = [self getCurrentTime];
//    NSArray * articleTimeArray = [self articleTime:model3.addtime];
//    
//    self.timeLabel.text = [self compareTimeNewTime:currentTimeArray andYetTime:articleTimeArray];
    self.timeLabel.text = [self finallyTime:model3.addtime];
    self.hight_money.hidden = YES;
}


- (void)setModel4:(guaoGaoModel *)model4{


    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model4.adthumb] placeholderImage:[UIImage imageNamed:@"load.png"]];
    self.titleLabel.text = model4.adtitle;
    self.sumRead.text =[NSString stringWithFormat:@"阅读:%d",(arc4random()%543 + 9999)
];
    
    //    NSArray * currentTimeArray = [self getCurrentTime];
    //    NSArray * articleTimeArray = [self articleTime:model3.addtime];
    //
    //    self.timeLabel.text = [self compareTimeNewTime:currentTimeArray andYetTime:articleTimeArray];
    self.timeLabel.text = [self finallyTime:model4.ctime];

//    self.hight_money.alpha = 0;
    self.hight_money.hidden = YES;


}


- (void)setModel5:(articleOneTypeModel *)model5{

    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model5.adthumb] placeholderImage:[UIImage imageNamed:@"load.png"]];
    self.titleLabel.text = model5.adtitle;
    self.sumRead.text =[NSString stringWithFormat:@"阅读:%d",(arc4random()%543 + 9999)
                        ];
    
    //    NSArray * currentTimeArray = [self getCurrentTime];
    //    NSArray * articleTimeArray = [self articleTime:model3.addtime];
    //
    //    self.timeLabel.text = [self compareTimeNewTime:currentTimeArray andYetTime:articleTimeArray];
    self.timeLabel.text = [self finallyTime:model5.ctime];
    
//    self.hight_money.alpha = 0;
    self.hight_money.hidden = YES;


}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)drawRect:(CGRect)rect{

    NSLog(@"123===>456===>789");
   
}

@end
