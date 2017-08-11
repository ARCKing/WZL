//
//  Home_ViewController.m
//  发发啦
//
//  Created by gxtc on 16/8/15.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "Home_ViewController.h"
#import "LogInViewController.h"
#import "HomeNextViewController.h"
#import "MoneyNextVC.h"
#import "MJRefresh.h"
#import "typeOneCell.h"
#import "RingMessageVC.h"
#import "UIImageView+WebCache.h"
#import "NetWork.h"
#import "CoreDataManger.h"
#import "webViewController.h"
#import "flashModel.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "typeTwoCell.h"
#import "typeTwoCell.h"
#import "AFNetworking.h"
#import "systemMessageModel.h"
#import "guaoGaoModel.h"
#import "ResetCodeViewController.h"
#import "EditProfileViewController.h"
#import "AddArticleController.h"
#import "TaoBaoDiscountController.h"
#import "wkWebViewController.h"
#import "WeiXinAndAliPayWithDrawVC.h"
#import <UMMobClick/MobClick.h>

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface Home_ViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIGestureRecognizerDelegate>


@property (nonatomic, strong) NSMutableArray *adViewArray;
@property (nonatomic, strong) UIScrollView * headScrollView;

@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)UIView * headViewIsLogIn;
@property(nonatomic,strong)UIImageView * iconImageView;

@property(nonatomic,strong)UIButton * loadButton;
@property(nonatomic,strong)UIView * tableHeadView;
@property(nonatomic,strong)UIView * eightButtonView;
@property(nonatomic,strong)UIButton * RedEnvelopeButton;

@property(nonatomic,strong)UIView * buttonView1;
@property(nonatomic,strong)UIView * buttonView2;
@property(nonatomic,strong)UIView * buttonView3;
@property(nonatomic,strong)UIView * buttonView4;


@property(nonatomic,strong)UILabel * money1;
@property(nonatomic,strong)UILabel * money2;
@property(nonatomic,strong)UILabel * money3;
@property(nonatomic,strong)UILabel * money4;
@property(nonatomic,strong)UILabel * money5;
@property(nonatomic,strong)UILabel * money6;


@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,copy)NSString * isLoginState;

@property(nonatomic,strong)UIButton * buttonOfIcon;

@property(nonatomic,strong)UIImagePickerController * picker;
@property(nonatomic,strong)UIImage * iocnImg;
@property(nonatomic,strong)NSString * iconFilePath;

@property(nonatomic,strong)UIImageView * navBar;

#pragma mark- 横幅
@property(nonatomic,strong)UIScrollView * advView;
@property(nonatomic,strong)UIImageView * advimg1;
@property(nonatomic,strong)UIImageView * advimg2;
@property(nonatomic,strong)UIPageControl * pageControl;


@property(nonatomic,strong)UIView * UserNewGiftView;

@property(nonatomic,strong)NetWork * net;

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * flashArray;
@property(nonatomic,strong)NSMutableArray * guangGaoArray;

@property(nonatomic,strong)CoreDataManger * CDManger;

@property(nonatomic,strong)UIButton * missionTaskButton;
@property(nonatomic,assign)NSInteger currentMissionTag;
@property(nonatomic,assign)NSInteger lastMissionTag;

//@property(nonatomic,strong)UIButton * peopleNewComeTaskButton;

@property(nonatomic,assign)BOOL isNotShowNewGift;
@property(nonatomic,assign)BOOL isRefresh;
@property(nonatomic,strong)webViewController * web;

@property(nonatomic,strong)NSTimer * timer;

@property(nonatomic,strong)NSTimer * advTimer;


@property(nonatomic,strong)UIButton * bellButton;
@property(nonatomic,strong)UIView * bellRed;


@property(nonatomic,strong)UIView * myNewUserHongBaoView;
@property(nonatomic,strong)MBProgressHUD * hud;

@property(nonatomic,assign)BOOL NetWorkStatus;

@property(nonatomic,strong)NSUserDefaults * userDefauls;

@property(nonatomic,copy)NSString * headImgUrl;

@property(nonatomic,assign)BOOL refreshs;

@property(nonatomic,assign)int guangGaoIndex1;
@property(nonatomic,assign)int guangGaoIndex2;

@property(nonatomic,assign)BOOL hidenReview;


@property(nonatomic,strong)UIButton * drawRecordBt;

@property(nonatomic,strong)UILabel * drawCashlb;
@property(nonatomic,strong)UILabel * incomeRanklb;
@property(nonatomic,strong)UILabel * signDaylb;
@property(nonatomic,strong)UILabel * wakeUplb;

@property(nonatomic,strong)UIButton * inComeDetailButton;

@property(nonatomic,strong)UILabel * label1;
@property(nonatomic,strong)UILabel * label2;
@property(nonatomic,strong)UILabel * label3;

@property(nonatomic,assign)BOOL left;

@end

@implementation Home_ViewController

- (void)viewWillAppear:(BOOL)animated{

    
    [super viewWillAppear:animated];
    
    
    [self addadvTimer];
    
    
    [MobClick beginLogPageView:@"PageOne"];//("PageOne"为页面名称，可自定义)
    
    self.tabBarController.tabBar.translucent = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.isLoginState = [self.userDefauls objectForKey:@"isLogIn"];
    
    NSLog(@"==>%@",[self.userDefauls objectForKey:@"usermessage"]);

    if ([_isLoginState isEqualToString:@"1"]) {
        
        self.headScrollView.contentOffset = CGPointMake(SCREEN_W, 0);
        
        
        //审核隐藏
//        [self checkReviewHidden];
        
        [self getDayTaskState];
        
        
        NSDictionary * dict = [self.userDefauls objectForKey:@"usermessage"];
        
        NSString * headimgurl = dict[@"headimgurl"];
        
        NSLog(@"iconPath = %@",headimgurl);

        
        if (self.iocnImg) {
            
            self.iconImageView.image = self.iocnImg;
            
        }else{
        
//            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:headimgurl]];
            
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:headimgurl] placeholderImage:[UIImage imageNamed:@"icon_1.png"]];
            
            self.refreshs = YES;
       }
    
        //检查系统消息
        [self checkSystemMesages];
        
    }else {
    
        self.headScrollView.contentOffset = CGPointMake(0, 0);
    }
  
    
    
}


#pragma mark- 按钮审核隐藏
/**按钮审核隐藏*/
- (void)buttonHidenWhenReview{


    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
    }
    
    [self.net isHiddenWhenReview];
    
    __weak Home_ViewController * weakSelf = self;
    
    self.net.hiddenWhenReviewBK = ^(NSString * code, BOOL isHiden) {
        
        if (isHiden == NO) {
            
            weakSelf.hidenReview = NO;
            
            weakSelf.drawRecordBt.hidden = NO;
            
            /*
            NSIndexSet * indexSet = [[NSIndexSet alloc]initWithIndex:0];
            
            [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
            */
            
            weakSelf.drawCashlb.text = @"我要提现";
            
            weakSelf.drawRecordBt.hidden = NO;
            weakSelf.inComeDetailButton.hidden = NO;
            weakSelf.bellButton.hidden = NO;
            
        }else{
            
            weakSelf.hidenReview = YES;
            weakSelf.drawRecordBt.hidden = YES;
            weakSelf.inComeDetailButton.hidden = YES;
            weakSelf.bellButton.hidden = YES;

            
        }
        
    };

}


#pragma mark- 审核隐藏
/** 审核隐藏*/
- (void)checkReviewHidden{

    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
    }

    [self.net isHiddenWhenReview];
    
    __weak Home_ViewController * weakSelf = self;
    
    self.net.hiddenWhenReviewBK = ^(NSString * code, BOOL isHiden) {
        
        if (isHiden == NO) {
            
            [weakSelf getDayTaskState];

            
            weakSelf.hidenReview = NO;
            
            weakSelf.drawCashlb.text = @"我要提现";
            weakSelf.incomeRanklb.text = @"收入排行";
            weakSelf.signDaylb.text = @"签 到";
            weakSelf.wakeUplb.text = @"唤醒徒弟";
            weakSelf.drawRecordBt.hidden = NO;
            weakSelf.inComeDetailButton.hidden = NO;
            weakSelf.bellButton.hidden = NO;

        }else{
        
//            weakSelf.hidenReview = YES;
            
            
        }

    };
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
    
    if (self.refreshs) {
        [self MJrefreshData];
        
        self.refreshs = NO;
    }
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
#warning 改改改!!!!!!!!!!
    self.hidenReview = NO;

    
    self.view.backgroundColor = [UIColor whiteColor];
#pragma mark- 数据库
    [self CoreDataMangerCreat];

    
    
    [self AFNetworkStatus];

    
    self.userDefauls = [NSUserDefaults standardUserDefaults];
    
    self.isLoginState = [self.userDefauls objectForKey:@"isLogIn"];
    
    if ([self.isLoginState isEqualToString:@"1"]) {
        
        [self checkingUserToken];

    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadUserInfo) name:@"userInfo" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reLoginAleartView) name:@"reLoginHome" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopTimer) name:@"stopTimer" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNewUserHongBao) name:@"showHongBao" object:nil];


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iconImgIsChange:) name:@"iconChange" object:nil];

    
    
    self.dataArray = [[NSMutableArray alloc]init];
    
#pragma mark- 首页文章信息
    [self getDataOfNet];
    
    [self tableHeadViewCreat];
    
//    if ([self.isLoginState isEqualToString:@"1"] && self.hidenReview == NO) {
//        
//        [self taskButtonCreat];
//    }
    
    [self creatTableview];
    [self navBarCreat];
    
    
    CGFloat f = [[[UIDevice currentDevice]systemVersion]floatValue];
    
    NSLog(@"%f",f);
    
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;

    if (app.userDic && f < 10) {
        
        [self webJump:app.userDic];
    }
    
    self.adViewArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    
