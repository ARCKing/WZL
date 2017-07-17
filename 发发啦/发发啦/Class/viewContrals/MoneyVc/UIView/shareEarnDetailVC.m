//
//  shareEarnDetailVC.m
//  发发啦
//
//  Created by gxtc on 16/11/8.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "shareEarnDetailVC.h"
#import "UIImageView+WebCache.h"
#import "NetWork.h"
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width



@interface shareEarnDetailVC ()
@property(nonatomic,retain)UIView * navView;
@property(nonatomic,retain)UIScrollView * scrollView;
@property(nonatomic,retain)UIActivityViewController * activity;


@property(nonatomic,retain)UIView * bgView1;
@property(nonatomic,retain)UIImageView * bgView2;
@property(nonatomic,retain)UIView * bgView3;

@property(nonatomic,strong)UIButton * shareButton;

@end

@implementation shareEarnDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    [self navViewCreat];
    [self creatBgView1];
    [self creatBgView2];
    [self creatBgView3];
    [self creatShareButton];
    
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
    titleLabel.text = self.model.title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49)];
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_H - 64 - 48);
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor whiteColor];
}



- (void)creatBgView1{

    self.bgView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W/4)];
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/4, SCREEN_W/5)];
    imgView.center = CGPointMake(SCREEN_W/8 + 10, SCREEN_W/8);
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.model.thumb]];
    self.shareImage = imgView.image;
    [self.bgView1 addSubview:imgView];

    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame) + 5, CGRectGetMinY(imgView.frame) + 20, SCREEN_W/2, 20)];
    titleLabel.text = self.model.title;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    [self.bgView1 addSubview:titleLabel];
    
    UILabel * titleLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame) + 5, CGRectGetMidY(titleLabel.frame)+5, SCREEN_W/2, 20)];
    titleLabel2.text = self.model.sort;
    titleLabel2.textColor = [UIColor lightGrayColor];
    titleLabel2.font = [UIFont systemFontOfSize:12];
    [self.bgView1 addSubview:titleLabel2];
    
    UILabel * titleLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0,0, SCREEN_W/5, SCREEN_W/5)];
    titleLabel3.center = CGPointMake(SCREEN_W - SCREEN_W/10 - 10, SCREEN_W/8);
    titleLabel3.text = [NSString stringWithFormat:@"+%@元",self.model.money];
    titleLabel3.textColor = [UIColor redColor];
    titleLabel3.font = [UIFont systemFontOfSize:20];
    [self.bgView1 addSubview:titleLabel3];

    [self.scrollView addSubview:self.bgView1];
    
}


- (void)creatBgView2{
    
    self.bgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bgView1.frame), SCREEN_W, SCREEN_W * 3 /4)];
    self.bgView2.image = [UIImage imageNamed:@"share00.png"];
    
    [self.scrollView addSubview:self.bgView2];
}


- (void)creatBgView3{
    
    self.bgView3 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bgView2.frame), SCREEN_W, SCREEN_W/3)];
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 30)];
    title.text = @"任务介绍";
    title.font = [UIFont systemFontOfSize:18];
    title.textColor = [UIColor blackColor];
    [self.bgView3 addSubview:title];
    
    
    UILabel * title2 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(title.frame) + 10, SCREEN_W - 20, 30)];
    title2.numberOfLines = 0;
    title2.text = self.model.sort;
    title2.font = [UIFont systemFontOfSize:16];
    title2.textColor = [UIColor lightGrayColor];
    [self.bgView3 addSubview:title2];
    
    [self.scrollView addSubview:self.bgView3];
}



- (void)creatShareButton{

    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareButton.backgroundColor = [UIColor orangeColor];
    [self.shareButton setTitle:@"分享" forState:UIControlStateNormal];
    self.shareButton.frame = CGRectMake(0, 0, SCREEN_W - 80, SCREEN_W/8);
    self.shareButton.center = CGPointMake(SCREEN_W/2, SCREEN_H - SCREEN_W/16 - 10);
    [self.shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shareButton];
    self.shareButton.layer.cornerRadius = 10;
    self.shareButton.clipsToBounds = YES;
}


#pragma mark- 拉起分享
- (void)shareButtonAction{
    
    NSLog(@"分享------");
    
//        NSURL * shareURL = [NSURL URLWithString:@""];
    
    if (self.shareImage) {
        
        NSArray * activityIteam;

        __weak shareEarnDetailVC * weakSelf = self;

        activityIteam = @[self.shareImage];
    
        self.activity = [[UIActivityViewController alloc]initWithActivityItems:activityIteam applicationActivities:nil];
    
        [self presentViewController:_activity animated:YES completion:nil];
    
        self.activity.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError){
        
        
            if (completed) {
            NSLog(@"分享成功!");
                
                NetWork * net = [[NetWork alloc]init];
                
                [net shareEatnSucceeds:weakSelf.model];
                
                net.shareEarnSucceed=^(NSString * code,NSString * message){
                
                    
                    if ([code isEqualToString:@"1"]) {
                        
                        [weakSelf performSelector:@selector(showFinishView:) withObject:message];
                    
                    }
                };
                
                
            }else{
            
            NSLog(@"分享失败!");
            }
        };
        
        
    }
}



//完成任务提示
- (void)showFinishView:(NSString *)message{
    
    UIView * view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.tag = 1221;
    view.backgroundColor = [UIColor colorWithRed:36/255.0 green:38/255.0 blue:47/255.0 alpha:0.7];
    
    [self.view addSubview:view];
    
    UIImageView * imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/2, SCREEN_W/2)];
    imgV.center = CGPointMake(SCREEN_W/2, SCREEN_H/2 - 20);
    imgV.image = [UIImage imageNamed:@"tip_bg_star.png"];
    [view addSubview:imgV];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/2, 20)];
//    label.text = @"稍后请在明细里查看收益";
    label.text = message;
    label.font = [UIFont systemFontOfSize:13];
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(imgV.frame));
    label.layer.cornerRadius = 15;
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    
    UIButton * xxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    xxButton.frame = CGRectMake(CGRectGetMaxX(imgV.frame) - SCREEN_W/8, CGRectGetMinY(imgV.frame) + SCREEN_W/10, 30, 30);
    [xxButton setImage:[UIImage imageNamed:@"close_black.png"] forState:UIControlStateNormal];
    [xxButton addTarget:self action:@selector(xxButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:xxButton];
}


- (void)xxButtonAction{
    
    UIView * view = (UIView *)[self.view viewWithTag:1221];
    [view removeFromSuperview];
}



- (void)buttonAction:(UIButton *)bt{

    [self.navigationController popViewControllerAnimated:YES];

}

@end
