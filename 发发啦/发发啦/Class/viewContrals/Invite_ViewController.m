//
//  Invite_ViewController.m
//  发发啦
//
//  Created by gxtc on 16/8/15.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "Invite_ViewController.h"
#import "LogInViewController.h"
#import "UCShareView.h"
#import "NetWork.h"
#import "webViewController.h"
#import "UIImageView+WebCache.h"
#import "UMSocialUIManager.h"
#import "invite_NextVc.h"
#import "MBProgressHUD.h"

#import "NetWork.h"
#import "typeOneCell.h"
#import "articleOneTypeModel.h"
#import "wkWebViewController.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

#pragma mark- 用户资料
#define UMSUserInfoPlatformTypeKey @"UMSUserInfoPlatformTypeKey"
#define UMSUserInfoPlatformNameKey @"UMSUserInfoPlatformNameKey"
#define UMSUserInfoPlatformIconNameKey @"UMSUserInfoPlatformIconNameKey"

#pragma mark- 用户登录
#define UMSAuthPlatformTypeKey @"UMSAuthPlatformTypeKey"
#define UMSAuthPlatformNameKey @"UMSAuthPlatformNameKey"
#define UMSAuthPlatformIconNameKey @"UMSAuthPlatformImageNameKey"


@interface Invite_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView * headView1;
@property(nonatomic,strong)UIView * headView0;

@property(nonatomic,strong)UIView * detailView;

@property(nonatomic,strong)UIButton * loadButton;

@property(nonatomic,strong)UIButton * leftButton;
@property(nonatomic,strong)UIButton * middleButton;
@property(nonatomic,strong)UIButton * rightButton;

@property(nonatomic,strong)NSString * isLogIn;

@property(nonatomic,strong)UIScrollView * textScrollView;
@property(nonatomic,strong)UIActivityViewController * activity;

@property(nonatomic,strong)UCShareView * ucShareView;

@property(nonatomic,strong)UIImageView * saoYiSaoView;
@property(nonatomic,strong)UIImageView * QrImagView;
@property(nonatomic,strong)UIImageView * luckDrawQrImagView;


@property(nonatomic,strong)UIImage * QrImag;
@property(nonatomic,strong)UIImage * addImage;


@property(nonatomic,strong)UILabel * inviateCodeLabel;
@property(nonatomic,strong)UILabel * moneyLabel;

@property(nonatomic,strong)UILabel * yestadayIncom;
@property(nonatomic,strong)UILabel * todayPupli;
@property(nonatomic,strong)UILabel * sumPupli;

@property(nonatomic,copy)NSString * shareLink;
@property(nonatomic,copy)NSString * shareBgViewImgLing;
@property(nonatomic,strong)MBProgressHUD * hud;
@property(nonatomic,assign)BOOL isWeiBoShare;
@property (nonatomic,strong) UIScrollView * headScrollView;

@property (nonatomic,strong) NSUserDefaults * userDefault;
@property (nonatomic,assign)BOOL isCharacter;


@property (nonatomic,strong)NSArray * videoDataArray;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NetWork * net;
@end

@implementation Invite_ViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSString * isLogState = [self.userDefault objectForKey:@"isLogIn"];
    
    _isLogIn = isLogState;
    
    if ([isLogState isEqualToString:@"1"]) {
        
        self.headScrollView.contentOffset = CGPointMake(SCREEN_W, 0);
        
        [self reloadUserInfos];
        
        if (self.isShowBackButton) {
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(10, 25, 45, 40);
            [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"]forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
        
        
        
    }else{
        
        self.headScrollView.contentOffset = CGPointMake(0, 0);

    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.userDefault = [NSUserDefaults standardUserDefaults];
    NSString * isLogState = [self.userDefault objectForKey:@"isLogIn"];
    self.isLogIn = isLogState;

//    [self creat];
    
    
    [self checkReviewHidden];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadUserInfos) name:@"userInfo" object:nil];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webJump:) name:@"userInfoNotification" object:nil];

}


#pragma mark- 审核隐藏
/** 审核隐藏*/
- (void)checkReviewHidden{
  
#warning 改改改!!!!!!!!!!
    [self creat];
    
    /*
    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
    }
    
    [self.net isHiddenWhenReview];
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    __weak Invite_ViewController * weakSelf = self;
    
    self.net.hiddenWhenReviewBK = ^(NSString * code, BOOL isHiden) {
        
        
        [hud hideAnimated:YES];
        
        if (isHiden == NO) {
            
            NSLog(@"不需要隐藏");
            
            [weakSelf creat];
            
        }else{
            
            [weakSelf videoTableviewCreatNew];
        }
        
    };
    */
}