#pragma mark-检查系统消息
    [self checkSystemMesages];
    
    
    [self buttonHidenWhenReview];
    
    [self getActivityMessage];

    
    self.left = YES;
    
}

#pragma mark- 系统设置头像回调
- (void)iconImgIsChange:(NSNotification *)noti{

    NSLog(@"%@",noti);
    
    self.iocnImg = noti.object;
}


#pragma mark- 检查系统消息
- (void)checkSystemMesages{

    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
        
    }
    
    [self.net systemMessageGetFromNetWithPage:1];
    
    __weak Home_ViewController * weakSelf = self;
    
    self.net.systemMessage = ^(NSArray * array){
        
        [weakSelf.CDManger deleteAllSystemMessageData];
       
        [weakSelf.CDManger insertIntoDataWithsystemMessage:array];
        
        NSArray * arr = [weakSelf.CDManger checkAllSystemMessage];
        
        [weakSelf systemMessageUnread:arr];
    };
    
}


#pragma mark- 未读的系统消息
- (void)systemMessageUnread:(NSArray *)arr{

    if (self.bellRed == nil) {
        
        self.bellRed = [[UIView alloc]init];
        self.bellRed.frame = CGRectMake(self.bellButton.bounds.size.width - 6,0, 8, 8);
        [self.bellButton addSubview:self.bellRed];
        self.bellRed.layer.cornerRadius = 4;
        self.bellRed.clipsToBounds = YES;
        self.bellRed.backgroundColor = [UIColor clearColor];
    }
    
    for (systemMessageModel * model in arr) {
        
        if ([model.read isEqualToString:@"0"]) {
            
            self.bellRed.backgroundColor = [UIColor redColor];

            return;
        }else{
        
            self.bellRed.backgroundColor = [UIColor clearColor];

        }
    }


}




#pragma mark- 网络状态判断
- (void)AFNetworkStatus{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    __weak Home_ViewController * weakSelf = self;
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                NSLog(@"未知网络状态");
//                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"未知网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                [alert show];
                
                
                weakSelf.NetWorkStatus = NO;
                
                
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"无网络");
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"无网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                
                weakSelf.NetWorkStatus = NO;

            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"蜂窝数据网");
//                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"正在使用蜂窝数据网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                [alert show];
                
                weakSelf.NetWorkStatus = YES;
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"NetWorkOk" object:nil];

            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WiFi网络");
//                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络" message:@"WiFi网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                [alert show];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"NetWorkOk" object:nil];

                weakSelf.NetWorkStatus = YES;

            }
                
                break;
                
            default:
                break;
        }
        
    }] ;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"NetWorkError" object:nil];
    
}




//推送跳转
- (void)webJump:(NSDictionary *)dic{

    NSDictionary * dict = dic[@"aps"];
    
    NSString * badge = [NSString stringWithFormat:@"%@",dict[@"badge"]];
    
    if ([badge isEqualToString:@"2"]) {
        
        HomeNextViewController * homeNext = [[HomeNextViewController alloc]init];
        homeNext.buttonTag = 101;
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:homeNext animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
        
        
//        if (![self.isLoginState isEqualToString:@"1"]) {
//            
//            
//            LogInViewController * logInVc = [[LogInViewController alloc]init];
//            
//            [self presentViewController:logInVc animated:YES completion:nil];
//            
//            
//        }

        
    }else{
    
        NSDictionary * content_available = dict[@"content-available"];
        
        NSString * id_ = content_available[@"id"];//ID
        
        NSString * img = content_available[@"img"];
        
        NSString * share = content_available[@"share"];
        
        NSString * share_count = [NSString stringWithFormat:@"%@",content_available[@"share_count"]];
        
        NSString * title = content_available[@"title"];
        
        NSString * url = [NSString stringWithFormat:@"%@",content_available[@"url"]];
        
        NSString * ucShare = [NSString stringWithFormat:@"%@",content_available[@"ucshare"]];

        
        webViewController * web = [[webViewController alloc]init];
        
        web.urlString = url;
        web.share_count = share_count;
        web.shareUrl = share;
        web.id_ = id_;
        web.thumbimg = img;
        web.bigTitle = title;
        web.abstract = title;
        web.isPush = YES;
        
//    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:web animated:YES];
//    self.hidesBottomBarWhenPushed = NO;

        [self presentViewController:web animated:YES completion:nil];

        
        
    }
}



#pragma mark- 请求头像
- (void)getUserIconFromNet{
    
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"headimgurl"]] placeholderImage:[UIImage imageNamed:@"icon_1.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
//        NSData * iconData = UIImageJPEGRepresentation(image,0.5);

//        [self saveIconToLocal:iconData];
//
//        if (self.net == nil) {
//            self.net = [[NetWork alloc]init];
//        }
    }];
    
    

}

//验证token
#pragma mark- 验证token
- (void)checkingUserToken{
    
    
    if ([self.isLoginState isEqualToString:@"0"]) {
        return;
    }
    
    if (self.net == nil) {
        self.net = [[NetWork alloc]init];
    }
    [self.net checkingUserToken];
    
    __weak Home_ViewController * weakSelf = self;
    
    self.net.checkingToken= ^(NSString * code){
    
        if ([code isEqualToString:@"0"]) {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reLoginHome" object:nil];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"isLogIn"];
            
        }else{
        
            [weakSelf.net firstVcMessageGetOfNet];
            
            weakSelf.net.userInfoMessageB=^(NSString * message,BOOL bb){
            
                NSLog(@"%@",message);
            };
        
        }
        
    };
}


- (void)reLoginAleartView{

    [self.tableView.mj_header endRefreshing];
    
    [self.UserNewGiftView removeFromSuperview];
    
    UILabel * Label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 90)];
    Label.center = self.view.center;
    Label.backgroundColor =[ UIColor blackColor];
    Label.text = [NSString stringWithFormat:@"登录异常，请重新登录!"];
    Label.textColor = [UIColor whiteColor];
    Label.textAlignment = NSTextAlignmentCenter;
    Label.layer.cornerRadius = 5;
    Label.clipsToBounds = YES;
    [self.view addSubview:Label];
    
    [self performSelector:@selector(reLoginPlease:) withObject:Label afterDelay:2];
    
    
}



//重新登录
- (void)reLoginPlease:(UILabel *)label{
    
    [self.missionTaskButton removeFromSuperview];
    [self stopTimer];
    
    [label removeFromSuperview];
    LogInViewController * loginVc = [[LogInViewController alloc]init];
    [self presentViewController:loginVc animated:YES completion:nil];
}



#pragma mark- 文章- Flash - 广告数据-请求
- (NSArray *)getDataOfNet{
    
    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
    }

    [self.net firstVcMessageOfArticle];
    
    
    __weak Home_ViewController * weakSelf = self;
    self.net.fistVcBlock=^(NSArray * array,NSArray * arry2,NSArray * guangGao,NSString * type,NSString * img_url){
        
        weakSelf.guangGaoArray = [NSMutableArray arrayWithArray:guangGao];
        
        weakSelf.dataArray = [NSMutableArray arrayWithArray:array];
        
        int count = (int)guangGao.count;
        
        if (count == 1) {
            
            articleModel *  model = [[articleModel alloc]init];
            
            [weakSelf.dataArray insertObject:model atIndex:1];
            
        }else if (count >1) {
            articleModel *  model = [[articleModel alloc]init];

            [weakSelf.dataArray insertObject:model atIndex:1];
            
            [weakSelf.dataArray insertObject:model atIndex:5];

    
        }else{
        
        }
        
        
        
        weakSelf.flashArray = [NSMutableArray arrayWithArray:arry2];
        
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];

//        flashModel * model;
//        
//        if ((int)arry2.count > 0) {
//            
//            model = arry2[0];
//        }
//
//        [weakSelf.advimg1 sd_setImageWithURL:[NSURL URLWithString:model.adthumb]];
        
        [weakSelf addAdvImageMessageWithType:type andImguRL:img_url];
    };
    
    
    return nil;
}



- (void)reloadUserInfo{
    
    [self userNewGiftViewCreat];

    NSDictionary * dict = [self.userDefauls objectForKey:@"usermessage"];
    NSLog(@"%@",dict);
    
    if (self.hidenReview) {
        
        
        self.label1.text = @"今日阅读";
        self.label2.text = @"总阅读";
        self.label3.text = @"昨日阅读";
        
        self.money1.text = [NSString stringWithFormat:@"昵称:%@",dict[@"nickname"]];

        self.money3.text = [NSString stringWithFormat:@"%@小时",dict[@"today_income"]];

    }else{
        
        self.money1.text = [NSString stringWithFormat:@"余额:%@元",dict[@"residue_money"]];
        self.money3.text = [NSString stringWithFormat:@"%@元",dict[@"today_income"]];
        
        self.label1.text = @"今日收益";
        self.label2.text = @"任务收益";
        self.label3.text = @"徒弟进贡";
    }

    self.money2.text = [NSString stringWithFormat:@"ID:%@",dict[@"uc_id"]];
    self.money6.text = [NSString stringWithFormat:@"Lv:%@",dict[@"level"]];

    
    NSString * task_income_sum_ = dict[@"task_Money"];
    
    if ([task_income_sum_ isEqualToString:@"error"]||task_income_sum_ == nil || [task_income_sum_ isEqual:[NSNull null]]) {
        
        task_income_sum_ = @"0";
    }else{
    
        task_income_sum_ = [NSString stringWithFormat:@"%@",task_income_sum_];
    }
    
    
    if (self.hidenReview) {
        
        self.money4.text = [NSString stringWithFormat:@"%@小时",task_income_sum_];
        self.money5.text = [NSString stringWithFormat:@"%@小时",dict[@"prentice_sum_money"]];

    }else{
        
        self.money4.text = [NSString stringWithFormat:@"%@元",task_income_sum_];
        self.money5.text = [NSString stringWithFormat:@"%@元",dict[@"prentice_sum_money"]];
    
    }
    
    if (!self.isRefresh) {
        
        [self getUserIconFromNet];
    }
    
    
    [self addNewUserHongBao];
    
    [self.tableView.mj_header endRefreshing];
    
    
}


