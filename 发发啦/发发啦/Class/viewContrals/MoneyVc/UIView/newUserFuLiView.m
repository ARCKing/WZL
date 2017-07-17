//
//  newUserFuLiView.m
//  发发啦
//
//  Created by gxtc on 16/10/26.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "newUserFuLiView.h"
#import "articleModel.h"
#import "NetWork.h"
#import "newTaskModel.h"
#import "articleModel.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width


@interface newUserFuLiView()
@property(nonatomic,strong)UIView  *navView;
@property(nonatomic,strong)UIScrollView * scrollView;

@property(nonatomic,strong)UIButton * completeButton;
@property(nonatomic,strong)newTaskModel * model;


@end


@implementation newUserFuLiView

- (void)initCreat{
    
    self.backgroundColor = [UIColor redColor];
    
    [self navViewCreat];
    [self scrollViewCreat];
    [self iteamCreat];
    [self greeButtonCreat];
    
    [self newTaskFinishState];
}

#pragma mark-获取新手任务状态
- (void)newTaskFinishState{
    NetWork * net =[[NetWork alloc]init];
    [net newTaskFinishStatus];

    __weak newUserFuLiView * weakSelf = self;
    
    net.newTaskStatusBlock=^(newTaskModel * model){
    
        weakSelf.model = model;
    
        [weakSelf setImageViewAndMessage];
        
    };
    
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
    titleLabel.text = @"新手任务";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}


#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    
    if (button.tag == 5660) {
        NSLog(@"5660");
        
        self.editPersonMessage();
        
    }else if (button.tag == 5661){
        NSLog(@"5661");
    
        self.toInvite();
    
    }else if (button.tag == 5662){
        NSLog(@"5662");
        
        self.signRed();
       
    }else if (button.tag == 3000){
        NSLog(@"3000");
        
        self.fuLiBlock();
    }else if (button.tag == 5663) {
        NSLog(@"5663");
        
    }else if (button.tag == 12345) {
        NSLog(@"12345");
        
        NetWork * net = [[NetWork alloc]init];
        
        [net getTheNewTaskRewards];
        
        __weak newUserFuLiView * weakSelf = self;
        
        net.newTaskFinish=^(NSString * code,NSString * message){
        
            NSLog(@"code =>%@",code);

            if ([code isEqualToString:@"1"]) {
                [weakSelf finishTaskRedHongBaoWithMessage:message];

            }else{
            
                [weakSelf performSelector:@selector(showTheResult:) withObject:message];
                
            }
        };
        
        
    }else if (button.tag == 5550 && self.model) {
        NSLog(@"5550");
        
        
        articleModel * article = self.model.articleArray[0];
        
        self.toWeb(article);
        
        
    }else if (button.tag == 5551 && self.model) {
        NSLog(@"5551");
        articleModel * article = self.model.articleArray[1];

        self.toWeb(article);
    }
    
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
            label.center = CGPointMake(imgView.bounds.size.width/2, imgView.bounds.size.height*2/3);
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
    [self addSubview:_scrollView];
    
    self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(newTaskFinishState)];
}

- (void)iteamCreat{
    
    NSArray * imgArray = @[@"task_share.png",@"icon_03.png",@"home_red.png",@"task_ad.png"];
    NSArray * labelArray1 = @[@"完善个人资料",@"邀请好友",@"签到领红包",@"分享两篇文章"];
//    NSArray * labelArray2 = @[@"当日有收益即算完成",@"永久获得徒弟收益20%提成",@"不用分享也能赚钱",@"分享即可获得收益"];
    
    for (int i = 0; i < 3 ; i++) {
        
        UIView * bgView = [[UIView alloc]init];
        bgView.frame = CGRectMake(0, (1 + SCREEN_W/5) * i, SCREEN_W, SCREEN_W/5);
        bgView.backgroundColor =[UIColor whiteColor];
#pragma mark- bgView.tag-2020+i
        bgView.tag = 2020 + i;
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,SCREEN_W/7,SCREEN_W/7)];
        imgView.center = CGPointMake(SCREEN_W/5, SCREEN_W/10);
        [bgView addSubview:imgView];
        imgView.image = [UIImage imageNamed:imgArray[i]];
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0,0, SCREEN_W/2, SCREEN_W/20)];
        label1.center = CGPointMake(CGRectGetMaxX(imgView.frame) + SCREEN_W/4 + 5, SCREEN_W/10);
        label1.text = labelArray1[i];
        label1.textColor = [UIColor blackColor];
        label1.font = [UIFont systemFontOfSize:15];
        [bgView addSubview:label1];
        
        
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
        
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0,SCREEN_W, SCREEN_W/5);
        [bgView addSubview:button];
        button.tag = 5660 + i;
