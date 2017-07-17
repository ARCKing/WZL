//
//  typeTwoCell.m
//  发发啦
//
//  Created by gxtc on 16/10/21.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "typeTwoCell.h"
#import "UIImageView+WebCache.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface typeTwoCell()

@property(nonatomic,strong)UILabel * titleLabeel;
@property(nonatomic,strong)UILabel * timeLabel;
@property(nonatomic,strong)UILabel * readLabel;

@property(nonatomic,strong)UIImageView * imgView1;
@property(nonatomic,strong)UIImageView * imgView2;
@property(nonatomic,strong)UIImageView * imgView3;
@property (nonatomic,strong)UILabel * hight_money;

@end


@implementation typeTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.titleLabeel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_W - 20, SCREEN_W/20)];
        self.titleLabeel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLabeel];
        
        
        self.imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLabeel.frame)+5, (SCREEN_W - 40)/3, SCREEN_W/5)];
        [self.contentView addSubview:self.imgView1];
//        self.imgView1.layer.cornerRadius = 4;
//        self.imgView1.clipsToBounds = YES;
        
        self.imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_W - 40)/3 + 20, CGRectGetMaxY(self.titleLabeel.frame)+5, (SCREEN_W - 40)/3, SCREEN_W/5)];
        [self.contentView addSubview:self.imgView2];
//        self.imgView2.layer.cornerRadius = 4;
//        self.imgView2.clipsToBounds = YES;
        
        self.imgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(2 *(SCREEN_W - 40)/3 + 30, CGRectGetMaxY(self.titleLabeel.frame)+5, (SCREEN_W - 40)/3, SCREEN_W/5)];
//        self.imgView3.layer.cornerRadius = 4;
//        self.imgView3.clipsToBounds = YES;
        [self.contentView addSubview:self.imgView3];

        self.readLabel = [[UILabel alloc ]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.imgView1.frame), 100, 20)];
        [self.contentView addSubview:self.readLabel];
        self.readLabel.font = [UIFont systemFontOfSize:13];
        self.readLabel.textColor = [UIColor lightGrayColor];
        
        self.timeLabel = [[UILabel alloc ]initWithFrame:CGRectMake(SCREEN_W - 10 - 100, CGRectGetMaxY(self.imgView1.frame), 100, 20)];
        [self.contentView addSubview:self.timeLabel];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textColor = [UIColor lightGrayColor];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        
        
        self.hight_money =[[ UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.imgView1.frame)-15, 100, 15)];
        self.hight_money.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        self.hight_money.textAlignment = NSTextAlignmentCenter;
        self.hight_money.textColor = [UIColor lightGrayColor];
        self.hight_money.backgroundColor = [UIColor redColor];
        self.hight_money.textColor = [UIColor whiteColor];

        [self.contentView addSubview:self.hight_money];
    }

    return self;
}


- (void)setModel:(articleOneTypeModel *)model{

    self.titleLabeel.text = model.title;
    [self.imgView1 sd_setImageWithURL:[NSURL URLWithString:model.imgUrl1] placeholderImage:[UIImage imageNamed:@"load.png"]];
    [self.imgView2 sd_setImageWithURL:[NSURL URLWithString:model.imgUrl2] placeholderImage:[UIImage imageNamed:@"load.png"]];
    [self.imgView3 sd_setImageWithURL:[NSURL URLWithString:model.imgUrl3] placeholderImage:[UIImage imageNamed:@"load.png"]];

    self.readLabel.text = [NSString stringWithFormat:@"阅读:%@",model.view_count];
    
//    NSArray * currentTimeArray = [self getCurrentTime];
//    NSArray * articleTimeArray = [self articleTime:model.addtime];
//    
//    self.timeLabel.text = [self compareTimeNewTime:currentTimeArray andYetTime:articleTimeArray];

    self.timeLabel.text = [self finallyTime:model.addtime];
    
    if ([model.height_money isEqualToString:@"0"]|| [model.height_money isEqualToString:@"(null)"]) {
//        self.hight_money.alpha = 0;
        self.hight_money.hidden = YES;


    }else{
//        self.hight_money.alpha = 1;
        self.hight_money.hidden = NO;

        self.hight_money.text = [NSString stringWithFormat:@"转发%@元/阅读",model.height_money];
        [self.hight_money sizeToFit];

    }
}


- (void)setModel1:(articleModel *)model1{


    self.titleLabeel.text = model1.title;
    [self.imgView1 sd_setImageWithURL:[NSURL URLWithString:model1.thumb] placeholderImage:[UIImage imageNamed:@"load.png"]];
    [self.imgView2 sd_setImageWithURL:[NSURL URLWithString:model1.thumb_1] placeholderImage:[UIImage imageNamed:@"load.png"]];
    [self.imgView3 sd_setImageWithURL:[NSURL URLWithString:model1.thumb_2] placeholderImage:[UIImage imageNamed:@"load.png"]];
    
    self.readLabel.text = [NSString stringWithFormat:@"阅读:%@",model1.view_count];
    
//    NSArray * currentTimeArray = [self getCurrentTime];
//    NSArray * articleTimeArray = [self articleTime:model1.addtime];
    
//    self.timeLabel.text = [self compareTimeNewTime:currentTimeArray andYetTime:articleTimeArray];

    
      self.timeLabel.text = [self finallyTime:model1.addtime];
    
    if ([model1.height_money isEqualToString:@"0"]|| [model1.height_money isEqualToString:@"(null)"]) {
//        self.hight_money.alpha = 0;
        self.hight_money.hidden = YES;

        
    }else{
//        self.hight_money.alpha = 1;
        self.hight_money.hidden = NO;

        self.hight_money.text = [NSString stringWithFormat:@"转发%@元/阅读",model1.height_money];
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
    
    NSLog(@"%@",dateStr);
    
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









@end