#pragma mark- 每日任务状态
- (void)getDayTaskState{

    
    NSDictionary * userDic = [self.userDefauls objectForKey:@"usermessage"];
    
    NSMutableDictionary * muDic = [NSMutableDictionary dictionaryWithDictionary:userDic];
    
    if (self.net == nil) {
        self.net = [[NetWork alloc]init];
    }

    [self.net dayTaskAchiveStatus];
    
    __weak Home_ViewController * weakSelf = self;
    
    self.net.dayTaskStatusBlock=^(dayTaskModel * model){
    
        muDic[@"share_article"] = model.share_article;
        muDic[@"invite"] = model.invite;
        muDic[@"read"] = model.read;
        muDic[@"share"] = model.share;

    
        NSDictionary * dic = [NSDictionary dictionaryWithDictionary:muDic];
        
        [weakSelf.userDefauls setObject:dic forKey:@"usermessage"];
        
        [weakSelf.userDefauls synchronize];
        
        [weakSelf taskButtonCreat];
        
    };
    
}




#pragma mark- 创建数据库
- (void)CoreDataMangerCreat{
    
    self.CDManger = [CoreDataManger shareCoreDataManger];

}

#pragma mark- navBarCreat

- (void)navBarCreat{

    self.navBar = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 64)];
    [self.view addSubview:_navBar];
    self.navBar.backgroundColor = [UIColor orangeColor];
    self.navBar.alpha = 0;

}


#pragma mark- newUserGiftView-新手福利
- (void)userNewGiftViewCreat{
    
    if (self.hidenReview == YES) {
        
        return;
    }
    
    
    
    NSDictionary * dict = [self.userDefauls objectForKey:@"usermessage"];
    
    NSString * new_member_task = dict[@"new_member_task"];
    NSString * isShowNewUserGift = dict[@"isShowNewUserGift"];
    
    if ([new_member_task isEqualToString:@"1"]) {
        
        return;
    }
    
    if ([isShowNewUserGift isEqualToString:@"0"]) {
        return;
    }
    
    if (self.isNotShowNewGift == YES) {
        return;
    }
    
    if (self.UserNewGiftView == nil) {
        
    self.UserNewGiftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
//    self.UserNewGiftView.backgroundColor =[UIColor colorWithWhite:0 alpha:0.8];
    UIImageView * giftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W *5/6, SCREEN_H *2/3)];
    giftView.userInteractionEnabled = YES;
    giftView.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);
    giftView.image =[UIImage imageNamed:@"welfare_popup.png"];
    [self.UserNewGiftView addSubview:giftView];
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, giftView.bounds.size.width, 30)];
    label1.center = CGPointMake(giftView.bounds.size.width/2, SCREEN_H/3);
    [giftView addSubview:label1];
    label1.text = [NSString stringWithFormat:@"新用户注册，完成新手任务即可!"];
    label1.textColor =[UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:16];
    label1.textAlignment = NSTextAlignmentCenter;
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, giftView.bounds.size.width, 30)];
    label2.center = CGPointMake(giftView.bounds.size.width/2, CGRectGetMaxY(label1.frame)+10);
    [giftView addSubview:label2];
    label2.text = [NSString stringWithFormat:@"额外获得1元红包"];
    label2.textColor =[UIColor yellowColor];
    label2.font = [UIFont systemFontOfSize:16];
    label2.textAlignment = NSTextAlignmentCenter;
    
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0,SCREEN_W/3, 30);
    button.layer.cornerRadius = 5;
    button.center = CGPointMake(giftView.bounds.size.width/2, CGRectGetMaxY(label2.frame) + 30);
    [giftView addSubview:button];
    button.backgroundColor =[UIColor blueColor];
    [button setTitle:[NSString stringWithFormat:@"去赚钱"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goToEarnMoneyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 403;
    
    UIButton * xxbutton =[UIButton buttonWithType:UIButtonTypeCustom];
    xxbutton.frame = CGRectMake(SCREEN_W *5/6 - 30, SCREEN_W/7,20, 20);
    [giftView addSubview:xxbutton];
    [xxbutton setImage:[UIImage imageNamed:@"comm_icon_close_w.png"] forState:UIControlStateNormal];
    [xxbutton addTarget:self action:@selector(goToEarnMoneyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    xxbutton.tag = 404;
    
    UIButton * button2 =[UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 0,SCREEN_W/2, 30);
    button2.center = CGPointMake(giftView.bounds.size.width/2, CGRectGetMaxY(button.frame) + 30);
    [giftView addSubview:button2];
    button.backgroundColor =[UIColor blueColor];
    [button2 setTitle:[NSString stringWithFormat:@"不再显示"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(goToEarnMoneyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button2.titleLabel.font = [UIFont systemFontOfSize:14];
    [button2 setImage:[UIImage imageNamed:@"welfare_checkbox_checked.png"] forState:UIControlStateSelected];
    [button2 setImage:[UIImage imageNamed:@"welfare_checkbox.png"] forState:UIControlStateNormal];
    button2.adjustsImageWhenHighlighted = NO;
    button2.titleEdgeInsets = UIEdgeInsetsMake(0,5, 0, 0);
    [button2 addTarget:self action:@selector(goToEarnMoneyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 405;
    
    }
    
    [self.view addSubview:_UserNewGiftView];

}


- (void)goToSecond{
    
    self.tabBarController.selectedIndex = 1;

}


- (void)goToEarnMoneyButtonAction:(UIButton *)bt{
    if (bt.tag == 403) {
        NSLog(@"去赚钱");
        [self.UserNewGiftView removeFromSuperview];

        [self performSelector:@selector(goToSecond) withObject:nil afterDelay:0.2];
        
    }else if(bt.tag == 404) {
        NSLog(@"404");
        
        self.isNotShowNewGift = YES;
        
        [self.UserNewGiftView removeFromSuperview];
        
    }else if(bt.tag == 405){
    
        bt.selected = !bt.selected;
        NSLog(@"x");
        
        
        if (bt.selected == YES) {
            
            NSLog(@"yes");

            
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"usermessage"]];
            dict[@"isShowNewUserGift"] = [NSString stringWithFormat:@"0"];
            
            NSDictionary * dic = [NSDictionary dictionaryWithDictionary:dict];
            
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"usermessage"];
            
            
            NSLog(@"%@",dic);
            
        }else{
        
            NSLog(@"no");

            
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"usermessage"]];
            dict[@"isShowNewUserGift"] = [NSString stringWithFormat:@"1"];
            
            NSDictionary * dic = [NSDictionary dictionaryWithDictionary:dict];
            
            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"usermessage"];
        
        }
        
    }else{
    
    
    
    }

}




#pragma mark- 已登录
- (void)headViewIsLogInCreat{
    
//    NSUserDefaults * defauls = [NSUserDefaults standardUserDefaults];
    
//    NSDictionary * dic = [defauls objectForKey:@"usermessage"];
    
    self.headViewIsLogIn = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W, 0, SCREEN_W, SCREEN_H/4 + SCREEN_W/10)];
    [self.headScrollView addSubview:_headViewIsLogIn];
    
    self.headViewIsLogIn.backgroundColor = [UIColor colorWithRed:248/255.0 green:131/255.0 blue:12/255.0 alpha:1];
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 35, SCREEN_W/5, SCREEN_W/5)];
    [self.headViewIsLogIn addSubview:_iconImageView];
#pragma mark- 头像
    
    NSDictionary * dict = [self.userDefauls objectForKey:@"usermessage"];
    
    NSString * headimgurl = dict[@"headimgurl"];
    
    NSLog(@"iconPath = %@",headimgurl);
    
#pragma mark- 头像查询
//    NSString * iconPath =  [self.CDManger checkDataWithIconPath];
//    
//    NSLog(@"头像路劲=>%@",iconPath);
    
    if (headimgurl == nil ) {
        
        self.iconImageView.image = [UIImage imageNamed:@"icon_1.png"];
        
    }else{
    
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:headimgurl]];
        
    }
    
    
    
    self.iconImageView.layer.cornerRadius = SCREEN_W/10;
    self.iconImageView.clipsToBounds = YES;
    self.iconImageView.userInteractionEnabled = YES;
#pragma mark- 头像按钮
    self.buttonOfIcon = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.buttonOfIcon.frame = CGRectMake(15, 35, SCREEN_W/5, SCREEN_W/5);
    self.buttonOfIcon.frame = self.iconImageView.bounds;
    [self.iconImageView addSubview:_buttonOfIcon];
    [self.buttonOfIcon addTarget:self action:@selector(changCustomerIocn) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel * residueLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame)+10, 40, 150, 20)];
    residueLabel.text = [NSString stringWithFormat:@"余额:%@元",dict[@"residue_money"]];