//        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    UIView * targetView = (UIView *)[self.scrollView viewWithTag:2022];
    
    UIView * bgView2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(targetView.frame) + 20, SCREEN_W, SCREEN_H-64-20-SCREEN_W*3/5)];
    bgView2.tag = 3303;
    bgView2.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:bgView2];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(-1, 0, SCREEN_W + 2, SCREEN_W/10)];
    titleLabel.text = [NSString stringWithFormat:@"分享两篇文章"];
    titleLabel.layer.borderWidth = 0.5;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [bgView2 addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    for (int i = 0; i < 2; i++) {
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + (SCREEN_W/4 + 1) * i, SCREEN_W, SCREEN_W/4)];
        view.tag = 3300+i;
        [bgView2 addSubview:view];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0,SCREEN_W, SCREEN_W/4);
        [view addSubview:button];
        button.tag = 5550 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

        
        
        
        UIImageView * img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/14, SCREEN_W/14)];
        img1.image = [UIImage imageNamed:@"welfare_undone.png"];
        img1.center = CGPointMake(SCREEN_W/14, SCREEN_W/8);
        [view addSubview:img1];
        img1.tag = 220 + i;
        
        UIImageView * img2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/4, SCREEN_W/6)];
        img2.center = CGPointMake(CGRectGetMaxX(img1.frame) + SCREEN_W/8 + 10, SCREEN_W/8);
        img2.image = [UIImage imageNamed:@"load.png"];
        [view addSubview:img2];
        img2.tag = 210 + i;
        
        UILabel * articleTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(img2.frame) + 5, 10, SCREEN_W * 3/5, 40)];
        articleTitleLabel.text = @"收费多少功夫功夫功夫发个梵蒂冈地方";
        [view addSubview:articleTitleLabel];
        articleTitleLabel.numberOfLines = 0;
        articleTitleLabel.font = [UIFont systemFontOfSize:15];
        articleTitleLabel.tag = 4500 + i;
        
        
        UILabel * readLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(img2.frame) + 5, CGRectGetMaxY(img2.frame) - 15, SCREEN_W/3, 20)];
        readLabel.text = @"阅读:219";
        [view addSubview:readLabel];
        readLabel.textColor = [UIColor lightGrayColor];
        readLabel.font = [UIFont systemFontOfSize:13];
        readLabel.tag = 4600 + i;
        
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W-SCREEN_W/3 - 10, CGRectGetMaxY(img2.frame) - 15, SCREEN_W/3, 20)];
        timeLabel.text = @"2016-03-06";
        [view addSubview:timeLabel];
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.textColor = [UIColor lightGrayColor];
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.tag = 4700 + i;
        
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/7, CGRectGetMaxY(view.frame), SCREEN_W - SCREEN_W/7, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [bgView2 addSubview:line];
        
        
    }
    
    for (int i = 0; i < 2; i++) {
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/15, SCREEN_W /6 + (SCREEN_W/5)* i, 1, SCREEN_W/11)];
        line.backgroundColor = [UIColor lightGrayColor];
        line.tag = 2345 + i;
        [_scrollView addSubview:line];
    }
    
    UIView * lineVi = (UIView *)[self.scrollView viewWithTag:2346];

    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/15, CGRectGetMaxY(lineVi.frame) + SCREEN_W/9 , 1, SCREEN_W/4)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:line];
    
    UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/15, CGRectGetMaxY(line.frame) + SCREEN_W/8 , 1, SCREEN_W/7)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:line2];
    

}

#pragma mark- completeButtonCreat

- (void)greeButtonCreat{
    
    
    
    
    UIView * vi = (UIView *)[self.scrollView viewWithTag:3303];
    
    self.completeButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.completeButton setTitle:@"已完成任务，领取新手红包" forState:UIControlStateNormal];
    self.completeButton.layer.cornerRadius = 5;
    self.completeButton.backgroundColor = [UIColor colorWithRed:24/255.0 green:151/255.0 blue:85/255.0 alpha:1];
    self.completeButton.frame = CGRectMake(0, 0, SCREEN_W - 40, SCREEN_W/10);
    self.completeButton.center = CGPointMake(SCREEN_W/2, vi.frame.size.height - SCREEN_W/5);
    [vi addSubview:_completeButton];
    self.completeButton.tag = 12345;
    [self.completeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}



