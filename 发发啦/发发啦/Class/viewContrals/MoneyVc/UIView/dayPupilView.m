//
//  dayPupilView.m
//  发发啦
//
//  Created by gxtc on 16/9/13.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "dayPupilView.h"
#import "NetWork.h"
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface dayPupilView()
@property(nonatomic,strong)UIView * view1;
@property(nonatomic,strong)UIView * view2;
@property(nonatomic,strong)UIView * view3;
@property(nonatomic,strong)UIView * view4;

@property(nonatomic,strong)UILabel * notesLabel;


@property(nonatomic,strong)UIImageView * imageView;

@property(nonatomic,strong)UIImageView * imag;

@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * detailLabel;
@property(nonatomic,strong)UILabel * moneyLabel;

@property(nonatomic,strong)UILabel * tuDiNumber;

@property(nonatomic,strong)UIButton * fuliButton;

@property(nonatomic,strong)UIScrollView * scrollView;

@property(nonatomic,retain)UIView * navView;

@property(nonatomic,strong)UILabel * count;
@property(nonatomic,strong)UILabel * num;
@property(nonatomic,strong)UILabel * money;
@property(nonatomic,strong)UILabel * money1;
@property(nonatomic,strong)UILabel * vaildTuDi;

@property(nonatomic,strong)UIView * aleartViewEnter;
@end


@implementation dayPupilView


- (instancetype)initWithFrame:(CGRect)frame AndButtonTag:(NSInteger)tag andMoney:(NSString *)money andType:(NSString *)type{

    self.type = type;
    
    NSArray * iconArray = @[@"task_recruit_day.png",@"task_recruit_day.png",@"task_recruit_day.png"];
    NSArray * titleArray = @[@"每日收徒",@"每周收徒",@"每月收徒"];

    NSArray * detailArray = @[@"每日现金福利等你拿",@"每周现金福利等你拿",@"月现金福利等你拿"];
    
    NSArray * descriptionArray = @[@"每日收徒弟2个，并且登录微转啦APP完成新手福利，即可额外获得",@"每周一到周日收徒弟20个，并且登录微转啦APP完成新手福利，即可额外获得",@"每月1号为起点，当月收徒弟60个，并且登录微转啦APP完成新手福利，即可额外获得"];

    if (self = [super initWithFrame:frame]) {
        
        [self navViewCreat:titleArray[tag - 100]];
        
        [self view1CreatwithIcon:iconArray[tag - 100] andTitle1:titleArray[tag - 100] andTitle2:detailArray[tag - 100] andMoney:money];
        
        [self view2CreatwithTitle:descriptionArray[tag -100] andMoney:money];
        
        [self view3CreatwithMoney:money withTag:tag];
        
        [self notesLabelCreat];
        
        [self shouTuFiststep];
        
        [self creatScrollView];

        [self getData];
    }


    return self;
}


#pragma mark-请求数据
- (void)getData{

    NetWork * net = [[NetWork alloc]init];
    
    [net shouTuOfType:self.type];
    
    __weak dayPupilView * weakSelf = self;
    
    net.shoutu=^(NSString * count,NSString * num,NSString * money,NSString * youxiao){
    
        weakSelf.count.text = count;
        weakSelf.money.text = [NSString stringWithFormat:@"￥%@元",money];
        weakSelf.money1.text = [NSString stringWithFormat:@"%@%@元",weakSelf.money1.text,money];
        weakSelf.vaildTuDi.text = [NSString stringWithFormat:@"%@",youxiao];
    };
    
}


#pragma mark- navViewCreat
- (void)navViewCreat:(NSString *)title{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [button setTitle:@"<–" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    //    button.backgroundColor = [UIColor redColor];
    [self addSubview:button];
#pragma mark- button.tag-3000
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}


#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{

    self.back();
}


