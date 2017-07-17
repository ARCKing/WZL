//
//  GrabRedCashView.m
//  发发啦
//
//  Created by gxtc on 16/8/26.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "GrabRedCashView.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width


@interface GrabRedCashView()
@property(nonatomic,retain)UIView * navView;
@property(nonatomic,retain)UIScrollView * scrollView;

@end

@implementation GrabRedCashView

- (void)initCreat{
    [self navViewCreat];
    [self scrollViewcreat];
    [self threeIteamCreat];

}


#pragma mark- navViewCreat
- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    [self addSubview:button];
#pragma mark- button.tag-7000
    button.tag = 7000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"红包群";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 40);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}


#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    
    if (button.tag == 6000) {
        NSLog(@"6000");
         self.groupBlock(button.tag - 6000);
    }else if (button.tag == 6001){
        NSLog(@"6001");
         self.groupBlock(button.tag - 6000);
    }else if (button.tag == 6002){
        NSLog(@"6002");
         self.groupBlock(button.tag - 6000);
    }else if (button.tag == 7000){
        NSLog(@"7000");
        self.backBlock();
    }
    
    
   
    
}

#pragma mark- scrollViewcreat
- (void)scrollViewcreat{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64)];
    [self addSubview:_scrollView];
    
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_H - 63);
    self.scrollView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
}

#pragma mark- threeIteamCreat

- (void)threeIteamCreat{
    
    NSArray * titleArray = @[@"普通群",@"VIP1群",@"VIP2群"];
    NSArray * timeArray = @[@"每日红包抢不停",@"日收益满0.5以上的用户可抢红包",@"日收益满1元以上的用户可抢红包"];
    NSArray * picArray = @[@"packet.png",@"group_vip2.png",@"group_vip3.png"];
    
    for (int i = 0; i < 1; i++) {
        UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(10, i * (100 + 10), (SCREEN_W - 20), 100)];
        bgview.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:bgview];
        
        bgview.layer.cornerRadius = 5;
        bgview.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:199/255.0 blue:60/255.0 alpha:0.5].CGColor;
        bgview.layer.shadowOffset = CGSizeMake(0, 5);
        bgview.layer.shadowOpacity = 0.8;
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        imgView.center = CGPointMake(30 + 10, 50);
        imgView.image =[UIImage imageNamed:picArray[i]];
        [bgview addSubview:imgView];
        
        UILabel * titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10 + CGRectGetMaxX(imgView.frame), 30, 60, 20)];
        titlelabel.text = titleArray[i];
        titlelabel.font = [UIFont systemFontOfSize:15];
        [bgview addSubview:titlelabel];
        
        
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 + CGRectGetMaxX(imgView.frame), CGRectGetMaxY(titlelabel.frame) + 5, 200, 20)];
        timeLabel.text = timeArray[i];
        timeLabel.textColor = [UIColor lightGrayColor];
        timeLabel.font =[UIFont systemFontOfSize:13];
        [bgview addSubview:timeLabel];
        
//        
//        UIImageView * limitImgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titlelabel.frame), 15, 33, 21)];
//        limitImgView.image = [UIImage imageNamed:@"icn_limited.png"];
//        [bgview addSubview:limitImgView];
        
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
#pragma mark- button.tag-5000+i
        button.tag = 6000+ i;
        [bgview addSubview:button];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, SCREEN_W, 100);
        
        
        
    }
    
    
    
}
@end