//    residueLabel.text = [NSString stringWithFormat:@"昵称:%@",dict[@"nickname"]];

    residueLabel.textColor = [UIColor whiteColor];
    residueLabel.font = [UIFont systemFontOfSize:17];
    self.money1 = residueLabel;
    
    [self.headViewIsLogIn addSubview:residueLabel];
    
    UILabel * userIdLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame)+10, CGRectGetMaxY(residueLabel.frame)+5, 120, 20)];;
    userIdLabel.text = [NSString stringWithFormat:@"ID:%@",dict[@"uc_id"]];
    userIdLabel.textColor = [UIColor whiteColor];
    userIdLabel.font =[UIFont systemFontOfSize:16];
    self.money2 = userIdLabel;
    [self.headViewIsLogIn addSubview:userIdLabel];
    
    
    UILabel * userLevelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame)+10, CGRectGetMaxY(userIdLabel.frame)+5, 120, 20)];;
    userLevelLabel.text = [NSString stringWithFormat:@"Lv:%@",dict[@"level"]];
    userLevelLabel.textColor = [UIColor whiteColor];
    userLevelLabel.font =[UIFont systemFontOfSize:15];
    self.money6 = userLevelLabel;
    [self.headViewIsLogIn addSubview:userLevelLabel];
    
    
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(SCREEN_W * 4 / 5 - 10, 40, SCREEN_W/5, 25);
    [button1 setTitle:[NSString stringWithFormat:@"收益明细"] forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor whiteColor];
    button1.titleLabel.font = [UIFont systemFontOfSize:13];
    button1.layer.cornerRadius = 3;
    
    
    if (self.hidenReview == YES) {
        
        button1.hidden = YES;
    }
    
    
    self.inComeDetailButton = button1;
    [self.headViewIsLogIn addSubview:button1];
#pragma mark- button.tag-4000
    button1.tag = 4000;
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(SCREEN_W * 4 / 5 - 10, CGRectGetMaxY(button1.frame) + 5, SCREEN_W/5, 25);
    [button2 setTitle:[NSString stringWithFormat:@"提现记录"] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor whiteColor];
    button2.titleLabel.font = [UIFont systemFontOfSize:13];
    button2.layer.cornerRadius = 3;
    [self.headViewIsLogIn addSubview:button2];
    
    if (self.hidenReview == YES) {
        
        button2.hidden = YES;
    }
    
    self.drawRecordBt = button2;
    
    
    
#pragma mark- button.tag-4001
    button2.tag = 4001;
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    UIButton * bellButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bellButton.frame = CGRectMake(CGRectGetMinX(button1.frame) - 5 -20, CGRectGetMinY(button1.frame), 20, 20);
//    bellButton.backgroundColor = [UIColor redColor];
    [self.headViewIsLogIn addSubview:bellButton];
    bellButton.layer.cornerRadius = 10;
#pragma mark- button.tag-4002
    bellButton.tag = 4002;
    [bellButton setImage:[UIImage imageNamed:@"icon_ring2.png"] forState:UIControlStateNormal];
    [bellButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.hidenReview == YES) {
    
        bellButton.hidden = YES;
    }
    
    self.bellButton = bellButton;
    
//    NSArray * titleArray = @[@"今日阅读",@"总阅读",@"昨日阅读"];
    NSArray * titleArray = @[@"今日收益",@"任务收益",@"徒弟进贡"];
    NSArray * detailArray = @[[NSString stringWithFormat:@"%@元",dict[@"today_income"]],[NSString stringWithFormat:@"%@元",dict[@"task_Money"]],[NSString stringWithFormat:@"%@元",dict[@"prentice_sum_money"]]];
    
    NSMutableArray * array = [NSMutableArray new];
    NSMutableArray * array2 = [NSMutableArray new];

    
    for (int i = 0; i < 3; i++) {
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(-1 + ( SCREEN_W /3)*i, 2*self.headViewIsLogIn.bounds.size.height/3, SCREEN_W/3, self.headViewIsLogIn.bounds.size.height/3)];
        [self.headViewIsLogIn addSubview:view];
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = [UIColor whiteColor].CGColor;
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake( 0, 0,100,20)];
        label.center = CGPointMake(view.bounds.size.width/2, 20);
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
        label.text = titleArray[i];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor whiteColor];
        [array2 addObject:label];
        
        UILabel * detailLabel =[[ UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
        [view addSubview:detailLabel];
        detailLabel.center = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2 + 10);
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.text = detailArray[i];
        detailLabel.font = [UIFont systemFontOfSize:13];
        detailLabel.textColor = [UIColor whiteColor];
        
        [array addObject:detailLabel];
        
        
        /*
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width - 15,view.frame.size.height - 15, 10, 10)];
        imageView.image = [UIImage imageNamed:@"home_icon_more.png"];
        [view addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        */
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, view.bounds.size.width,view.bounds.size.height);
        button.tag = 4008+i;
        [view addSubview:button];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }

    self.money3 = array[0];
    self.money4 = array[1];
    self.money5 = array[2];

    self.label1 = array2[0];
    self.label2 = array2[1];
    self.label3 = array2[2];

}


#pragma mark- 未登录
- (void)headViewUnLogInCreat{
    
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H/4 + SCREEN_W/10)];
    [self.headScrollView addSubview:_headView];
    self.headView.backgroundColor = [UIColor colorWithRed:248/255.0 green:131/255.0 blue:12/255.0 alpha:1];
    
#pragma mark- -登录按钮
    self.loadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loadButton.frame = CGRectMake(0, 0, SCREEN_W/3, 30);
    self.loadButton.center = CGPointMake(SCREEN_W/2, 64);
    [self.headView addSubview:_loadButton];
    [self.loadButton setTitle:[NSString stringWithFormat:@"请登录"] forState:UIControlStateNormal];
#pragma mark- loadButtonTag-1000
    self.loadButton.tag = 1000;
    self.loadButton.layer.borderWidth = 1;
    self.loadButton.layer.borderColor =[UIColor blackColor].CGColor;
    self.loadButton.layer.cornerRadius= 5;
    [self.loadButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    NSArray * titleArray = @[@"请登录",@"请登录",@"请登录"];
    NSArray * detailArray = @[@"----",@"----",@"----"];
    for (int i = 0; i < 3; i++) {
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(-1 + ( SCREEN_W /3)*i, 2*self.headView.bounds.size.height/3, SCREEN_W/3, self.headView.bounds.size.height/3)];
        [self.headView addSubview:view];
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
        
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width - 20,view.frame.size.height - 20, 15, 15)];
        imageView.image = [UIImage imageNamed:@"home_icon_more.png"];
        [view addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, view.bounds.size.width,view.bounds.size.height);
        button.tag = 4005+i;
        [view addSubview:button];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}

#pragma mark- changCustomerIocn
- (void)changCustomerIocn{

    @try {
        
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera | UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIAlertController * alerate = [UIAlertController alertControllerWithTitle:@"图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alerate addAction:[UIAlertAction actionWithTitle:@"相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            self.picker = imagePicker;
            
        }]];
        
        
        [alerate addAction:[UIAlertAction actionWithTitle:@"来自图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            
            self.picker = imagePicker;
            
        }]];
        
        
        [alerate addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"用户取消");
        }]];
        [self presentViewController:alerate animated:YES completion:nil];

        
    }else if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary | UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
    
        UIAlertController * alerate = [UIAlertController alertControllerWithTitle:@"图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alerate addAction:[UIAlertAction actionWithTitle:@"来自图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            
            self.picker = imagePicker;
            
        }]];

        [alerate addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"用户取消");
    }]];
        
        [self presentViewController:alerate animated:YES completion:nil];

    }
        
    }
    @catch (NSException *exception) {
        
        // 捕获到的异常exception
        NSString * reson = exception.reason;
        
        NSLog(@"reson => %@",reson);
    }
    
    @finally {
        
        // 结果处理
        
    }

}

#pragma mark- pickerDelegater
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    
    NSLog(@"done");
    
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    self.iocnImg = image;
    
//    压缩图片
//    NSData * iconData = UIImageJPEGRepresentation(image,0.5);
#pragma mark- 上传图片
    
   UIImage * image2 = [self compressOriginalImage:image toSize:CGSizeMake(640, 640)];
    
    NSData * iconData2 = UIImageJPEGRepresentation(image2,0.5);

    
    [self.net userIconUpLoadToPhp:iconData2];
    
    __weak Home_ViewController * weakSelf = self;
    
    self.net.iconUpLoadB=^(NSString * message,BOOL isSucceeds){
    
        NSLog(@"上传图片:%@",message);
    
        if (isSucceeds) {
            
            [weakSelf MJrefreshData];
        }
        
        
        [weakSelf iconUpLoadAlerate:isSucceeds];
        
    };
    
    
}

#pragma mark- 头像上传成功提示
- (void)iconUpLoadAlerate:(BOOL)isSucceed{

    UILabel * laber = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    laber.center = CGPointMake(SCREEN_W/2, -15);
    laber.backgroundColor = [UIColor blackColor];
    laber.textColor = [UIColor whiteColor];
    laber.font = [UIFont boldSystemFontOfSize:14];
    laber.textAlignment = NSTextAlignmentCenter;
    laber.layer.cornerRadius = 6;
    laber.clipsToBounds = YES;
    [self.view addSubview:laber];
    
    if (isSucceed) {
        laber.text = @"头像上传成功";
    }else{
    
        laber.text = @"头像上传失败";
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        laber.center = CGPointMake(SCREEN_W/2, 42);

        
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(removeLabel:) withObject:laber afterDelay:1];
    }];
    
    
}


- (void)removeLabel:(UILabel *)label{

    [label removeFromSuperview];
}


