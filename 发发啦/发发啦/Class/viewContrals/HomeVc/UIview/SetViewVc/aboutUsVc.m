//
//  aboutUsVc.m
//  发发啦
//
//  Created by gxtc on 16/11/18.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "aboutUsVc.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface aboutUsVc ()
@property(nonatomic,retain)UIView * navView;

@end

@implementation aboutUsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self navViewCreat];
    
    [self detailMessage];
}



#pragma mark- navViewCreat
- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [button setTitle:@"<–" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    //    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
#pragma mark- button.tag-3000
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"关于微转啦";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}



- (void)detailMessage{

    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon200.png"]];
    imageView.frame = CGRectMake(0, 0, SCREEN_W/5, SCREEN_W/5);
    imageView.center = CGPointMake(SCREEN_W/2, 50 + SCREEN_W/5);
    [self.view addSubview:imageView];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 30)];
    label.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(imageView.frame) + 30);
    label.text = @"微转啦";
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 30)];
    label1.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(label.frame) + 30);
    label1.text = @"热点快讯速达";
    label1.textColor = [UIColor blackColor];
    label1.textAlignment = NSTextAlignmentCenter;
//    label1.font = [UIFont systemFontOfSize:20];

    [self.view addSubview:label1];
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 30)];
    label2.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(label1.frame) + 20);
    label2.text = @"微转啦公众号:微转啦资讯";
    label2.textColor = [UIColor blackColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:16];

    [self.view addSubview:label2];
    
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 30)];
    label3.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(label2.frame)+10);
    label3.text = @"客服电话:13393648224";
    label3.textColor = [UIColor blackColor];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:16];

    [self.view addSubview:label3];
}


- (void)buttonAction:(UIButton *)button{

    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