//推送跳转
- (void)webJump:(NSNotification *)userInfo{
    
    webViewController * web = [[webViewController alloc]init];
    web.urlString = userInfo.userInfo[@"aps"][@"sound"];
    [self.navigationController pushViewController:web animated:YES];
    
    
}



- (void)reloadUserInfos{

    NSDictionary * userInfoDic = [self.userDefault objectForKey:@"usermessage"];
    
    NSString * uid = userInfoDic[@"uid"];
    NSString * yesterDay_income = userInfoDic[@"yesterDay_income"];
    NSString * today_prentice = userInfoDic[@"today_prentice"];
    NSString * prentice_num = userInfoDic[@"prentice_num"];
    NSString * prentice_sum_money = userInfoDic[@"prentice_sum_money"];
    
    
    self.inviateCodeLabel.text = [NSString stringWithFormat:@"您的邀请码:%@",uid];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元",prentice_sum_money];
    self.yestadayIncom.text = [NSString stringWithFormat:@"%@元",yesterDay_income];
    self.todayPupli.text = [NSString stringWithFormat:@"%@人",today_prentice];
    self.sumPupli.text = [NSString stringWithFormat:@"%@人",prentice_num];

}



/** 返回按钮*/
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];

}

/** 初始化*/
- (void)creat{
    
    NSString * isLogState = [self.userDefault objectForKey:@"isLogIn"];
    
    _isLogIn = isLogState;
    
    
    [self headScrollviewCreat];
    
    [self headViewLogInCreat];
    
    [self headViewUnLoadCreat];
    
    [self detailViewCreat];
    [self buttonCreat];
}



- (void)headScrollviewCreat{
    
    self.headScrollView =[[ UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H/4 + 30)];
    
    self.headScrollView.contentSize = CGSizeMake(SCREEN_W*2, 0);
    self.headScrollView.scrollEnabled = NO;
    
    if ([self.isLogIn isEqualToString:@"1"]) {
        
        self.headScrollView.contentOffset = CGPointMake(SCREEN_W, 0);
        
    }else{
        
        self.headScrollView.contentOffset = CGPointMake(0, 0);
    }
    
    [self.view addSubview:self.headScrollView];
    
    
}

#pragma mark- headViewLogInCreat

- (void)headViewLogInCreat{
    
    NSDictionary * userInfoDic = [self.userDefault objectForKey:@"usermessage"];
    
    NSString * uid = userInfoDic[@"uid"];
    NSString * yesterDay_income = userInfoDic[@"yesterDay_income"];
    NSString * today_prentice = userInfoDic[@"today_prentice"];
    NSString * prentice_num = userInfoDic[@"prentice_num"];
    NSString * prentice_sum_money = userInfoDic[@"prentice_sum_money"];
    
    self.headView1 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W, 0, SCREEN_W, SCREEN_H/4 + 30)];
    [self.headScrollView addSubview:self.headView1];
    self.headView1.backgroundColor = [UIColor colorWithRed:68/255.0 green:187/255.0 blue:140/255.0 alpha:1];
    
    UILabel * inviateCodeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 20)];
    inviateCodeLabel.center = CGPointMake(SCREEN_W/2, 40);
    inviateCodeLabel.textAlignment = NSTextAlignmentCenter;
    inviateCodeLabel.text = [NSString stringWithFormat:@"您的邀请码:%@",uid];
    inviateCodeLabel.font = [UIFont systemFontOfSize:15];
    inviateCodeLabel.textColor = [UIColor whiteColor];
//    inviateCodeLabel.backgroundColor = [UIColor redColor];
    [self.headView1 addSubview:inviateCodeLabel];
    
    UILabel * moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 50)];
    moneyLabel.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(inviateCodeLabel.frame) + 25);
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.text = [NSString stringWithFormat:@"%@元",prentice_sum_money];
    moneyLabel.font = [UIFont systemFontOfSize:42];
    moneyLabel.textColor = [UIColor whiteColor];