-(UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size{
    UIImage * resultImage = image;
    UIGraphicsBeginImageContext(size);
    [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    
    HomeNextViewController * homeNext = [[HomeNextViewController alloc]init];
    homeNext.buttonTag = button.tag;
    
    LogInViewController * logInVc = [[LogInViewController alloc]init];
    
    if(button.tag == 1000 || button.tag == 4005 || button.tag == 4006|| button.tag == 4007){
        NSLog(@"1000");

        self.isRefresh = NO;
        
        LogInViewController * logInVc = [[LogInViewController alloc]init];
        [self presentViewController:logInVc animated:YES completion:nil];
    
    }else if (button.tag == 8000){
        NSLog(@"8000");
        
        NSString * isLogIn = [self.userDefauls objectForKey:@"isLogIn"];
        
        if([isLogIn isEqualToString:@"1"]){
            
            if (self.hidenReview == YES) {

                ResetCodeViewController * vc = [[ResetCodeViewController alloc]init];
            
                [self presentViewController:vc animated:YES completion:nil];
                
            }else{
                
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:homeNext animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
        }else{
           
            
            [self presentViewController:logInVc animated:YES completion:nil];

        }

    }else if (button.tag == 8001){
        NSLog(@"8001-我要提现");

        NSString * isLogIn = [self.userDefauls objectForKey:@"isLogIn"];
        
        if([isLogIn isEqualToString:@"1"]){
            
            /*旧
            self.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:homeNext animated:YES];
            
            self.hidesBottomBarWhenPushed = NO;
            */

            
            //新
            
            if (self.hidenReview == YES) {
            
                RingMessageVC * ringVc = [[RingMessageVC alloc]init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:ringVc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
                
            }else{
            
                WeiXinAndAliPayWithDrawVC * vc = [[WeiXinAndAliPayWithDrawVC alloc]init];
            
                self.hidesBottomBarWhenPushed = YES;
            
                [self.navigationController pushViewController:vc animated:YES];
            
                self.hidesBottomBarWhenPushed = NO;
            }
            
        }else{
            [self presentViewController:logInVc animated:YES completion:nil];

                   }

    }else if (button.tag == 8002){
        NSLog(@"8002");
        
        if (self.hidenReview == YES) {
            
            webViewController * web = [[webViewController alloc]init];
            NSString * type = @"privacy";
            NSString * str = @"http://wz.lgmdl.com/App/Course/newCourse/type/";
            NSString * url = [NSString stringWithFormat:@"%@%@",str,type];
            
            web.isNewTeach = YES;
            
            web.urlString = url;
            
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:web animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            
        }else{

        
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:homeNext animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            }
        
    }else if (button.tag == 8003){
        NSLog(@"8003");
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:homeNext animated:YES];
        self.hidesBottomBarWhenPushed = NO;

    }else if (button.tag == 8004){
        NSLog(@"8004");
        
        NSString * isLogIn = [self.userDefauls objectForKey:@"isLogIn"];
        
        if([isLogIn isEqualToString:@"1"]){
            
            AddArticleController * vc = [[AddArticleController alloc]init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }else{
           
            [self presentViewController:logInVc animated:YES completion:nil];

        }

    }else if (button.tag == 8005){
        NSLog(@"8005");
        
        NSString * isLogIn = [self.userDefauls objectForKey:@"isLogIn"];
        
        if([isLogIn isEqualToString:@"1"]){
            
            if (self.hidenReview == YES) {
                
                EditProfileViewController * vc = [[EditProfileViewController alloc]init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }else{
            
            
                NSLog(@"超级折扣");
            
                TaoBaoDiscountController * vc = [[TaoBaoDiscountController alloc]init];
                
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
                
//                [self awakensTheDisciple];
            }
        }else{
            
        [self presentViewController:logInVc animated:YES completion:nil];

        }

    }else if (button.tag == 8006){
        NSLog(@"8006");

        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:homeNext animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if (button.tag == 8007){
        NSLog(@"8007");
        
        if (self.hidenReview == YES) {
            
            webViewController * web = [[webViewController alloc]init];
            NSString * type = @"register";
            NSString * str = @"http://wz.lgmdl.com/App/Course/newCourse/type/";
            NSString * url = [NSString stringWithFormat:@"%@%@",str,type];
            
            web.isNewTeach = YES;
            
            web.urlString = url;
            
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:web animated:YES];
            self.hidesBottomBarWhenPushed = NO;

        }else{
        
        
            self.hidesBottomBarWhenPushed = YES;

            [self.navigationController pushViewController:homeNext animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
        
        
    }else if (button.tag == 103){
        NSLog(@"103-转发赚啦");
        
        self.tabBarController.selectedIndex = 3;
        
        
    }else if (button.tag == 101){
        NSLog(@"101");
        
        if ([self.isLoginState isEqualToString:@"1"]) {
            
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:homeNext animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        }else{
        
            [self presentViewController:logInVc animated:YES completion:nil];

        }
        
        
        
    }else if (button.tag == 102){
        NSLog(@"102");
        
        self.tabBarController.selectedIndex = 3;
    }else if (button.tag == 4000 || button.tag == 4008 || button.tag == 4009|| button.tag == 4010){
        NSLog(@"4000-收益明细-%ld",button.tag);
        
        if (self.hidenReview) {
            
            return;
        }
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:homeNext animated:YES];
        self.hidesBottomBarWhenPushed = NO;

    }else if (button.tag == 4001){
        NSLog(@"4001");
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:homeNext animated:YES];
        self.hidesBottomBarWhenPushed = NO;

        
        
    }else if (button.tag == 4002){
        NSLog(@"4002");
        
        RingMessageVC * ringVc = [[RingMessageVC alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ringVc animated:YES];
        self.hidesBottomBarWhenPushed = NO;

    }

}

#pragma mark- 滚动横幅
- (void)advViewCreat{

    self.advView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,SCREEN_H/4 + SCREEN_W/10, SCREEN_W, SCREEN_W/4 + SCREEN_W/10)];
//    self.advView.contentSize = CGSizeMake(SCREEN_W * 2, 0);
    self.advView.pagingEnabled = YES;
    self.advView.bounces = NO;
    self.advView.delegate = self;
//    self.advView.scrollEnabled = NO;
    self.advView.userInteractionEnabled = YES;
    self.advView.tag = 3003;
    
    [self.tableHeadView addSubview:_advView];
    
    self.advView.backgroundColor =[UIColor whiteColor];
    
    
    self.advimg1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W/4 + 30)];
    self.advimg1.image = [UIImage imageNamed:@"load.png"];
    [self.advView addSubview:self.advimg1];
    self.advimg1.userInteractionEnabled = YES;
//
//    self.advimg2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W, 0, SCREEN_W, SCREEN_W/4 + 30)];
//    self.advimg2.image = [UIImage imageNamed:@"load.png"];
//    [self.advView addSubview:self.advimg2];
//    self.advimg2.userInteractionEnabled = YES;
//
//    
//    
//    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button1.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_W/4);
//    [self.advimg1 addSubview:button1];
//    [button1 addTarget:self action:@selector(advViewAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button2.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_W/4);
//    [self.advimg2 addSubview:button2];
//    [button2 addTarget:self action:@selector(advViewAction:) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark- 添加横幅内容
- (void)addAdvImageMessageWithType:(NSString *)type andImguRL:(NSString *)img_url{
    
    NSInteger count = self.flashArray.count;
    NSLog(@"%ld",count);
    
    for (int i = 0; i < count; i ++) {
        
        flashModel * model = self.flashArray[i];
        
        if (i == 0) {
            
            if (![type isEqualToString:@"1"]) {
                
                [self.advimg1 sd_setImageWithURL:[NSURL URLWithString:img_url] placeholderImage:[UIImage imageNamed:@"load.png"]];

                
            }else{
            
                [self.advimg1 sd_setImageWithURL:[NSURL URLWithString:model.adthumb] placeholderImage:[UIImage imageNamed:@"load.png"]];
            
                UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
                button1.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_W/4);
                button1.tag = 5500;
                [self.advimg1 addSubview:button1];
                [button1 addTarget:self action:@selector(advViewAction:) forControlEvents:UIControlEventTouchUpInside];
            }
        }else{
            UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W *i, 0, SCREEN_W, SCREEN_W/4+30)];
            imageV.userInteractionEnabled = YES;
            [self.advView addSubview:imageV];
            [imageV sd_setImageWithURL:[NSURL URLWithString:model.adthumb] placeholderImage:[UIImage imageNamed:@"load.png"]];
        
            
            UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
            button2.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_W/4);
            button2.tag = 5501;
            [imageV addSubview:button2];
            [button2 addTarget:self action:@selector(advViewAction:) forControlEvents:UIControlEventTouchUpInside];

        
        }
        
    }
    
        self.advView.contentSize = CGSizeMake(SCREEN_W * count, 0);

    if (count > 1) {
        [self creatPageControl:count];
    }else{
        [self.pageControl removeFromSuperview];
    }
    
    
#pragma mark- 添加横幅定时器
    
    [self addadvTimer];
    
}


- (void)creatPageControl:(NSInteger)pageNum{

    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.pageControl.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(self.advView.frame)-15);
    self.pageControl.numberOfPages = pageNum;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self.tableHeadView addSubview:self.pageControl];
    

}