#pragma mark- scrollView
- (void)creatScrollView{

    CGFloat high = self.view1.frame.size.height +  self.view2.frame.size.height +  self.view3.frame.size.height + self.notesLabel.frame.size.height + self.view4.frame.size.height;
    
    NSLog(@"%lf",self.imageView.frame.size.height);
    NSLog(@"%lf",high);

    UIImage * image1 = [UIImage imageNamed:@"shoutu1.jpg"];
    UIImage * image2 = [UIImage imageNamed:@"shoutu2.jpg"];

   
    
    high +=  SCREEN_H * 2;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(0, high);
    
    [self.scrollView addSubview:self.view1];
    [self.scrollView addSubview:self.view2];
    [self.scrollView addSubview:self.view3];
    [self.scrollView addSubview:self.notesLabel];

    [self.scrollView addSubview:self.view4];


    UIImageView * imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view4.frame), SCREEN_W,SCREEN_H)];
    imageView1.image = image1;
    [self.scrollView addSubview:imageView1];
    
    
    UIImageView * imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView1.frame), SCREEN_W, SCREEN_H)];
    imageView2.image = image2;
    
    [self.scrollView addSubview:imageView2];
    
    [self addSubview:self.scrollView];
}


- (void)view1CreatwithIcon:(NSString *)icon andTitle1:(NSString *)title1 andTitle2:(NSString *)title2  andMoney:(NSString *)money{

    self.view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W/4)];
    self.view1.backgroundColor =[ UIColor whiteColor];
    
    UIImageView * iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/6, SCREEN_W/6)];
    iconImg.center = CGPointMake(SCREEN_W/12 + 10, SCREEN_W/8);
    iconImg.image = [UIImage imageNamed:icon];
    [self.view1 addSubview:iconImg];
    
    UILabel * titleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImg.frame)+10, CGRectGetMinY(iconImg.frame)+5, SCREEN_W/2, 30)];
    titleLabel1.text = title1;
    titleLabel1.textColor =[UIColor blackColor];
    titleLabel1.font = [UIFont systemFontOfSize:16];
    [self.view1 addSubview:titleLabel1];
    
    UILabel * titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImg.frame)+10, CGRectGetMaxY(titleLabel1.frame)+5, SCREEN_W/2, 30)];
    titleLabel2.text = title2;
    titleLabel2.textColor =[UIColor lightGrayColor];
    titleLabel2.font = [UIFont systemFontOfSize:14];
    [self.view1 addSubview:titleLabel2];
    
    UILabel * moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/5, SCREEN_W/5)];
    moneyLabel.center = CGPointMake(SCREEN_W - SCREEN_W/10 - 10, SCREEN_W/8);
    moneyLabel.text = [NSString stringWithFormat:@"￥%@元",money];
    moneyLabel.textColor =[UIColor redColor];
    moneyLabel.font = [UIFont systemFontOfSize:20];
    [self.view1 addSubview:moneyLabel];

    self.money = moneyLabel;
    
}

- (void)view2CreatwithTitle:(NSString *)title andMoney:(NSString *)money{
    self.view2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view1.frame), SCREEN_W, SCREEN_W/3)];
    self.view2.backgroundColor = [ UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:245/255.0];
    
    UILabel * titleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, SCREEN_W/4, 30)];
    titleLabel1.text = @"活动说明";
    titleLabel1.textColor =[UIColor blackColor];
    titleLabel1.font = [UIFont systemFontOfSize:18];
    [self.view2 addSubview:titleLabel1];
    
    UILabel * titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel1.frame)+5, SCREEN_W - 40, 40)];
    titleLabel2.text = [NSString stringWithFormat:@"%@",title];
    titleLabel2.numberOfLines = 0;
    titleLabel2.textColor =[UIColor lightGrayColor];
    titleLabel2.font = [UIFont systemFontOfSize:15];
    [self.view2 addSubview:titleLabel2];
    
    self.money1 = titleLabel2;
}


- (void)view3CreatwithMoney:(NSString *)money withTag:(NSInteger)tag{
    
    self.view3 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view2.frame), SCREEN_W, SCREEN_W/2)];
    self.view3.backgroundColor =[ UIColor whiteColor];
    
    
    UILabel * titleLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/5, 20, SCREEN_W/4, 30)];
    titleLabel1.text = @"已收徒弟";