//    moneyLabel.backgroundColor = [UIColor greenColor];
    [self.headView1 addSubview:moneyLabel];

    UILabel * pupilLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 20)];
    pupilLabel.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(moneyLabel.frame) + 10);
    pupilLabel.textAlignment = NSTextAlignmentCenter;
    pupilLabel.text = [NSString stringWithFormat:@"累计徒弟提成"];
    pupilLabel.font = [UIFont systemFontOfSize:14];
    pupilLabel.textColor = [UIColor colorWithRed:24/255.0 green:151/255.0 blue:84/255.0 alpha:1];
    //    moneyLabel.backgroundColor = [UIColor greenColor];
    [self.headView1 addSubview:pupilLabel];
    
    self.inviateCodeLabel = inviateCodeLabel;
    self.moneyLabel = moneyLabel;
    
    
    NSArray * titleArray = @[@"昨日提成",@"今日收徒",@"累计收徒"];
    NSArray * detailArray = @[[NSString stringWithFormat:@"%@元",yesterDay_income]
                              ,[NSString stringWithFormat:@"%@人",today_prentice]
                              ,[NSString stringWithFormat:@"%@人",prentice_num]];
    
    NSMutableArray * labelArray = [NSMutableArray new];
    
    for (int i = 0; i < 3; i++) {
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(-1 + ( SCREEN_W /3)*i, 2*self.headView1.bounds.size.height/3 + 5, SCREEN_W/3, self.headView1.bounds.size.height/3 - 5)];
        view.tag = 1230+i;
        [self.headView1 addSubview:view];
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = [UIColor whiteColor].CGColor;
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake( 0, 0,80,20)];
        label.center = CGPointMake(view.bounds.size.width/2, 20);
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        label.text = titleArray[i];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor whiteColor];
        
        
        UILabel * detailLabel =[[ UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
        [view addSubview:detailLabel];
        detailLabel.center = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2 + 10);
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.text = detailArray[i];
        detailLabel.font = [UIFont systemFontOfSize:13];
        detailLabel.textColor = [UIColor whiteColor];
        detailLabel.tag = 1900+i;
        
        [labelArray addObject:detailLabel];
    }

    self.yestadayIncom = labelArray[0];
    self.todayPupli = labelArray[1];
    self.sumPupli = labelArray[2];
    self.sumPupli.userInteractionEnabled = YES;
    
    UIView * v = [(UIView *)self.headView1 viewWithTag:1232];
    
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(v.bounds.size.width-15, v.bounds.size.height - 15, 10, 10)];
    img.image =[ UIImage imageNamed:@"home_icon_more.png"];
    [v addSubview:img];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0,SCREEN_W/3, self.headView1.bounds.size.height/3 - 5);
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:button];
    
   
    
    
}


- (void)buttonAction{

    NSLog(@"tusdi===_-");
    
    invite_NextVc * vc = [[invite_NextVc alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}


/** headView初始化*/
- (void)headViewUnLoadCreat{

    self.headView0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H/4 + 30)];
    [self.headScrollView addSubview:self.headView0];
    self.headView0.backgroundColor = [UIColor colorWithRed:68/255.0 green:187/255.0 blue:140/255.0 alpha:1];

#pragma mark- -登录按钮
    self.loadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loadButton.frame = CGRectMake(0, 0, SCREEN_W/3, 30);
    self.loadButton.center = CGPointMake(SCREEN_W/2, 64);
    [self.headView0 addSubview:_loadButton];
    [self.loadButton setTitle:[NSString stringWithFormat:@"请登录"] forState:UIControlStateNormal];
#pragma mark- button.Tag-1000;
    self.loadButton.tag = 1000;
    self.loadButton.layer.borderWidth = 1;
    self.loadButton.layer.borderColor =[UIColor blackColor].CGColor;
    self.loadButton.layer.cornerRadius= 5;
    [self.loadButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    NSArray * titleArray = @[@"昨日提成",@"今日收徒",@"累计收徒"];
    NSArray * detailArray = @[@"--.--元",@"--人",@"--人"];
    for (int i = 0; i < 3; i++) {
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(-1 + ( SCREEN_W /3)*i, 2*self.headView0.bounds.size.height/3, SCREEN_W/3, self.headView0.bounds.size.height/3)];
        [self.headView0 addSubview:view];
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = [UIColor whiteColor].CGColor;
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake( 0, 0,80,20)];
        label.center = CGPointMake(view.bounds.size.width/2, 20);
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        label.text = titleArray[i];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor whiteColor];
        
        
        UILabel * detailLabel =[[ UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
        [view addSubview:detailLabel];
        detailLabel.center = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2 + 10);
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.text = detailArray[i];
        detailLabel.font = [UIFont systemFontOfSize:13];
        detailLabel.textColor = [UIColor whiteColor];
        
    }
    

}


