//
//  taskView.m
//  发发啦
//
//  Created by gxtc on 16/9/13.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "taskView.h"
#import "MJRefresh.h"
#import "NetWork.h"
#import "dayTaskModel.h"
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface taskView ()

@property(nonatomic,strong)UIView  *navView;
@property(nonatomic,strong)UIScrollView * scrollView;

@property(nonatomic,strong)UIButton * completeButton;

@property(nonatomic,strong)dayTaskModel * model;

@property(nonatomic,strong)NSMutableArray * imgArray;

@end

@implementation taskView

- (void)initCreat{
    
    self.backgroundColor = [UIColor redColor];
    self.imgArray = [NSMutableArray new];
    
    [self navViewCreat];
    [self scrollViewCreat];
    [self iteamCreat];
    [self greeButtonCreat];
    
    [self completeStatusGetNet];
}


#pragma mark- 完成情况请求
- (void)completeStatusGetNet{

    NetWork * net = [[NetWork alloc]init];

    [net dayTaskAchiveStatus];
    
    __weak taskView * weakSelf = self;
    net.dayTaskStatusBlock=^(dayTaskModel * model){
    
        weakSelf.model = model;
    
        [weakSelf performSelector:@selector(taskSucceed) withObject:nil];
        
    };
    
}


#pragma mark- 打钩
- (void)taskSucceed{


    if ([self.model.share_article isEqualToString:@"1"]) {
        
        UIImageView * imgView = self.imgArray[0];
        imgView.image = [UIImage imageNamed:@"welfare_completed.png"];
        
    }
    
    if ([self.model.invite isEqualToString:@"1"]) {
        UIImageView * imgView = self.imgArray[1];
        imgView.image = [UIImage imageNamed:@"welfare_completed.png"];
    }
    
    if ([self.model.read isEqualToString:@"1"]) {
        UIImageView * imgView = self.imgArray[2];
        imgView.image = [UIImage imageNamed:@"welfare_completed.png"];
    }
    
    if ([self.model.share isEqualToString:@"1"]) {
        UIImageView * imgView = self.imgArray[3];
        imgView.image = [UIImage imageNamed:@"welfare_completed.png"];
    }

    
    [self.scrollView.mj_header endRefreshing];
    
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
#pragma mark- button.tag-3000
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"每日任务";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}


#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    
    if (button.tag == 566000000) {
        NSLog(@"5600");
        
        
    }else if (button.tag == 5661){
        NSLog(@"5661-邀请好友");
        
        self.inviteFriend();
        
    }else if (button.tag == 5662){
        
        NSLog(@"5662-阅读赚");
        
        self.readEarn();
        
    }else if (button.tag == 3000){
        NSLog(@"3000");
        
        self.backBlock();
        
    }else if (button.tag == 5663) {
        NSLog(@"5663-享立赚");
        self.shareEarnBlock();
    }else if (button.tag == 12345) {
        NSLog(@"12345-任务完成，领取奖励");
        
        NetWork * net = [[NetWork alloc]init];
        [net getTheDayTaskRewards];
        __weak taskView * wewakSelf = self;
        net.dayTaskFinish=^(NSString * code,NSString * message){
        
            NSLog(@"code =>%@",code);
            
            
            if ([code isEqualToString:@"1"]) {
                
                [wewakSelf finishTaskRedHongBaoWithMessage:message];

            }else{
            
                [wewakSelf performSelector:@selector(showTheResult:) withObject:message];
            }
        };
        
    }
    
}


#pragma mark- 完成任务提示
- (void)showTheResult:(NSString *)message{

    UILabel * showView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/2, SCREEN_W/4)];
    showView.backgroundColor = [UIColor blackColor];
    showView.textColor = [UIColor whiteColor];
    showView.center = CGPointMake(SCREEN_W/2, SCREEN_H/2 - 50);
    showView.text = message;
    showView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:showView];
    
    [UIView animateWithDuration:4 animations:^{
       
        showView.alpha = 0;
    }];
}



#pragma mark- 红包弹框
- (void)finishTaskRedHongBaoWithMessage:(NSString *)message{
    
//    UIImage * img = [UIImage imageNamed:@"red_envelope01.png"];
    
    UIImage * img = [UIImage imageNamed:@"task_finish_bg.png"];

    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 2, 3)];
    imgView.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);
    imgView.image = img;
    [self addSubview:imgView];
    
    UILabel * label = [[UILabel alloc]init];
    label.text = message;
    label.textColor = [UIColor yellowColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, SCREEN_W/2, 30);
    label.center = CGPointMake(imgView.bounds.size.width/2, imgView.bounds.size.height *2/3);
    label.tag = 112233;
    [imgView addSubview:label];
    
    label.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    imgView.transform = CGAffineTransformMakeRotation(M_PI);
    
    [UIView animateWithDuration:1 animations:^{
        
        imgView.transform = CGAffineTransformMakeRotation(M_PI*2);
        
        
        imgView.frame = CGRectMake(0, 0, SCREEN_W/2, SCREEN_H/3);
        imgView.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);
        
        label.transform = CGAffineTransformMakeScale(1, 1);
        
        label.center = CGPointMake(imgView.bounds.size.width/2, imgView.bounds.size.height*2/3);
        
        
        
    } completion:^(BOOL finished) {
        
        
        //        UILabel * label = [[UILabel alloc]init];
        //        label.text = message;
        //        label.textColor = [UIColor yellowColor];
        //        label.font = [UIFont systemFontOfSize:15];
        //        label.textAlignment = NSTextAlignmentCenter;
        //        label.frame = CGRectMake(0, 0, SCREEN_W/2, 30);
        //        label.center = CGPointMake(imgView.bounds.size.width/2, imgView.bounds.size.height/2);
        //        label.tag = 112233;
        //        [imgView addSubview:label];
        
        [self performSelector:@selector(removeHongBao:) withObject:imgView afterDelay:1.5];
        
    }];
    
}