- (void)advViewAction:(UIButton *)bt{
    NSLog(@"广告");
    //self.tabBarController.selectedIndex = 3;

    if (bt.tag == 5500) {
        
        AddArticleController * vc = [[AddArticleController alloc]init];
        
        self.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;

        
        
    }else if (bt.tag == 5501){
    
        TaoBaoDiscountController * vc = [[TaoBaoDiscountController alloc]init];
        
        self.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
    
    [self stopAdvTimer];
    
}

#pragma mark- 任务按钮
- (void)taskButtonCreat{
    
    if (!self.missionTaskButton) {
        
        self.missionTaskButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.missionTaskButton.frame = CGRectMake(0, SCREEN_H/4 + 30, SCREEN_W, 22);
//        [self.missionTaskButton setTitle:@"每日任务未完成" forState:UIControlStateNormal];
        self.missionTaskButton.backgroundColor = [UIColor yellowColor];
        [self.missionTaskButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.missionTaskButton.titleLabel.font = [UIFont systemFontOfSize:13];
        
        //    self.missionTaskButton.tag = 1221;
        
        [self.missionTaskButton addTarget:self action:@selector(taskButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    [self.tableHeadView addSubview:_missionTaskButton];

    
    self.currentMissionTag = 6600;
    self.lastMissionTag = 0;
    [self addTimer];
    
}



//广告定时器
- (void)addadvTimer{
    
    
    if(self.advTimer == nil){
        
        self.advTimer= [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changeAdvPage) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop]addTimer:self.advTimer forMode:NSRunLoopCommonModes];
        
    }
}



- (void)stopAdvTimer{

    [self.advTimer invalidate];
    
    self.advTimer = nil;

}



#pragma mark- 改变横幅位置
- (void)changeAdvPage{

    if (self.flashArray.count > 0) {
        
    
        NSInteger pageNum = self.flashArray.count;
    
    
        if (self.pageControl.currentPage +1 != pageNum && self.left) {
        
            
            self.pageControl.currentPage ++;

            [self.advView setContentOffset:CGPointMake(SCREEN_W * self.pageControl.currentPage, 0) animated:YES];
            
        
        }else{
        
        
            self.left = NO;
            

            
        }
        
        
        if (self.pageControl.currentPage != 0 && self.left == NO) {
        
            self.pageControl.currentPage --;

            [self.advView setContentOffset:CGPointMake(SCREEN_W * self.pageControl.currentPage, 0) animated:YES];
            
        
        }else{
        
            self.left = YES;

        }

    }
}





//定时器
- (void)addTimer{

    
    if(self.timer == nil){
    
    self.timer= [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(missionTaskButtonTitleAndTag) userInfo:nil repeats:YES];

    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    }
}

//结束定时器

- (void)stopTimer{

    
    [self.missionTaskButton removeFromSuperview];
    
    [self.timer invalidate];
    self.timer = nil;

}


//切换标题
- (void)missionTaskButtonTitleAndTag{

    [self reloadGuangGao];
    
//    NSInteger tag1 = 0;
//    NSInteger tag2 = 0;
//    NSInteger tag3 = 0;
//    NSInteger tag4 = 0;
//    NSInteger tag5 = 0;

    NSMutableArray * array = [NSMutableArray new];
    
    NSDictionary * mission = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    
    NSInteger count = mission.count;
    NSLog(@"%ld",count);
    
    NSString * share_article = [NSString stringWithFormat:@"%@",mission[@"share_article"]];
    NSString * invite = [NSString stringWithFormat:@"%@",mission[@"invite"]];
    NSString * read = [NSString stringWithFormat:@"%@",mission[@"read"]];
    NSString * share = [NSString stringWithFormat:@"%@",mission[@"share"]];
    NSString * new_member_task = [NSString stringWithFormat:@"%@",mission[@"new_member_task"]];
    
    NSLog(@"%@-%@-%@-%@-%@",share_article,invite,read,share,new_member_task);

    [array addObject:share_article];   //享立赚
    [array addObject:invite];          //邀请
    [array addObject:read];            //阅读赚
    [array addObject:share];           //分享
    [array addObject:new_member_task]; //新手任务
    

    while (![array[self.currentMissionTag -  6600] isEqualToString:@"0"]) {
        
        self.currentMissionTag++;
        
        if (self.currentMissionTag-6600>4) {
            break;
        }
    }
    
    
    
    self.missionTaskButton.tag = self.currentMissionTag;
    
    NSLog(@"%ld",self.missionTaskButton.tag);
    
    if (self.currentMissionTag == 6604) {
        
        [self.missionTaskButton setTitle:[NSString stringWithFormat:@"新手任务未完成"] forState:UIControlStateNormal];

    }else if (self.currentMissionTag == 6602){
    
        [self.missionTaskButton setTitle:[NSString stringWithFormat:@"您今日未完成阅读赚任务"] forState:UIControlStateNormal];

    }else if (self.currentMissionTag == 6603){
        
        [self.missionTaskButton setTitle:[NSString stringWithFormat:@"您今日未完成享立赚任务"] forState:UIControlStateNormal];
    
    }else if(self.currentMissionTag == 6600 ||self.currentMissionTag == 6601){
        
        [self.missionTaskButton setTitle:[NSString stringWithFormat:@"每日任务未完成"] forState:UIControlStateNormal];
    }
    
    self.currentMissionTag ++;

    if (self.currentMissionTag > 6604) {
        
        self.currentMissionTag = 6600;
        self.lastMissionTag = 0;
    }
    
    
    
    if (self.flashArray.count > 1) {
        
    
        
        /*
        static BOOL right = YES;
        static BOOL left = NO;
        
        if (self.pageControl.currentPage + 1 == pageNum && right == YES) {
            left = YES;
            right = NO;
        }
        
        if (self.pageControl.currentPage ==0 && left == YES) {
            left = NO;
            right = YES;
        }

        
        
        if (right) {
            [self.advView setContentOffset:CGPointMake(self.advView.contentOffset.x + SCREEN_W, 0) animated:YES];
            self.pageControl.currentPage = (self.advView.contentOffset.x + SCREEN_W)/SCREEN_W;

        }else{
        
            [self.advView setContentOffset:CGPointMake(self.advView.contentOffset.x - SCREEN_W, 0) animated:YES];
            self.pageControl.currentPage = (self.advView.contentOffset.x - SCREEN_W)/SCREEN_W;

        }
        */
        
    }
    
    
    
}



- (void)goToFourVC{

    self.tabBarController.selectedIndex = 3;

}


#pragma mark- 任务buttonAction
- (void)taskButtonAction:(UIButton *)bt{
    
    MoneyNextVC * moneyVc = [[MoneyNextVC alloc]init];

    __weak Home_ViewController * weakSelf = self;

    moneyVc.toFourVc=^{
    
        [weakSelf performSelector:@selector(goToFourVC) withObject:nil afterDelay:0.5];
        
    };
    
    if (bt.tag == 6600 || bt.tag == 6601) {
        NSLog(@"每日任务");
        moneyVc.buttonTag = 1221;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:moneyVc animated:YES];
        self.hidesBottomBarWhenPushed = NO;

        
        
    }else if (bt.tag == 6602) {
        NSLog(@"阅读赚");
        moneyVc.buttonTag = 1;
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:moneyVc animated:YES];
        self.hidesBottomBarWhenPushed = NO;

        
        
    }else if (bt.tag == 6603) {
        NSLog(@"享立赚");
        moneyVc.buttonTag = 2;
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:moneyVc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        

        
    }else if (bt.tag == 6604) {
        NSLog(@"新手");
        moneyVc.buttonTag = 1222;
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:moneyVc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
        
    }
    
}

#pragma mark- eightbuttonViewCreat
- (void)eightButtonViewCreat{
    
    if ([_isLoginState isEqualToString:@"1"]) {
        self.eightButtonView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_W/10 + SCREEN_H/4 + SCREEN_W/10 + SCREEN_W/4, SCREEN_W, SCREEN_H/4 + SCREEN_W/10)];
    }else{
    
        self.eightButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_W/10 + SCREEN_H/4 + SCREEN_W/10 + SCREEN_W/4, SCREEN_W, SCREEN_H/4 + SCREEN_W/10)];
    }
    
    
    self.eightButtonView.backgroundColor = [UIColor whiteColor];
    [self.tableHeadView addSubview:_eightButtonView];
    
    
    NSArray * buttonTitleArray = @[@"签到",@"我要提现",@"收入排行",@"联系我们",@"导入文章",@"超级折扣",@"系统设置",@"新手教程"];
    NSArray * buttonPicArray = @[@"xgmm.png",@"xtxx.png",@"gywm.png",@"home_contact.png",@"icon_add_article",@"home_awaken.png",@"home_set.png",@"home_play.png"];

    for (int i = 0; i  < 8; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake((SCREEN_W - (SCREEN_W/6 * 4 + 90))/2 + (SCREEN_W/6 + 30)* (i%4),20 + (20 + _eightButtonView.bounds.size.height/3)*(i/4), SCREEN_W/7, SCREEN_W/7);
        
        
        button.frame = CGRectMake((SCREEN_W - (SCREEN_W/6 * 4))/5 + (SCREEN_W/6 + (SCREEN_W - (SCREEN_W/6 * 4))/5)* (i%4),20 + (20 + _eightButtonView.bounds.size.height/3)*(i/4), SCREEN_W/7, SCREEN_W/7);
        
        [button setImage:[UIImage imageNamed:buttonPicArray[i]] forState:UIControlStateNormal];
        
//        [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.eightButtonView addSubview:button];
//        button.backgroundColor = [UIColor redColor];
//        button.titleLabel.font = [UIFont systemFontOfSize:12];
        
#pragma mark- eightButtonTag-8000+
        button.tag = 8000 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0,0, SCREEN_W/4, SCREEN_W/15)];
        title.textColor = [UIColor blackColor];
        title.font = [UIFont systemFontOfSize:13.0];
//        title.backgroundColor = [UIColor redColor];
        title.text = buttonTitleArray[i];
        title.center = CGPointMake(button.center.x, CGRectGetMaxY(button.frame) + SCREEN_W/30);
        title.textAlignment = NSTextAlignmentCenter;
        [self.eightButtonView addSubview:title];
        
        if (i == 1) {
            
            self.drawCashlb = title;
        }
        
        
        if (i == 2) {
            self.incomeRanklb = title;
        }
        
        if (i == 0) {
        
            self.signDaylb = title;
            
        }
        
        
        if(i == 5){
            
            self.wakeUplb = title;
        }
        
        
        if (i == 0 && self.hidenReview == NO) {
            
            title.text = @"签到";
        }
        
        if (i == 5 && self.hidenReview == NO) {
            
            title.text = @"超级折扣";
        }

    }

}
//================