- (void)setImageViewAndMessage{

    
    
    UIView * vi0 = (UIView *)[self.scrollView viewWithTag:2020];
    UIView * vi1 = (UIView *)[self.scrollView viewWithTag:2021];
    UIView * vi2 = (UIView *)[self.scrollView viewWithTag:2022];

    UIView * vi = (UIView *)[self.scrollView viewWithTag:3303];
    UIView * vi3 = (UIView *)[vi viewWithTag:3300];
    UIView * vi4 = (UIView *)[vi viewWithTag:3301];
    

    //钩
    UIImageView * img0 = (UIImageView *)[vi0 viewWithTag:1010];
    UIImageView * img1 = (UIImageView *)[vi1 viewWithTag:1011];
    UIImageView * img2 = (UIImageView *)[vi2 viewWithTag:1012];
    UIImageView * img3 = (UIImageView *)[vi3 viewWithTag:220];
    UIImageView * img4 = (UIImageView *)[vi4 viewWithTag:221];

    //文章1
    UIImageView * img5 = (UIImageView *)[vi3 viewWithTag:210];
    UILabel * titleLabel1 = (UILabel*)[vi3 viewWithTag:4500];
    UILabel * redLabel1 = (UILabel*)[vi3 viewWithTag:4600];
    UILabel * timeLabel1 = (UILabel*)[vi3 viewWithTag:4700];
    //文章2
    UIImageView * img6 = (UIImageView *)[vi4 viewWithTag:211];
    UILabel * titleLabel2 = (UILabel*)[vi4 viewWithTag:4501];
    UILabel * redLabel2 = (UILabel*)[vi4 viewWithTag:4601];
    UILabel * timeLabel2 = (UILabel*)[vi4 viewWithTag:4701];

    
    NSString * done_profile = [NSString stringWithFormat:@"%@",self.model.done_profile];
    NSString * invite_friend = [NSString stringWithFormat:@"%@",self.model.invite_friend];
    NSString * sign_money = [NSString stringWithFormat:@"%@",self.model.sign_money];
    NSString * share_article = self.model.share_article;
    
    NSArray * article = self.model.articleArray;
    
    if (article.count>0) {
        
    
    articleModel * model0 = article[0];
    articleModel * model1 = article[1];
    
    
    [img5 sd_setImageWithURL:[NSURL URLWithString:model0.thumb]];
    titleLabel1.text = model0.title;
    redLabel1.text = [NSString stringWithFormat:@"阅读:%@",model0.view_count];
    timeLabel1.text = [self returnAddTime:model0.addtime];
    
    
    [img6 sd_setImageWithURL:[NSURL URLWithString:model1.thumb]];
    titleLabel2.text = model1.title;
    redLabel2.text = [NSString stringWithFormat:@"阅读:%@",model1.view_count];
    timeLabel2.text = [self returnAddTime:model1.addtime];

    
    
    
    
    NSArray * arrayID = [share_article componentsSeparatedByString:@","];
    NSInteger count = arrayID.count;
    
    
    
    if (count == 2) {
        img3.image = [UIImage imageNamed:@"welfare_completed.png"];
        
        img4.image = [UIImage imageNamed:@"welfare_completed.png"];

    }else if (count == 1 && ![arrayID[0]isEqualToString:@"0"]){
        
        if ([model0.id_ isEqualToString:arrayID[0]]) {
            
            img3.image = [UIImage imageNamed:@"welfare_completed.png"];
            
        }else{
            
            img4.image = [UIImage imageNamed:@"welfare_completed.png"];
        }
    
    }else if (count == 0){
    
    }
    
    
    
    if ([done_profile isEqualToString:@"1"]) {
        img0.image = [UIImage imageNamed:@"welfare_completed.png"];
    }
    
    if ([invite_friend isEqualToString:@"1"]) {
        img1.image = [UIImage imageNamed:@"welfare_completed.png"];
    }
    if ([sign_money isEqualToString:@"1"]) {
        img2.image = [UIImage imageNamed:@"welfare_completed.png"];
    }
 
    
}
    [self.scrollView.mj_header endRefreshing];
    
        
}


//时间戳
- (NSString *)returnAddTime:(NSString *)times{
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


@end