- (void)removeHongBao:(UIImageView *)view{
    
    UILabel * label = [(UILabel *)view viewWithTag:112233];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        view.frame = CGRectMake(0, 0, 2, 3);
        view.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);
        
        label.transform = CGAffineTransformMakeScale(0.1, 0.1);
        
        label.center = CGPointMake(1, 1.5);
        
    } completion:^(BOOL finished) {
        
        [view removeFromSuperview];
        
        
    }];
    
    
    
}




#pragma mark- scrollViewCreat

- (void)scrollViewCreat{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64)];
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_H - 63);
    self.scrollView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    self.scrollView.userInteractionEnabled = YES;
    [self addSubview:_scrollView];
    
    self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(completeStatusGetNet)];
    
    
    
}

- (void)iteamCreat{
    
    NSArray * imgArray = @[@"task_share.png",@"task_recruit_day.png",@"task_read.png",@"task_ad.png"];
    NSArray * labelArray1 = @[@"分享文章",@"邀请好友",@"阅读赚",@"享立赚"];
    NSArray * labelArray2 = @[@"当日有收益即算完成",@"永久获得徒弟收益25%提成",@"不用分享也能赚钱",@"分享即可获得收益"];
    
    for (int i = 0; i < 4 ; i++) {
        
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, (20 + SCREEN_W/5) * i, SCREEN_W, SCREEN_W/5)];
        bgView.backgroundColor =[UIColor whiteColor];
#pragma mark- bgView.tag-2020+i
        bgView.tag = 2020 + i;
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,SCREEN_W/7,SCREEN_W/7)];
        imgView.center = CGPointMake(SCREEN_W/5, SCREEN_W/10);
        [bgView addSubview:imgView];
        imgView.image = [UIImage imageNamed:imgArray[i]];
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame) + 5, CGRectGetMinY(imgView.frame) + 5, SCREEN_W/2, SCREEN_W/20)];
//        label1.backgroundColor =[UIColor redColor];
        label1.text = labelArray1[i];
        label1.textColor = [UIColor blackColor];
        label1.font = [UIFont systemFontOfSize:15];
        [bgView addSubview:label1];
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imgView.frame) + 5,  CGRectGetMaxY(label1.frame) - 5, SCREEN_W/2, SCREEN_W
                                                                    /8)];
        label2.text = labelArray2[i];
        label2.textColor = [UIColor lightGrayColor];
        label2.font = [UIFont systemFontOfSize:13];
        [bgView addSubview:label2];

        UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        label3.text = @">";
        label3.center = CGPointMake(SCREEN_W - 10, SCREEN_W/10);
        label3.textColor = [UIColor lightGrayColor];
        label3.font = [UIFont systemFontOfSize:22];
        [bgView addSubview:label3];

        
        UIImageView * imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,SCREEN_W/14,SCREEN_W/14)];
        imgView2.center = CGPointMake(SCREEN_W/15, SCREEN_W/10);
        [bgView addSubview:imgView2];
        imgView2.image = [UIImage imageNamed:@"welfare_undone.png"];
#pragma mark- imgView2.tag - 1010+i
        imgView2.tag = 1010 + i;
        [_scrollView addSubview:bgView];
        
        [self.imgArray addObject:imgView2];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0,SCREEN_W, SCREEN_W/5);
//        button.backgroundColor = [UIColor redColor];
        [bgView addSubview:button];
        button.tag = 5660 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    for (int i = 0; i < 3; i++) {
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/15, SCREEN_W /6 +(20 + SCREEN_W/5) * i, 1, SCREEN_W/8)];
        line.backgroundColor = [UIColor lightGrayColor];
        [_scrollView addSubview:line];
    }
    
    self.toFourVcButton = (UIButton *)[self.scrollView viewWithTag:5660];
    
}

#pragma mark- completeButtonCreat

- (void)greeButtonCreat{
    
    UIView * vi = (UIView *)[self.scrollView viewWithTag:2023];
    
    self.completeButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.completeButton setTitle:@"完成任务，领取奖励" forState:UIControlStateNormal];
    self.completeButton.layer.cornerRadius = 5;
    self.completeButton.backgroundColor = [UIColor colorWithRed:24/255.0 green:151/255.0 blue:85/255.0 alpha:1];
    self.completeButton.frame = CGRectMake(0, 0, SCREEN_W - 40, SCREEN_W/10);
    self.completeButton.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(vi.frame) + 10  + SCREEN_W/9);
    [self.scrollView addSubview:_completeButton];
    self.completeButton.tag = 12345;
    [self.completeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}


@end