//    titleLabel1.center = CGPointMake(SCREEN_W/2, 50);
    titleLabel1.textColor =[UIColor blackColor];
    titleLabel1.font = [UIFont systemFontOfSize:18];
    [self.view3 addSubview:titleLabel1];
    
    
    UILabel * titleLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/5, CGRectGetMaxY(titleLabel1.frame) + 5, SCREEN_W/4, 30)];
    titleLabel3.text = @"有效徒弟";
//    titleLabel3.center = CGPointMake(SCREEN_W/2, 50);
    titleLabel3.textColor =[UIColor blackColor];
    titleLabel3.font = [UIFont systemFontOfSize:18];
    [self.view3 addSubview:titleLabel3];

    
    UILabel * titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel1.frame), CGRectGetMinY(titleLabel1.frame), SCREEN_W /3, 30)];
    titleLabel2.text = [NSString stringWithFormat:@"%@",money];
    titleLabel2.numberOfLines = 0;
    //    titleLabel2.center = CGPointMake(SCREEN_W/2, SCREEN_W/4);
    titleLabel2.textColor =[UIColor redColor];
    titleLabel2.font = [UIFont systemFontOfSize:25];
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    [self.view3 addSubview:titleLabel2];
    
    self.count = titleLabel2;
    
    UILabel * titleLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel3.frame), CGRectGetMinY(titleLabel3.frame), SCREEN_W /3, 30)];
    titleLabel4.text = [NSString stringWithFormat:@"%@",money];
    titleLabel4.numberOfLines = 0;
//    titleLabel4.center = CGPointMake(SCREEN_W/2, SCREEN_W/4);
    titleLabel4.textColor =[UIColor redColor];
    titleLabel4.font = [UIFont systemFontOfSize:25];
    titleLabel4.textAlignment = NSTextAlignmentCenter;
    [self.view3 addSubview:titleLabel4];
    self.vaildTuDi = titleLabel4;

    
    self.fuliButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fuliButton.frame = CGRectMake(0, 0, SCREEN_W - 100, SCREEN_W/9);
    self.fuliButton.center = CGPointMake(SCREEN_W/2, SCREEN_W/2 - SCREEN_W/8);
    [self.fuliButton setTitle:@"领取福利" forState:UIControlStateNormal];
    [self.fuliButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.fuliButton.backgroundColor = [UIColor redColor];
    [self.view3 addSubview:self.fuliButton];
    self.fuliButton.tag = tag;
    self.fuliButton.layer.cornerRadius = 5;
    self.fuliButton.clipsToBounds = YES;
    [self.fuliButton addTarget:self action:@selector(fuLiButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
   
    
}



#pragma mark- 注意事项
- (void)notesLabelCreat{
    
    UILabel * notesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view3.frame), SCREEN_W, SCREEN_W/8)];
    notesLabel.text = @"注:完成活动后请尽快领取福利，逾期作废";
    notesLabel.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    notesLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    notesLabel.font = [UIFont systemFontOfSize:14];
    notesLabel.textAlignment = NSTextAlignmentCenter;
    self.notesLabel = notesLabel;
}