/** detailView初始化*/
- (void)detailViewCreat{

    self.textScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SCREEN_H/4 + 30, SCREEN_W, SCREEN_H - 49 -(SCREEN_H/4 + 30))];
    self.textScrollView.contentSize = CGSizeMake(0,SCREEN_H - 48 -(SCREEN_H/4 + 30));
    [self.view addSubview:_textScrollView];
    self.textScrollView.backgroundColor = [UIColor whiteColor];
    self.textScrollView.userInteractionEnabled = YES;
    
    self.detailView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H - 49 - SCREEN_H/4 + 30)];
    [self.textScrollView addSubview:_detailView];
    self.detailView.backgroundColor = [UIColor whiteColor];
    
    UILabel * lable1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, SCREEN_W - 5, 30)];
    [self.detailView addSubview:lable1];
    lable1.text = @"徒弟能给我带来什么？";
    lable1.textColor = [UIColor orangeColor];
    
    UITextView * lable2 = [[UITextView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(lable1.frame), SCREEN_W - 5, SCREEN_W/6)];
    [self.detailView addSubview:lable2];
    lable2.text = @"每邀请一个徒弟可获得0.5元奖励，以及徒弟收益的最高达25%永久分成。（具体分成请看新手教程下的“邀请小伙伴”的用户等级说明）";
//    lable2.numberOfLines = 0;
    lable2.font = [UIFont systemFontOfSize:15];
    lable2.textColor = [UIColor redColor];
    lable2.editable = NO;
    
    UILabel * lable3 = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(lable2.frame), SCREEN_W - 5, 30)];
    [self.detailView addSubview:lable3];
    lable3.text = @"如何招收徒弟";
    lable3.textColor = [UIColor orangeColor];
    
    UITextView * lable4 = [[UITextView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(lable3.frame), SCREEN_W - 5, SCREEN_W/8)];
    [self.detailView addSubview:lable4];
    lable4.text = @"把你的收徒邀请链接分享出去，有用户完成注册，既成为你的徒弟，TA可拿到5元新手红包。";
//    lable4.numberOfLines = 0;
    lable4.font = [UIFont systemFontOfSize:15];
    lable4.textColor = [UIColor blackColor];
    lable4.editable = NO;
    
    UILabel * lable5 = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(lable4.frame), SCREEN_W - 5, 30)];
    [self.detailView addSubview:lable5];
    lable5.text = @"怎么招收更多徒弟？";
    lable5.textColor = [UIColor orangeColor];
    
    UITextView * lable6 = [[UITextView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(lable5.frame), SCREEN_W - 5, SCREEN_W/4)];
    [self.detailView addSubview:lable6];
    lable6.text = @"在赚钱/兼职/学生群等QQ群及社区论坛贴吧中发送您的收徒邀请链接。二三线城市的初高中，技术QQ群及赌赢的百度贴吧收徒收徒效果非常。自己建立QQ群拉徒弟加入，分享赚钱技巧，徒弟赚得越多，双赢喔。";
//    lable6.numberOfLines = 0;
    lable6.font = [UIFont systemFontOfSize:15];
    lable6.textColor = [UIColor blackColor];
    lable6.editable = NO;

}