#pragma mark- 头部试图
- (void)tableHeadViewCreat{
    self.tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, (SCREEN_W/4 + SCREEN_W/10)+(SCREEN_H/4 + SCREEN_W/10) * 2)];
//    self.tableHeadView.backgroundColor = [UIColor redColor];
    
    self.tableHeadView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];

    
        [self headScrollviewCreat];
    
    
        [self headViewIsLogInCreat];//SCREEN_H/4 + SCREEN_W/10
    
        [self headViewUnLogInCreat];
    

    
        [self eightButtonViewCreat];//SCREEN_H/4 + SCREEN_W/10
    
        [self advViewCreat];        //SCREEN_W/4 + SCREEN_W/10

}



- (void)headScrollviewCreat{

    self.headScrollView =[[ UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H/4 + SCREEN_W/10)];

    self.headScrollView.contentSize = CGSizeMake(SCREEN_W*2, 0);
    self.headScrollView.scrollEnabled = NO;
    
    if ([self.isLoginState isEqualToString:@"1"]) {
        
        self.headScrollView.contentOffset = CGPointMake(SCREEN_W, 0);

    }else{
    
        self.headScrollView.contentOffset = CGPointMake(0, 0);
    }
    
    [self.tableHeadView addSubview:self.headScrollView];
    
    
    
}



/** creatTableView*/
- (void)creatTableview{

    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 49) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableHeaderView =self.tableHeadView;
    
//    tableView.showsVerticalScrollIndicator = NO;

    
    self.tableView = tableView;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MJrefreshData)];


}


#pragma mark- 下拉刷新
- (void)MJrefreshData{
 
    if (self.NetWorkStatus == NO) {
        
        [self.tableView.mj_header endRefreshing];
        return;
    }
  
    
    
    NSLog(@"下拉刷新!");
    self.isRefresh = YES;
    //首页文章数据
    [self getDataOfNet];
    
    
    if (self.net == nil) {
        self.net = [[NetWork alloc]init];
    }
    
    
    if ([self.isLoginState isEqualToString:@"1"]) {
        
        //用户数据
        [self.net firstVcMessageGetOfNet];
        
        self.net.userInfoMessageB = ^(NSString * message,BOOL isSucceeds){
        
        };
        
        
        //    __weak Home_ViewController * weakSelf = self;
        
    }
    
 
    [self buttonHidenWhenReview];
}


#pragma mark- 上拉加载更多
- (void)MJLoadingMore{
    NSLog(@"上拉加载更多!");
    [self.tableView.mj_footer endRefreshing];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        
        if (self.hidenReview == NO) {
            
            return 3;
            
        }else{
        
            return 0;
        }
        
        
    }else{
        return self.dataArray.count ;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        
        
        UITableViewCell * cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell2 == nil) {
            
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell2"];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"task_share.png"];
            cell.textLabel.text = @"转发赚";
            cell.detailTextLabel.text = @"分享即可获得收益";
            return cell;

        }else if (indexPath.row == 1){
        
            cell.imageView.image = [UIImage imageNamed:@"task_red.png"];
            cell.textLabel.text = @"抢红包";
            cell.detailTextLabel.text = @"每天准点抢红包";
            return cell;

        }else{
            
            cell2.textLabel.text = @"高收益文章";
            cell2.detailTextLabel.text = @"分享后的文章被你朋友阅读+0.05元";
            cell2.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell2.detailTextLabel.textColor = [UIColor lightGrayColor];
            return cell2;
        
        }
        
        
    }else{
    

        typeOneCell * oneCell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell_one_%ld",indexPath.row]];
        
        if (oneCell == nil) {
            oneCell = [[typeOneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[NSString stringWithFormat:@"cell_one_%ld",indexPath.row]];
        
        }
    
    
        typeTwoCell * twoCell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell_two_%ld",indexPath.row]];
        if (twoCell == nil) {
            twoCell = [[typeTwoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[NSString stringWithFormat:@"cell_two_%ld",indexPath.row]];
        }
    
    
    
        int count = (int)self.guangGaoArray.count;
    
    
        if (count == 1 && indexPath.row == 1) {
        
            guaoGaoModel * model = self.guangGaoArray[0];
        
            oneCell.model4 = model;
            return oneCell;

        }else if(count == 2 && (indexPath.row == 1 || indexPath.row == 5)){
        
            if (indexPath.row == 1) {
                guaoGaoModel * model = self.guangGaoArray[0];
            
                oneCell.model4 = model;
                return oneCell;
            
            }else{
            
                guaoGaoModel * model = self.guangGaoArray[1];
            
                oneCell.model4 = model;
                return oneCell;
            
            }
    
        }else if (count > 2 && (indexPath.row == 1 || indexPath.row == 5)) {
    
            if (indexPath.row == 1) {
            
                self.guangGaoIndex1 = arc4random()%count;
            
                guaoGaoModel * model = self.guangGaoArray[self.guangGaoIndex1];
                
                oneCell.model4 = model;
                return oneCell;

            }else{
            
                self.guangGaoIndex2 = arc4random()%count;

                guaoGaoModel * model = self.guangGaoArray[self.guangGaoIndex2];

                oneCell.model4 = model;
                return oneCell;

            }
        
    
        }else{
    
            articleModel * model = self.dataArray[indexPath.row];
        
            if ([model.pic_num isEqualToString:@"1"]) {
            
                twoCell.model1 = self.dataArray[indexPath.row];
            
                return twoCell;
            
            
            
            }else{
            
                oneCell.model2 = self.dataArray[indexPath.row];
                return oneCell;
            
            
            }

        }
    }

}


#pragma mark- 广告切换

- (void)reloadGuangGao{
        
//    NSLog(@"随机数:%d",arc4random()%3);
    
    int count = (int)self.guangGaoArray.count;
    
    
    if (count == 1 || count == 2) {
    
    }else if (count > 2) {
        NSIndexPath *indexPath1=[NSIndexPath indexPathForRow:1 inSection:1];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath1,nil] withRowAnimation:UITableViewRowAnimationLeft];

        NSIndexPath *indexPath5=[NSIndexPath indexPathForRow:5 inSection:1];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath5,nil] withRowAnimation:UITableViewRowAnimationLeft];

    }else{
        
        
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    if (indexPath.section == 0) {
        
        NSLog(@"我是分组0-%ld",indexPath.row);
        
        if (indexPath.row == 0) {
            
            self.tabBarController.selectedIndex = 3;
            
        }else if (indexPath.row == 1) {
        
            NSString * isLogIn = [self.userDefauls objectForKey:@"isLogIn"];
            
            if([isLogIn isEqualToString:@"1"]){
                
                HomeNextViewController * nextvc = [[HomeNextViewController alloc]init];
                nextvc.buttonTag = 101;
                
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:nextvc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
                
            }else{
                
                LogInViewController * logVc = [[LogInViewController alloc]init];

                
                [self presentViewController:logVc animated:YES completion:nil];
                
            }
   
            
            
            
            
          
            
        }else{
            
            self.tabBarController.selectedIndex = 3;
            
        }
        
        
        
    }else{
    
        int count  = (int)self.guangGaoArray.count;
    
        if (count == 1 && indexPath.row == 1) {
        
        
            guaoGaoModel * model = self.guangGaoArray[0];
        

            wkWebViewController * wk = [[wkWebViewController alloc]init];
            wk.url = model.adurl;
        
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wk animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            return;
        }else if (count == 2 && (indexPath.row == 1 || indexPath.row ==5)){
    
            guaoGaoModel * model;
        
            if (indexPath.row == 1) {
                model = self.guangGaoArray[0];
            }else{
                model = self.guangGaoArray[1];

            }
        

            wkWebViewController * wk = [[wkWebViewController alloc]init];
            wk.url = model.adurl;
        
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wk animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            return;

        }else if (count > 2 && (indexPath.row == 1 || indexPath.row ==5)){
    
            guaoGaoModel * model;
        
            if (indexPath.row == 1) {
                model = self.guangGaoArray[self.guangGaoIndex1];
            }else{
                model = self.guangGaoArray[self.guangGaoIndex2];
            
            }

        
            wkWebViewController * wk = [[wkWebViewController alloc]init];
            wk.url = model.adurl;
        
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wk animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        
            return;
        }
    
    
        NSInteger index = indexPath.row;
    
        articleModel * model = self.dataArray[index];
    
        NSLog(@"我点了=>%ld",indexPath.row);

    
        self.web = [[webViewController alloc]init];
    
    
        NSString * url = [NSString stringWithFormat:@"http://wz.lgmdl.com/app/article/detail_new/id/%@",model.id_];
    
        self.web.id_ = model.id_;
    
        if (model.detail) {
        
            self.web.urlString = model.detail;
        
        }else{
        
            self.web.urlString = url;
        
        }
    
        
        CGFloat read_price = [model.read_price floatValue];
        
        if (read_price > 0.0) {
            
            self.web.isHeighPrice = YES;
            
        }else{
        
            self.web.isHeighPrice = NO;
        }
        
        
        self.web.share_count = [NSString stringWithFormat:@"%@",model.share_count];
        self.web.shareUrl = url;
        self.web.thumbimg = model.thumb;
        self.web.bigTitle = model.title;
        self.web.ucshare = model.ucshare;
        self.web.qqshare = model.qqshare;
        self.web.share = model.share;
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:self.web animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }
}


