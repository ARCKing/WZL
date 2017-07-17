//
//  DetailMessageVC.m
//  发发啦
//
//  Created by gxtc on 16/9/12.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "DetailMessageVC.h"
#import "NetWork.h"
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface DetailMessageVC ()

@property(nonatomic,retain)UIView * navView;

@property(nonatomic,retain)UILabel * titleLabel;
@property(nonatomic,retain)UILabel * timeLabel;

@property(nonatomic,retain)UILabel * detailLabel;

@property(nonatomic,strong)UIScrollView * screeView;


@end

@implementation DetailMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self navViewCreat];
    
    [self screeViewCreat];
    
    [self getNetWork];
}

#pragma mark- navViewCreat
- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    [self.view addSubview:button];
#pragma mark- button.tag-3000
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"我的消息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}


#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    
        [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark- screeViewCreat
- (void)screeViewCreat{

    UIScrollView *  scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64)];
    scrollView.contentSize = CGSizeMake(0, SCREEN_H - 63);
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_W, 30)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = @"";
    [scrollView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    
    UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame), SCREEN_W, 30)];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.text = @"";
    [scrollView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(timeLabel.frame), SCREEN_W, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:line];
    
    
    UILabel * detailleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame)+10, SCREEN_W, SCREEN_H)];
    detailleLabel.textColor = [UIColor blackColor];
    detailleLabel.font = [UIFont systemFontOfSize:15];
    detailleLabel.textAlignment = NSTextAlignmentLeft;
    detailleLabel.text = @"";
    detailleLabel.numberOfLines = 0;
    [scrollView addSubview:detailleLabel];
    
    self.detailLabel = detailleLabel;
    
}




#pragma mark- 网络请求
- (void)getNetWork{

    NetWork * net = [[NetWork alloc]init];

    [net systemMessageDetail:self.id_];
    
    __weak DetailMessageVC * weakSelf = self;
    
    net.systemMessageDetail=^(NSString * title,NSString * ptime,NSString * content){
    
        weakSelf.titleLabel.text = title;
        
        weakSelf.timeLabel.text = [weakSelf ptime:ptime];
        
        
        weakSelf.detailLabel.text = [NSString stringWithFormat:@"  %@",content];
        [weakSelf.detailLabel sizeToFit];
    };
    
    
}


- (NSString *)ptime:(NSString *)times{

    NSString *str=times;//时间戳
    //    NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSTimeInterval time=[str doubleValue];
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];

    return currentDateStr;
}


@end