#pragma mark- buttonCreat
- (void)buttonCreat{

    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_leftButton];
    self.leftButton.frame = CGRectMake(0, 0, (SCREEN_W - 30)/3, 40);
    self.leftButton.center = CGPointMake((SCREEN_W-30)/6 + 10, SCREEN_H - 49 - 40);
    self.leftButton.backgroundColor = [UIColor orangeColor];
    [self.leftButton setTitle:@"立即收徒" forState:UIControlStateNormal];
    [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftButton.layer.cornerRadius = 5;
#pragma mark- button.tag-1001
    self.leftButton.tag = 1001;
    [self.leftButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_rightButton];
    self.rightButton.frame = CGRectMake(0, 0, (SCREEN_W - 30)/3, 40);
    self.rightButton.center = CGPointMake(SCREEN_W - 10 - (SCREEN_W-30)/6, SCREEN_H - 49 - 40);
    self.rightButton.backgroundColor = [UIColor purpleColor];
    [self.rightButton setTitle:@"收徒技巧" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightButton.layer.cornerRadius = 5;
#pragma mark- button.tag-1002
    self.rightButton.tag = 1002;
    [self.rightButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_middleButton];
    self.middleButton.frame = CGRectMake(0, 0, (SCREEN_W - 30)/3, 40);
    self.middleButton.center = CGPointMake(SCREEN_W /2, SCREEN_H - 49 - 40);
    self.middleButton.backgroundColor = [UIColor colorWithRed:60/255.0 green:178/255.0 blue:129/255.0 alpha:1];
    [self.middleButton setTitle:@"个性收徒" forState:UIControlStateNormal];
    [self.middleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.middleButton.layer.cornerRadius = 5;
#pragma mark- button.tag-1002
    self.middleButton.tag = 1003;
    [self.middleButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}



#pragma mark- 请求分享链接
- (void)getShareLinkFromNet{

    NetWork * net = [[NetWork alloc]init];
    
    
    if (self.isCharacter) {
        
        __weak Invite_ViewController * weakSelf = self;

        [net luckDrawForNewUser];
        
        net.luckDrawB=^(NSString * url,NSString * imgUrl){
        
            weakSelf.shareLink = url;
            weakSelf.shareBgViewImgLing = imgUrl;

            [weakSelf.hud hideAnimated:YES];
            
            if (weakSelf.ucShareView == nil) {
            
                weakSelf.ucShareView = [[UCShareView alloc]initWithFrame:self.view.bounds andIsinvite:YES];
                
                [weakSelf.ucShareView.weixin addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                
                [weakSelf.ucShareView.weixinFriend addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                
                [weakSelf.ucShareView.QQ addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                
                [weakSelf.ucShareView.QZone addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                
                [weakSelf.ucShareView.saoYiSao addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                
                [weakSelf.ucShareView.sinaWeiBo addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            [weakSelf.view addSubview:weakSelf.ucShareView];
            [weakSelf luckDrawQrBgViewGet];
            [weakSelf QrCode];

            
        };
        
        
    }else{
    
    [net getShareLinkFromNet];
    
    __weak Invite_ViewController * weakSelf = self;
    
    net.shareLinkBackBlock=^(NSString * url,NSString * imgUrl){
        weakSelf.shareLink = url;
        weakSelf.shareBgViewImgLing = imgUrl;
        
//        [weakSelf.hud hideAnimated:YES];
        
        if (weakSelf.ucShareView == nil) {
        
            weakSelf.ucShareView = [[UCShareView alloc]initWithFrame:self.view.bounds andIsinvite:YES];
            
            [weakSelf.ucShareView.weixin addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [weakSelf.ucShareView.weixinFriend addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [weakSelf.ucShareView.QQ addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [weakSelf.ucShareView.QZone addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [weakSelf.ucShareView.saoYiSao addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [weakSelf.ucShareView.sinaWeiBo addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
        }
        
        [weakSelf.view addSubview:weakSelf.ucShareView];
        
        [weakSelf QrBgViewGet];
        [weakSelf QrCode];

    };
    
    }
}



#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    
    LogInViewController * logVc = [[LogInViewController alloc]init];
    
    if (button.tag == 1000) {
        NSLog(@"1000-未登录");
        
        [self presentViewController:logVc animated:YES completion:nil];
        
    }else if (button.tag == 1001) {
        
        
        self.isCharacter = NO;
        
        NSLog(@"1001");
        
        if ([_isLogIn isEqualToString:@"1"]) {
            
            self.hud =[ MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.hud.removeFromSuperViewOnHide = YES;
            
            [self getShareLinkFromNet];
            
        }else {
        
        NSLog(@"未登录");

        [self presentViewController:logVc animated:YES completion:nil];
            
        }
        
    }else if (button.tag == 1002) {
        NSLog(@"1002");
        
        NSString * urlStr = @"http://wz.lgmdl.com/App/Course/newCourse/type/skills";
        webViewController * web = [[webViewController alloc]init];
        web.urlString = urlStr;
        web.isNewTeach = YES;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if (button.tag == 1003){
    
    
        NSLog(@"个性收徒-1003");
        
        if ([_isLogIn isEqualToString:@"1"]) {
            
            self.hud =[ MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.hud.removeFromSuperViewOnHide = YES;
            
            self.isCharacter = YES;
            
            [self getShareLinkFromNet];
            
        }else {
            
            NSLog(@"未登录");
            
            [self presentViewController:logVc animated:YES completion:nil];
            
        }

        
    }

}


#pragma mark- 扫一扫背景图
- (void)QrBgViewGet{

    self.QrImagView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W *3/4, SCREEN_H *3/4)];
    self.QrImagView.center = self.view.center;
    [self.QrImagView sd_setImageWithURL:[NSURL URLWithString:self.shareBgViewImgLing]];
    self.QrImagView.userInteractionEnabled = YES;
    
    [self.hud hideAnimated:YES];
}

#pragma mark- 抽奖扫一扫背景图
- (void)luckDrawQrBgViewGet{

    self.luckDrawQrImagView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W *3/4, SCREEN_H *3/4)];
    self.luckDrawQrImagView.center = self.view.center;
    [self.luckDrawQrImagView sd_setImageWithURL:[NSURL URLWithString:self.shareBgViewImgLing]];
    self.luckDrawQrImagView.userInteractionEnabled = YES;
    
    [self.hud hideAnimated:YES];

}

//分享
- (void)ucshareButtonAction:(UIButton *)bt{
    
    UIImage * addImage;
    
    
    if (self.isCharacter) {
        
        UIImage * upImg;
        upImg = self.luckDrawQrImagView.image;
        
        if (upImg == nil) {
            upImg = [UIImage imageNamed:@"luckDraw.jpg"];
        }
        
        addImage = [self addDownImage:upImg andUpImage:self.QrImag];

        
    }else{
    
        UIImage * upImg;
        upImg = self.QrImagView.image;
        
        if (upImg == nil) {
            upImg = [UIImage imageNamed:@"friends.jpg"];
        }

        addImage = [self addDownImage:upImg andUpImage:self.QrImag];
    }
    
    
    
    self.addImage = addImage;
    
    
    if (bt.tag == 1115) {
        //扫一扫
        NSLog(@"扫一扫");
        [self.ucShareView removeFromSuperview];
        
        
//        if (self.saoYiSaoView == nil) {
//            
//            self.saoYiSaoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W *2/ 5, SCREEN_W *2/ 5 )];
//            self.saoYiSaoView.center = CGPointMake(self.QrImagView.frame.size.width/2, self.QrImagView.frame.size.height/2 + SCREEN_W/5);
//            self.saoYiSaoView.image = self.QrImag;
//            [self.QrImagView addSubview:self.saoYiSaoView];
//
//        }
//        [self.QrImagView addSubview:self.saoYiSaoView];
//
//        [self.view addSubview:self.QrImagView];
        
        UIImageView * view = [[UIImageView alloc]init];
        
        if (self.isCharacter) {
            
            view.frame = CGRectMake(0, 0,  SCREEN_W, SCREEN_W *2/3);

        }else{
            
            view.frame = CGRectMake(0, 0,  SCREEN_W *3/4, SCREEN_H *3/4);
            
        }
        view.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);
        view.image = addImage;
        
        [self.view addSubview:view];
        
        self.saoYiSaoView = view;
        self.saoYiSaoView.userInteractionEnabled = YES;


    }else if (bt.tag == 1112){
        //取消分享
        NSLog(@"1112-QQ分享");
        [self shareDataWithPlatform:UMSocialPlatformType_QQ];

        [self.ucShareView removeFromSuperview];

    }else if (bt.tag == 1113){
        //取消分享
        NSLog(@"1113-QQ空间分享");
        [self shareDataWithPlatform:UMSocialPlatformType_Qzone];

        [self.ucShareView removeFromSuperview];

    }else if (bt.tag == 1114){
        self.isWeiBoShare = YES;
        NSLog(@"新浪分享-1115");
        [self shareDataWithPlatform:UMSocialPlatformType_Sina];
        [self.ucShareView removeFromSuperview];

        
    }else if (bt.tag == 1110 || bt.tag == 1111){
    
        //拉起分享
        NSLog(@"拉起分享");

        [self shareFuncWithTitle:@"" andURL:@"" andTag:bt.tag];
        
        [self.ucShareView removeFromSuperview];

    
    }

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.saoYiSaoView removeFromSuperview];
    [self.hud hideAnimated:YES];
    self.isCharacter = NO;
    
    NSLog(@"点点点");
}



#pragma mark- UMSocialSharecCreat
/** 友盟分享*/
- (void)UMSocialShare{
    NSLog(@"-===-");
    

}


- (void)shareFuncWithTitle:(NSString *)title andURL:(NSString *)url andTag:(NSInteger)tag{
    
    NSArray * activityIteam = [NSArray new];

    
    if (tag == 1110 || tag == 1111 ) {
        //微信
//        NSString * title = @"微转啦";
//        UIImage * image = [UIImage imageNamed:@"QRcode.png"];
        
        UIImage * image = self.addImage;

        activityIteam = @[image];
        
    }else{
        

    }
    
    
    
    
//    NSString * shareurl = @"https://itunes.apple.com/us/app/wei-zhuan-la/id1130831093?l=zh&ls=1&mt=8";

    
    
    
    
    self.activity = [[UIActivityViewController alloc]initWithActivityItems:activityIteam applicationActivities:nil];
    
    
    
    
    [self presentViewController:_activity animated:YES completion:nil];
    
    self.activity.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError){
        
        
        if (completed) {
            NSLog(@"分享成功!");
        }else{
        
            NSLog(@"分享失败!");
        }
        
    };
    
    
    
}

- (void)QrCode{
    
//    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
//    NSString * uid = dic[@"uid"];
//    NSString * url = @"http://wz.lefei.com/App/Member/tempMember";
    NSString * shareur = self.shareLink;
    
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认
    [filter setDefaults];
    
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSString *dataString = shareur;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    
    // 5.显示二维码
    //    self.imageView.image = [UIImage imageWithCGImage:outputImage];
    
    self.QrImag = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:200];
    
//    UIImageView * icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"QRcode.png"]];
//    icon.frame = CGRectMake(0, 0, 30, 30);
//    icon.center = CGPointMake(SCREEN_W/6, SCREEN_W/6);
//    [self.saoYiSaoView addSubview:icon];
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    

    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    UIImage * img = [UIImage imageWithCGImage:scaledImage];
    
    CGImageRelease(scaledImage);
    CGColorSpaceRelease(cs);

    return img;
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    self.isCharacter = NO;

    [self.ucShareView removeFromSuperview];

}


#pragma mark- 二图叠加

- (UIImage *)addDownImage:(UIImage *)image1 andUpImage:(UIImage *)image2{
    
    UIImage * downImage = image1;
    UIImage * upImage = image2;
    
    UIGraphicsBeginImageContext(downImage.size);
    
    [downImage drawInRect:CGRectMake(0, 0, downImage.size.width, downImage.size.height)];
    
    
    if (self.isCharacter) {
        
        [upImage drawInRect:CGRectMake(downImage.size.width - upImage.size.width*31/25, downImage.size.height - upImage.size.width * 31/28, upImage.size.width*5/6, upImage.size.height*5/6)];

    }else{
    
        [upImage drawInRect:CGRectMake(downImage.size.width/2 - upImage.size.width, downImage.size.height/2, upImage.size.width * 2, upImage.size.height * 2)];

    }
    
    
    
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}



//==========Ushare============

- (NSMutableDictionary *)dictWithPlatformName:(NSNumber *)platformType
{
    UMSocialPlatformType platformType_int = [platformType integerValue];
    NSString *imageName = nil;
    NSString *paltFormName = nil;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:1];
    switch (platformType_int) {
        case UMSocialPlatformType_Sina:
            imageName = @"UMS_sina_icon";
            paltFormName = @"新浪";
            break;
        case UMSocialPlatformType_WechatSession:
            imageName = @"UMS_wechat_icon";
            paltFormName = @"微信";
            break;
        case UMSocialPlatformType_QQ:
            imageName = @"UMS_qq_icon";
            paltFormName = @"QQ";
            break;
            //        case UMSocialPlatformType_TencentWb:
            //            imageName = @"UMS_tencent_icon";
            //            paltFormName = @"腾讯微博";
            //            break;
            //        case UMSocialPlatformType_Douban:
            //            imageName = @"UMS_douban_icon";
            //            paltFormName = @"豆瓣";
            //            break;
            //        case UMSocialPlatformType_Renren:
            //            imageName = @"UMS_renren_icon";
            //            paltFormName = @"人人";
            //            break;
            //        case UMSocialPlatformType_Email:
            //            imageName = @"UMS_email_icon";
            //            paltFormName = @"邮件";
            //            break;
            //        case UMSocialPlatformType_Sms:
            //            imageName = @"UMS_sms_icon";
            //            paltFormName = @"短信";
            //            break;
            //        case UMSocialPlatformType_Facebook:
            //            imageName = @"UMS_facebook_icon";
            //            paltFormName = @"Facebook";
            //            break;
            //        case UMSocialPlatformType_Twitter:
            //            imageName = @"UMS_twitter_icon";
            //            paltFormName = @"Twitter";
            //            break;
            //        case UMSocialPlatformType_Linkedin:
            //            imageName = @"UMS_linkedin_icon";
            //            paltFormName = @"Linkedin";
            //            break;
        default:
            break;
    }
    [dict setValue:UMSocialPlatformIconWithName(imageName) forKey:UMSAuthPlatformIconNameKey];
    [dict setValue:paltFormName forKey:UMSAuthPlatformNameKey];
    return dict;
}


//直接分享
- (void)shareDataWithPlatform:(UMSocialPlatformType)platformType
{
    
    UMSocialMessageObject *messageObject;
    
    
    if (self.isWeiBoShare) {
        
        messageObject = [self creatMessageObjectWithSinaWeiBo];
        self.isWeiBoShare = NO;
    }else{
        messageObject = [self creatMessageObject];
    }
    
    //调用分享接口
    
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        
        
        
        
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        }
        else{
            if (error) {
                message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
                
                switch (error.code) {
                    case UMSocialPlatformErrorType_Unknow:
                        message = @"未知错误";
                        break;
                    case UMSocialPlatformErrorType_NotSupport:
                        message = @"不支持（url scheme 没配置，或者没有配置-ObjC， 或则SDK版本不支持或则客户端版本不支持";
                        break;
                    case UMSocialPlatformErrorType_AuthorizeFailed:
                        message = @"授权失败";
                        break;
                    case UMSocialPlatformErrorType_ShareFailed:
                        message = @"分享失败";
                        break;
                    case UMSocialPlatformErrorType_RequestForUserProfileFailed:
                        message = @"请求用户信息失败";
                        break;
                    case UMSocialPlatformErrorType_ShareDataNil:
                        message = @"分享内容为空";
                        break;
                    case UMSocialPlatformErrorType_ShareDataTypeIllegal:
                        message = @"分享内容不支持";
                        break;
                    case UMSocialPlatformErrorType_CheckUrlSchemaFail:
                        message = @"schemaurl fail";
                        break;
                    case UMSocialPlatformErrorType_NotInstall:
                        message = @"应用未安装";
                        break;
                    case UMSocialPlatformErrorType_Cancel:
                        message = @"您已取消分享";
                        break;
                    case UMSocialPlatformErrorType_NotNetWork:
                        message = @"网络异常";
                        break;
                    case UMSocialPlatformErrorType_SourceError:
                        message = @"第三方错误";
                        break;
                    case UMSocialPlatformErrorType_ProtocolNotOverride:
                        message = @"对应的  UMSocialPlatformProvider的方法没有实现";
                        break;
                    default:
                        break;
                        
                }
                NSLog(@"message = %@",message);
                
            }
            else{
                message = [NSString stringWithFormat:@"分享失败"];
            }
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享状态"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
    
}



//创建新浪分享内容对象
- (UMSocialMessageObject *)creatMessageObjectWithSinaWeiBo{
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    messageObject.text = [NSString stringWithFormat:@"赚//转发文章轻松赚钱！不小心又赚够100啦！快加入吧！"];
    //创建图片对象
    UMShareImageObject *shareImgObject = [[UMShareImageObject alloc]init];
    [shareImgObject setShareImage:self.addImage];
    messageObject.shareObject = shareImgObject;
    return messageObject;
    
}


//创建分享内容对象
- (UMSocialMessageObject *)creatMessageObject
{
    
    
    
    NSString * title = @"微转啦";
    NSString * shareurl = self.shareLink;
    NSDictionary * dict =[[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    NSString * uid = dict[@"uid"];
   

    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    NSString *url = [NSString stringWithFormat:@"%@/uid/%@",shareurl,uid];
    NSString *text = @"一个看新闻都能有收益的的APP动动手指头，玩手机也能日入200!";
    UIImage * thumbImg = [UIImage imageNamed:@"QRcode.png"];
    
    
       UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:text thumImage:thumbImg];
    [shareObject setWebpageUrl:url];
    messageObject.shareObject = shareObject;
  
    
    return messageObject;
}


#pragma mark- 创建视屏列表
- (void)videoTableviewCreatNew{

    UILabel * headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 64)];
    headLabel.text = @"推荐视频";
    headLabel.backgroundColor = [UIColor orangeColor];
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.textColor = [UIColor whiteColor];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_W, SCREEN_H - 49) style:UITableViewStylePlain];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.rowHeight = SCREEN_W/4;
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    
    tableView.tableFooterView = [[UIView alloc]init];
    tableView.tableHeaderView = headLabel;
    
    [self.view addSubview:tableView];

    
    [self videoDataGetFromNet];
}

#pragma mark- 视频列表数据请求
- (void)videoDataGetFromNet{

    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
    }
    
    [self.net articleListGetFromNetWithC_id:18 andPageIndex:1];
    
    __weak Invite_ViewController * weakSelf = self;
    
    self.net.articleList = ^(NSArray * dataArray) {
        
        if (dataArray.count > 0) {
            
            weakSelf.videoDataArray = dataArray;
            
            [weakSelf.tableView reloadData];
        }
        
    };
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    typeOneCell * oneCell = [tableView dequeueReusableCellWithIdentifier:@"oneCell"];
    
    if (oneCell == nil) {
        
        oneCell = [[typeOneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"oneCell"];
        
    }
    
    articleOneTypeModel * model = self.videoDataArray[indexPath.row];
    
    oneCell.model2 = model;
    
    return oneCell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.videoDataArray.count;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    articleOneTypeModel * model = self.videoDataArray[indexPath.row];
    
    NSLog(@"%@",model);
    
    wkWebViewController * wk = [[wkWebViewController alloc]init];
    wk.url = model.video;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wk animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