#pragma mark- 收徒步骤
- (void)shouTuFiststep{

    self.view4 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.notesLabel.frame), SCREEN_W, SCREEN_W/3)];
    self.view4.backgroundColor =[ UIColor whiteColor];

    
    UILabel * label = [[UILabel alloc]init];
    label.text = @"请看邀请好友具体步骤:";
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    label.frame = CGRectMake(10, 10, SCREEN_W, 30);
    [self.view4 addSubview:label];
    
    
    UILabel * label1 = [[UILabel alloc]init];
    label1.frame = CGRectMake(10, CGRectGetMaxY(label.frame), SCREEN_W, 30);
    [self.view4 addSubview:label1];
    label1.font = [UIFont systemFontOfSize:14];
    
    
    UILabel * label2 = [[UILabel alloc]init];
    label2.frame = CGRectMake(10, CGRectGetMaxY(label1.frame), SCREEN_W, 30);
    [self.view4 addSubview:label2];
    label2.font = [UIFont systemFontOfSize:14];

    NSMutableAttributedString * abString1 = [[NSMutableAttributedString alloc]initWithString:@"第一步：点击微转啦APP进入后，点击下方'邀请'."];
     NSMutableAttributedString * abString2 = [[NSMutableAttributedString alloc]initWithString:@"第二步：进入'邀请页面'后点击下方的'立即收徒."];
    
    [abString1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    [abString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(0, 3)];
    
    [abString2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    [abString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13] range:NSMakeRange(0, 3)];
    
    label1.attributedText = abString1;
    label2.attributedText = abString2;
    
    
}

#pragma mark- 领取福利
- (void)fuLiButtonAction:(UIButton *)bt{

    if (bt.tag == 100) {
        
        NSLog(@"每日");
        
        NetWork * net = [[NetWork alloc]init];
        
        [net shouTuGift:@"1"];
        __weak dayPupilView * weakSelf = self;

        net.shoutuGift=^(NSString * message,NSString * money,NSString * num,NSString * youxiao){
        
            [weakSelf aleartShow:message and:money];

        };
        
    }else if (bt.tag == 101) {
        NSLog(@"每周");

        NetWork * net = [[NetWork alloc]init];
        
        [net shouTuGift:@"7"];
        
        __weak dayPupilView * weakSelf = self;
        net.shoutuGift=^(NSString * message,NSString * money,NSString * num,NSString * youxiao){
            
            [weakSelf aleartShow:message and:money];

        };
        

        
        
    }else if (bt.tag == 102) {
        NSLog(@"每月");
        
        NetWork * net = [[NetWork alloc]init];
        
        [net shouTuGift:@"30"];
        __weak dayPupilView * weakSelf = self;

        net.shoutuGift=^(NSString * message,NSString * money,NSString * num,NSString * youxiao){
            
            [weakSelf aleartShow:message and:money];
        };
        

    }
    
}




- (void)aleartShow:(NSString *)message and:(NSString *)money{

    if (self.aleartViewEnter == nil) {
        
        self.aleartViewEnter = [[UIView alloc]initWithFrame:self.bounds];
    }
    
    self.aleartViewEnter.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.aleartViewEnter.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor;
    self.aleartViewEnter.layer.shadowOffset = CGSizeMake(0, 0);
    self.aleartViewEnter.layer.shadowOpacity = 1;
    [self addSubview:self.aleartViewEnter];
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W - 60, SCREEN_H/4)];
    view.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);
    [self.aleartViewEnter addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_W-20)/3, SCREEN_H/12)];
    title.center = CGPointMake(view.frame.size.width/2, SCREEN_H/24);
    title.text = @"微转啦";
    title.textColor = [UIColor blackColor];
    title.backgroundColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [view addSubview:title];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H/15, SCREEN_W - 60, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line];
    
    UILabel * detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(line.frame), SCREEN_W - 60 -30, SCREEN_W/2)];
    detailLabel.text = message;
    detailLabel.font = [UIFont systemFontOfSize:15];
    detailLabel.numberOfLines = 0;
    detailLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:detailLabel];
    [detailLabel sizeToFit];
    
    UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(0, 0, SCREEN_W/2, SCREEN_W/10);
    sureButton.center = CGPointMake((SCREEN_W - 60)/2, CGRectGetMaxY(detailLabel.frame) + SCREEN_W/8);
    
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.tag = 5500;
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    sureButton.clipsToBounds = YES;
    sureButton.layer.cornerRadius = 10;
    sureButton.backgroundColor = [UIColor orangeColor];
    [view addSubview:sureButton];
    
    [sureButton addTarget:self action:@selector(aleartViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];


}



- (void)aleartViewButtonAction:(UIButton *)bt{
    
    [self.aleartViewEnter removeFromSuperview];
}




@end