#pragma mark- cellHeight
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        return SCREEN_W/6;
        
    }else{
    
        articleModel * model = self.dataArray[indexPath.row];

        if ([model.pic_num isEqualToString:@"1"]) {
        
            return SCREEN_W/3;
        
        }else{
    
            return SCREEN_W/4;
        }
    }
}

#pragma mark- 分组高度
//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;//section头部高度
}


//section头部视图
- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    return view ;
}


//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
//section底部视图
- (UIView * )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}




#pragma mark-navBar.alpha
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

//    NSLog(@"====|----------->%f",scrollView.contentOffset.y);

    self.navBar.alpha = scrollView.contentOffset.y/64 < 0.85 ? scrollView.contentOffset.y/64 :0.85;
}


#pragma mark- 唤醒徒弟
- (void)awakensTheDisciple{

    UIView * bgView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];

    UIWindow * win = [UIApplication sharedApplication].keyWindow;
    
    [win addSubview:bgView];
    
    bgView.tag = 212121;
    
    [self alertView:bgView];
}

- (void)alertView:(UIView *)bgView{

    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W - 20, SCREEN_H/3)];
    view.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);
    [bgView addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_W-20)/3, SCREEN_H/12)];
    title.center = CGPointMake(view.frame.size.width/2, SCREEN_H/24);
    title.text = [NSString stringWithFormat:@"唤醒徒弟"];
    title.textColor = [UIColor blackColor];
    title.backgroundColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [view addSubview:title];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H/12, SCREEN_W - 20, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line];
    
    UILabel * detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(line.frame), SCREEN_W - 20 -30, SCREEN_H/10)];
    detailLabel.text = [NSString stringWithFormat:@"微转啦将发送消息帮您唤醒超过7天没登陆的徒弟"];
    detailLabel.font = [UIFont systemFontOfSize:15];
    detailLabel.numberOfLines = 2;
    detailLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:detailLabel];
    
    UIButton * cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(10, SCREEN_H/3 - 15 - SCREEN_H/13, (view.frame.size.width - 30)/2, SCREEN_H/14);
    [cancleButton setTitle:[NSString stringWithFormat:@"取消"] forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleButton.tag = 4404;
    [view addSubview:cancleButton];
    cancleButton.layer.borderWidth = 0.5;
    cancleButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cancleButton.clipsToBounds = YES;
    cancleButton.layer.cornerRadius = 10;
    
    UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(20 + (view.frame.size.width - 30)/2, SCREEN_H/3 - 15 - SCREEN_H/13, (view.frame.size.width - 30)/2, SCREEN_H/14);
    [sureButton setTitle:[NSString stringWithFormat:@"确定"] forState:UIControlStateNormal];
    sureButton.tag = 5505;
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    sureButton.layer.borderWidth = 0.5;
//    sureButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    sureButton.clipsToBounds = YES;
    sureButton.layer.cornerRadius = 10;
    sureButton.backgroundColor = [UIColor orangeColor];
    [view addSubview:sureButton];
    
    [cancleButton addTarget:self action:@selector(cancleButtonAndSureButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [sureButton addTarget:self action:@selector(cancleButtonAndSureButton:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.hud hideAnimated:YES];
}

//唤醒徒弟按钮
- (void)cancleButtonAndSureButton:(UIButton *)bt{
    
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    
    self.hud = hud;

    
    UIWindow * win = [UIApplication sharedApplication].keyWindow;
    UIView * bgView = (UIView *)[win viewWithTag:212121];
    
    if (bt.tag == 5505) {
        NSLog(@"确定!");
        
        if (self.net == nil) {
            self.net = [[NetWork alloc]init];
        }
        
        [self.net wakeUpTuDi];
        
        __weak Home_ViewController * weakSelf = self;
        self.net.tuDiBlock=^(NSString * message){

            if (message) {
                
                [hud hideAnimated:YES];

                UILabel * aleart = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/2, SCREEN_W/4)];
                aleart.center = weakSelf.view.center;
                aleart.backgroundColor = [UIColor blackColor];
                aleart.text = message;
                aleart.textAlignment = NSTextAlignmentCenter;
                aleart.textColor =[UIColor whiteColor];
                aleart.layer.cornerRadius = 10;
                aleart.clipsToBounds = YES;
                [weakSelf.view addSubview:aleart];
                [UIView animateWithDuration:2.5 animations:^{
                    
                    aleart.alpha = 0;
                }];
                
                
            }else{
            
                [hud hideAnimated:YES];

                UILabel * aleart = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/2, SCREEN_W/4)];
                aleart.center = weakSelf.view.center;
                aleart.backgroundColor = [UIColor blackColor];
                aleart.text = @"网络异常";
                aleart.numberOfLines = 0;
                aleart.textAlignment = NSTextAlignmentCenter;
                aleart.textColor =[UIColor whiteColor];
                aleart.layer.cornerRadius = 10;
                aleart.clipsToBounds = YES;
                [weakSelf.view addSubview:aleart];
                [UIView animateWithDuration:2.5 animations:^{
                    
                    aleart.alpha = 0;
                }];

            }
            
        };
        
        [bgView removeFromSuperview];
    }else if (bt.tag == 4404){
        
        NSLog(@"4404");
        [bgView removeFromSuperview];
        
        [hud hideAnimated:YES];
    }


}


#pragma mark- 新手注册红包;
- (void)addNewUserHongBao{

    
    NSDictionary * dic = [self.userDefauls objectForKey:@"usermessage"];

    NSString * new_hb = [NSString stringWithFormat:@"%@",dic[@"new_hb"]];
    
    if (![new_hb isEqualToString:@"0"] || ![self.isLoginState isEqualToString:@"1"]) {
        
        return;

    }
    
    
    UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    bgview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    UIWindow * win = [UIApplication sharedApplication].keyWindow;
    [win addSubview:bgview];
    self.myNewUserHongBaoView = bgview;
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W + SCREEN_W/3, SCREEN_H)];
    imageView.image = [UIImage imageNamed:@"redMoney.png"];
    imageView.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);
    [bgview addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, SCREEN_W/5, SCREEN_W/5);
    button.layer.cornerRadius = SCREEN_W/10;
    button.clipsToBounds = YES;
    button.center = CGPointMake(imageView.frame.size.width/2, SCREEN_H - SCREEN_W/3);
    [button addTarget:self action:@selector(removeNewUserHongBao) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:button];
}


- (void)removeNewUserHongBao{

    [self.myNewUserHongBaoView removeFromSuperview];

    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
    }
    
    [self.net newUserHongBao];
    
    __weak Home_ViewController * weakSelf = self;
    
    self.net.hongBao=^(NSString * code,NSString * message){
    
        if ([code isEqualToString: @"1"]) {
            
            
            [weakSelf MJrefreshData];
        }
    
    };
    
}



- (void)dealloc{

    [self.timer invalidate];

    self.timer = nil;
    
    NSLog(@"定时器释放");
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (scrollView.tag == 3003) {
        
        self.pageControl.currentPage = scrollView.contentOffset.x/SCREEN_W;
        
        if (self.pageControl.currentPage  + 1== self.flashArray.count) {
            
            self.left = NO;
        }
        
        
        if (self.pageControl.currentPage  == 0) {
            
            self.left = YES;
        }
        
    }
    

}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    if (scrollView.tag == 3003) {
        
        [self stopAdvTimer];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    
    if (scrollView.tag == 3003) {
    
        [self addadvTimer];
    }
}


#pragma mark- 展示公告

- (void)getActivityMessage{

    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
    }
    
    [self.net noticeOfActivity];
    
    
    __weak Home_ViewController * weakSelf = self;
    
    self.net.activityNoticBK = ^(NSString *code, NSString *imgUrl, NSString * wz) {
        
        if ([code isEqualToString:@"1"]) {
            
            if (![imgUrl isEqualToString:@""]) {
                
                [weakSelf showActivityImgeViewWithImageUrl:imgUrl];
                
            }
        }
    };
}


- (void)showActivityImgeViewWithImageUrl:(NSString *)imgUrl{
    
    UIView * BGview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    BGview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    BGview.tag = 336699;
    
    UIWindow * win = [UIApplication sharedApplication].keyWindow;
    [win addSubview:BGview];
    
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_W-(SCREEN_H*2/3 * 7/10))/2, 64, SCREEN_H*2/3 * 7/10, SCREEN_H*2/3)];
    imageV.image = [UIImage imageNamed:@"img_loading.jpg"];
    imageV.backgroundColor = [UIColor clearColor];
    [imageV sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    
    [BGview addSubview:imageV];
    
 
    UIButton * xx  = [UIButton buttonWithType:UIButtonTypeCustom];
    xx.frame = CGRectMake(SCREEN_W/2 - SCREEN_W/10, CGRectGetMaxY(imageV.frame)+5, SCREEN_W/6, SCREEN_W/6);
    [xx addTarget:self action:@selector(dissmissActivityNoticeShow) forControlEvents:UIControlEventTouchUpInside];
    [xx setTitle:@"X" forState:UIControlStateNormal];
    
    xx.backgroundColor = [UIColor clearColor];
    [xx setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    xx.titleLabel.font = [UIFont systemFontOfSize:30];
    xx.layer.cornerRadius = SCREEN_W/12;
    xx.layer.borderColor = [UIColor whiteColor].CGColor;
    xx.layer.borderWidth = 1.00;
    [BGview addSubview:xx];
}


- (void)dissmissActivityNoticeShow{
    
    UIWindow * win = [UIApplication sharedApplication].keyWindow;
    UIView * bgView = (UIView *)[win viewWithTag:336699];
    [bgView removeFromSuperview];
}

@end
