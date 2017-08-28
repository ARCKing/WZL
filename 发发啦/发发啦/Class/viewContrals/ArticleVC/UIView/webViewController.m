//
//  webViewController.m
//  发发啦
//
//  Created by gxtc on 16/9/28.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "webViewController.h"
#import "UCShareView.h"
#import "UMSocialUIManager.h"
#import "NetWork.h"
#import "userCollectionArticleModel.h"
#import "LogInViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"

#pragma mark- 用户资料
#define UMSUserInfoPlatformTypeKey @"UMSUserInfoPlatformTypeKey"
#define UMSUserInfoPlatformNameKey @"UMSUserInfoPlatformNameKey"
#define UMSUserInfoPlatformIconNameKey @"UMSUserInfoPlatformIconNameKey"

#pragma mark- 用户登录
#define UMSAuthPlatformTypeKey @"UMSAuthPlatformTypeKey"
#define UMSAuthPlatformNameKey @"UMSAuthPlatformNameKey"
#define UMSAuthPlatformIconNameKey @"UMSAuthPlatformImageNameKey"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

#define KURL @"http://wz.lgmdl.com"


@interface webViewController ()
@property(nonatomic,strong)UIWebView * web;
@property(nonatomic,retain)UIView * navView;
@property(nonatomic,strong)UIButton * navRightBt;
@property(nonatomic,strong)UIView * shareBar;
@property(nonatomic,strong)UISlider * slider;
@property(nonatomic,strong)UIView * GGview;
@property(nonatomic,strong)UIView * AAView;
@property(nonatomic,strong)UILabel * titLabel;
@property(nonatomic,strong)UIImageView * imgView;
@property(nonatomic,strong)NSMutableArray * imgArray;
@property(nonatomic,strong)NJKWebViewProgress * progress;
@property(nonatomic,strong)NJKWebViewProgressView * progressView;

@property(nonatomic,strong)UCShareView * ucShare;
@property(nonatomic,strong)NetWork * net;
@property(nonatomic,strong)NSTimer * myTimer;
@property(nonatomic,assign)NSInteger  timeValue;
@property(nonatomic,assign)BOOL isTimer;

@property(nonatomic,strong)UIView * aleartViewEnter;
@property(nonatomic,strong)UIView * aleartViewExit;
@property(nonatomic,strong)UIButton * starButton;

@property (nonatomic, strong) NSMutableArray *platformInfoArray;

@property (nonatomic,assign)BOOL isWeiBoShare;

@property (nonatomic,assign)BOOL isFinishTask;

@property (nonatomic,strong)UIButton * closeBt;

@property (nonatomic,strong)UIButton * shareButton;

@property (nonatomic,strong)UIImage * locationShareImage;
@end

@implementation webViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //==========Ushare=========
    self.platformInfoArray = [NSMutableArray arrayWithCapacity:5];
    
    //    NSArray *paltformTypeArray = [NSArray arrayWithObjects:@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_TencentWb),@(UMSocialPlatformType_Renren),@(UMSocialPlatformType_Douban),@(UMSocialPlatformType_Facebook),@(UMSocialPlatformType_Twitter),@(UMSocialPlatformType_Linkedin), nil];
    
    NSArray *paltformTypeArray = [NSArray arrayWithObjects:@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),nil];
    
    
    for (NSNumber *platformType in paltformTypeArray) {
        NSMutableDictionary *dict = [self dictWithPlatformName:platformType];
        [dict setValue:platformType forKey:UMSAuthPlatformTypeKey];
        if (dict) {
            [self.platformInfoArray addObject:dict];
        }
    }
    
    NSLog(@"%@",_platformInfoArray);
    //==========================
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self navViewCreat];
    [self webViewCreat];
    

    if (!self.isNewTeach) {
        
        
        if (self.isReadEarn) {
            
            [self creatAdv];

        }else{
        
            [self shareBarCreat];
            
//            [self reviewHidden];
            
            [self AAViewCreat];
        }
        

    }
    

    
//    [self creatLoadingAnimation];
    
    
//    [self nowTime];

    if (self.isReadEarn) {
        [self aleartViewEnterCreat];

    }

    if (self.isNewTeach || self.isReadEarn) {
        
    }else{
    
        [self checkIsCollect];

    }
    
}

/**审核隐藏*/
- (void)reviewHidden{

    NetWork * net = [[NetWork alloc]init];

    [net isHiddenWhenReview];
    
    __weak webViewController * weakSelf = self;
    
    net.hiddenWhenReviewBK=^(NSString *code, BOOL isHidden){
    
        if (isHidden == NO) {
            
            [weakSelf.shareButton setTitle:@"分享赚" forState:UIControlStateNormal];
        }
        
    };
    
}


#pragma mark-  阅读转开始阅读提示框
- (void)aleartViewEnterCreat{

    self.aleartViewEnter = [[UIView alloc]initWithFrame:self.view.bounds];
    self.aleartViewEnter.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.aleartViewEnter.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8].CGColor;
    self.aleartViewEnter.layer.shadowOffset = CGSizeMake(0, 0);
    self.aleartViewEnter.layer.shadowOpacity = 1;
    [self.view addSubview:self.aleartViewEnter];
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W - 20, SCREEN_W *2/3)];
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
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H/12, SCREEN_W - 20, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line];
    
    UILabel * detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(line.frame), SCREEN_W - 20 -30, SCREEN_W/2)];
    detailLabel.text = @"    只要阅读就可以赚钱啦！阅读赚就是不用转发就可以赚钱的任务。1.如果是文章类型，那么久阅读5篇文章且总时间持续超过5分钟即可完成任务。2.如果是图片类型，那么久需要阅读10张图片且总时间超过5分钟即可完成任务。完成任务后，系统稍后将会发放收益！";
    detailLabel.font = [UIFont systemFontOfSize:15];
    detailLabel.numberOfLines = 0;
    detailLabel.textAlignment = NSTextAlignmentLeft;
    [view addSubview:detailLabel];
    [detailLabel sizeToFit];

    UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(0, 0, SCREEN_W/2, SCREEN_W/8);
    sureButton.center = CGPointMake((SCREEN_W - 20)/2, CGRectGetMaxY(detailLabel.frame) + SCREEN_W/8);
    
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.tag = 5500;
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
    sureButton.clipsToBounds = YES;
    sureButton.layer.cornerRadius = 10;
    sureButton.backgroundColor = [UIColor orangeColor];
    [view addSubview:sureButton];

    [sureButton addTarget:self action:@selector(aleartViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * xxButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [xxButton setImage:[UIImage imageNamed:@"home_adv_close.png"] forState:UIControlStateNormal];
    xxButton.frame = CGRectMake(SCREEN_W-30 - SCREEN_W/10, SCREEN_W/30, SCREEN_W/10, SCREEN_W/10);
    [view addSubview:xxButton];
    xxButton.tag = 5500;
    [xxButton addTarget:self action:@selector(aleartViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark- 阅读赚退出提示框
- (void)aleartViewExitCreat{
    self.aleartViewExit = [[UIView alloc]initWithFrame:self.view.bounds];
    self.aleartViewExit.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.aleartViewExit.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8].CGColor;
    self.aleartViewExit.layer.shadowOffset = CGSizeMake(0, 0);
    self.aleartViewExit.layer.shadowOpacity = 1;
    [self.view addSubview:self.aleartViewExit];

    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W - 20, SCREEN_H/3)];
    view.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);
    [self.aleartViewExit addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_W-20)/3, SCREEN_H/12)];
    title.center = CGPointMake(view.frame.size.width/2, SCREEN_H/24);
    title.text = @"微转啦";
    title.textColor = [UIColor blackColor];
    title.backgroundColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [view addSubview:title];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H/12, SCREEN_W - 20, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line];
    
    UILabel * detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(line.frame), SCREEN_W - 20 -30, SCREEN_H/10)];
    detailLabel.text = @"任务未完成，下次进行任务将重新开始任务，是否退出?";
    detailLabel.font = [UIFont systemFontOfSize:15];
    detailLabel.numberOfLines = 2;
    detailLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:detailLabel];
    
    UIButton * cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(10, SCREEN_H/3 - 15 - SCREEN_H/13, (view.frame.size.width - 30)/2, SCREEN_H/14);
    [cancleButton setTitle:@"退出" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleButton.tag = 6600;
    [view addSubview:cancleButton];
    cancleButton.layer.borderWidth = 0.5;
    cancleButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cancleButton.clipsToBounds = YES;
    cancleButton.layer.cornerRadius = 10;
    
    UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(20 + (view.frame.size.width - 30)/2, SCREEN_H/3 - 15 - SCREEN_H/13, (view.frame.size.width - 30)/2, SCREEN_H/14);
    [sureButton setTitle:@"继续阅读" forState:UIControlStateNormal];
    sureButton.tag = 6601;
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    sureButton.layer.borderWidth = 0.5;
    //    sureButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    sureButton.clipsToBounds = YES;
    sureButton.layer.cornerRadius = 10;
    sureButton.backgroundColor = [UIColor orangeColor];
    [view addSubview:sureButton];

    [sureButton addTarget:self action:@selector(aleartViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton addTarget:self action:@selector(aleartViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton * xxButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [xxButton setImage:[UIImage imageNamed:@"home_adv_close.png"] forState:UIControlStateNormal];
    xxButton.frame = CGRectMake(SCREEN_W-30 - SCREEN_W/10, SCREEN_W/30, SCREEN_W/10, SCREEN_W/10);
    [view addSubview:xxButton];
    xxButton.tag = 6601;
    [xxButton addTarget:self action:@selector(aleartViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];

}



- (void)aleartViewButtonAction:(UIButton *)bt{

    if (bt.tag == 5500) {
        NSLog(@"确定");
        
        if (self.isReadEarn == YES) {
            
            if (!self.isTimer) {
                NSLog(@"网页加载完成！！!可以计时！");
                
                [self beginReadArticle];
            }
            
        }
        
//        [self performSelector:@selector(starToReckonByTime) withObject:nil afterDelay:5];
        
//        [self starToReckonByTime];
        
        
        [self.aleartViewEnter removeFromSuperview];
        
    }else if(bt.tag == 6600){
        NSLog(@"退出");
    
        [self.aleartViewExit removeFromSuperview];
        [self stopTimer];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (bt.tag == 6601){
        NSLog(@"继续阅读");
        [self.aleartViewExit removeFromSuperview];

    }

}



#pragma mark- navViewCreat
- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(5,32, 40, 20);
    [self.view addSubview:button];
#pragma mark- button.tag-3000
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 27, SCREEN_W*3/5, 30)];
    titleLabel.text = @"";
    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.center = CGPointMake(SCREEN_W/2, 40);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    self.titLabel = titleLabel;
    
    
    [self closdButtonCreat];

    
    if (!self.isNewTeach) {
        
        if (self.isReadEarn == YES) {
            return;
        }
        
#pragma mark- navRightBtCreat
    self.navRightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    self.navRightBt.frame = CGRectMake(0, 0, 50, 50);
    self.navRightBt.center = CGPointMake(SCREEN_W - 25, 64 - 25);
    [self.navRightBt setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];
    self.navRightBt.tag = 4040;
#pragma mark- navRightBt.tag- 4040;
    [self.navRightBt addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:_navRightBt];
        
    }
    
    


}


#pragma mark- 关闭按钮

- (void)closdButtonCreat{
    self.closeBt = [UIButton buttonWithType: UIButtonTypeCustom];
    self.closeBt.frame = CGRectMake(40, 30, 40, 25);
    //    self.closeBt.center = CGPointMake(65, 32);
    self.closeBt.alpha = 0;
    [self.closeBt setTitle:@"关闭" forState:UIControlStateNormal];
    [self.closeBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.closeBt addTarget:self action:@selector(closedWebView) forControlEvents:UIControlEventTouchUpInside];
    self.closeBt.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.navView addSubview:self.closeBt];

}




#pragma mark- 关闭按钮Action
- (void)closedWebView{

    NSLog(@"关闭");
    
    if (self.isReadEarn) {
        
        
        if (self.isFinishTask) {
            
            [self stopTimer];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            [self dismissViewControllerAnimated:YES completion:nil];

            
        }else{
        
            [self aleartViewExitCreat];

        }
        
        
    }else{
        
    
    [self stopTimer];
        
    [self.navigationController popViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    
    if (button.tag == 3000) {
        NSLog(@"3000");
        
        if (self.isReadEarn) {
            
            if (self.web.canGoBack) {
                
                [self.web goBack];
                
            }else{
            
                
                if (self.isFinishTask == YES) {
                    
                    [self.navigationController popViewControllerAnimated:YES];

                }else{
                
                    [self aleartViewExitCreat];

                }

            }

        }else{
            
            
            if (self.web.canGoBack) {
                
                [self.web goBack];
                
                
                
                
            }else{
            
            
            //移除计时器
            [self stopTimer];
            [self.navigationController popViewControllerAnimated:YES];
            }

        }
        
        
        
        [self dismissViewControllerAnimated:YES completion:nil];

        
    }else if (button.tag == 4040){
        NSLog(@"4040");
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        UIAlertAction * actionDefault = [UIAlertAction actionWithTitle:@"举报此文章" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
            NSLog(@"举报");
            
            UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W * 3/5, 35)];
            title.text = @"感谢您的举报，我们会在24小时内处理";
            title.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8];
            title.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);
            title.textColor = [UIColor whiteColor];
            title.font = [UIFont systemFontOfSize:14];
            title.layer.cornerRadius = 10;
            title.clipsToBounds = YES;
            title.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:title];
            
            [self performSelector:@selector(removeTirle:) withObject:title afterDelay:2];
        }];

        [alertController addAction:actionDefault];
        [actionDefault setValue:[UIColor redColor] forKey:@"titleTextColor"];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消举报");

        }]];
        
        
        [self presentViewController:alertController animated:YES completion:nil];
    
    }else if (button.tag == 6666) {
    
//        [self addUcShareView];

        
        NSString * isLoging = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogIn"];
        
        if ([isLoging isEqualToString:@"1"]) {
            
            [self addUcShareView];
            
        }else{
        
            
            UIAlertController * altertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您还未登陆，分享将不会获得收益，是否登陆?" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * action0 = [UIAlertAction actionWithTitle:@"继续分享" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [self addUcShareView];
            }];
            
            [action0 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
            
            
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                LogInViewController * vc = [[LogInViewController alloc]init];
                
                [self presentViewController:vc animated:YES completion:nil];
                
            }];
            
            [action1 setValue:[UIColor orangeColor] forKey:@"titleTextColor"];

            
            [altertController addAction:action0];
            [altertController addAction: action1];
        
            
            [self presentViewController:altertController animated:YES completion:nil];
        }
        
        
        
        
        NSLog(@"6666");
      
        
    
    }else if (button.tag == 6667) {
        
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W /4, 35)];
        title.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8];
        title.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont systemFontOfSize:14];
        title.layer.cornerRadius = 10;
        title.clipsToBounds = YES;
        title.textAlignment = NSTextAlignmentCenter;
#pragma mark- 文章收藏
        if (button.selected == NO) {

            if (self.net == nil) {
                self.net = [[NetWork alloc]init];
            }
            
            [self.net addMyArticleCollectionWithAid:self.id_];
            
            __weak webViewController * weakSelf = self;
            
            self.net.addArticleCollect=^(NSString * code,NSString * message){
            
                NSLog(@"收藏");
                title.text = message;
                [weakSelf.view addSubview:title];
                [weakSelf performSelector:@selector(removeTirle:) withObject:title afterDelay:1];
            };
            
            
           

        }else {
        
            
            if (self.net == nil) {
                self.net = [[NetWork alloc]init];
            }
            
            [self.net cancleMyArticleCollectionWithAid:self.id_];
            
            __weak webViewController * weakSelf = self;

            self.net.cancleArticleCollect = ^(NSString * code,NSString * message){
            
                NSLog(@"取消收藏");
                title.text = message;
                [weakSelf.view addSubview:title];
                [weakSelf performSelector:@selector(removeTirle:) withObject:title afterDelay:1];

                
            };
            
          
        }
        
        button.selected = !button.selected;
        
        NSLog(@"6667");
    }else if (button.tag == 6668) {
        NSLog(@"6668");
    [UIView animateWithDuration:0.5 animations:^{
       
        self.AAView.frame =CGRectMake(0, SCREEN_H - SCREEN_H/4, SCREEN_W, SCREEN_H/4);
        
    }];
    }else if (button.tag == 1122) {
        NSLog(@"1122");
        [UIView animateWithDuration:0.5 animations:^{
           
            self.AAView.frame = CGRectMake(0, SCREEN_H + SCREEN_H/4, SCREEN_W, SCREEN_H/4);
        }];
        
        
    }else{
    
     [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

//移除收藏提示框
- (void)removeTirle:(UILabel *)label{
    [label removeFromSuperview];

}


#pragma mark- 添加分享框
- (void)addUcShareView{

    self.ucShare =[[UCShareView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) andIsinvite:NO];
    
    [self.view addSubview:_ucShare];
    
    [self.ucShare.weixin addTarget:self action:@selector(ucShareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ucShare.weixinFriend addTarget:self action:@selector(ucShareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ucShare.QQ addTarget:self action:@selector(ucShareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ucShare.QZone addTarget:self action:@selector(ucShareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ucShare.URLCopy addTarget:self action:@selector(ucShareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ucShare.exitShare addTarget:self action:@selector(ucShareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ucShare.sinaWeiBo addTarget:self action:@selector(ucShareButtonAction:) forControlEvents:UIControlEventTouchUpInside];



}




#pragma mark- ucShareButtonAction

- (void)ucShareButtonAction:(UIButton *)bt{
    
/*
    //判断是否安装有UC
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"ucbrowser://"]] && bt.tag != 1114 && bt.tag != 1112 && bt.tag != 1113 && bt.tag != 1115 && bt.tag != 404040){
        
        NSLog(@"没有安装UC");
        
        UIAlertController * alertControll = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您没有安装UC浏览器,无法进行微信分享" preferredStyle: UIAlertControllerStyleAlert];
        
        [alertControll addAction:[UIAlertAction actionWithTitle:@"appStore下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"现在去下载");
            
            
            static NSString * const reviewURL = @"https://itunes.apple.com/cn/app/uc-liu-lan-qi-6yi-ren-shang/id586871187?mt=8";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURL]];
            
            
            
        }]];
        
        [alertControll addAction:[UIAlertAction actionWithTitle:@"取消分享" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"取消");
            
            
            
        }]];
        
        
        [self presentViewController:alertControll animated:YES completion:^{
            
            NSLog(@"提示框来了!");
            
        }];
        
        [self.ucShare removeFromSuperview];
        return;
    
    }
    */
    
   
    
    NSDictionary * dict =[[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    NSString * uid = dict[@"uid"];
    NSString * token = dict[@"token"];
    NSString * id_ = self.id_;
    
    NSLog(@"+>>> token = %@ ;uid = %@ ;id = %@;",token,uid,id_);
    
    if (self.net == nil) {
        self.net = [[NetWork alloc]init];
    }
    
    
    [self.net shareTimesRecoard:self.id_];
    
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    //判断是否安装有UC浏览器
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"ucbrowser://"]] && (bt.tag == 1110 || bt.tag == 1111|| bt.tag == 1112|| bt.tag == 1113)){
        
        if (bt.tag == 1110 ) {
            //微信朋友圈
            
            
            [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"wechat_moments"];
            
            self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare,NSString * thumb,NSString * title) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"ucbrowser://%@",ucShare]]];
                
                NSLog(@"%@",ucShare);
                
                [hud hideAnimated:YES];
            };
            
            
        }else if (bt.tag == 1111 ){
            //微信好友
            
            [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"wechat_friend"];
            self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare,NSString * thumb,NSString * title) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"ucbrowser://%@",ucShare]]];
                
                [hud hideAnimated:YES];

            };
           
            
        }else if (bt.tag == 1112 ){
            //QQ
            
            [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"qq_mobile"];
            self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare,NSString * thumb,NSString * title) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"ucbrowser://%@",ucShare]]];
                
                [hud hideAnimated:YES];

            };
            
            
        }else if (bt.tag == 1113 ){
            //QZone
            
            [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"qq_zone"];
            self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare,NSString * thumb,NSString * title) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"ucbrowser://%@",ucShare]]];
                
                [hud hideAnimated:YES];

            };
            
            
        }


        
    }
    //判断是否安装有QQ浏览器
    else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mttbrowser://"]] && (bt.tag == 1110 || bt.tag == 1111|| bt.tag == 1112|| bt.tag == 1113)){
        
        if (bt.tag == 1110 ) {
            //微信朋友圈
            
            
            [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"wechat_moments"];
            
            self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare,NSString * thumb,NSString * title) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mttbrowser://url=%@",ucShare]]];
                NSLog(@"%@",ucShare);

                [hud hideAnimated:YES];

            };
            
            
        }else if (bt.tag == 1111 ){
            //微信好友
            
            [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"wechat_friend"];
            self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare,NSString * thumb,NSString * title) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mttbrowser://url=%@",ucShare]]];
                NSLog(@"%@",ucShare);

                [hud hideAnimated:YES];

            };
            
        }else if (bt.tag == 1112 ){
            //QQ
            
            [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"qq_mobile"];
            self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare,NSString * thumb,NSString * title) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mttbrowser://url=%@",ucShare]]];
                
                [hud hideAnimated:YES];

            };
            
            
        }else if (bt.tag == 1113 ){
            //QZone
            
            [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"qq_zone"];
            self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare,NSString * thumb,NSString * title) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mttbrowser://url=%@",ucShare]]];
                
                [hud hideAnimated:YES];

            };
            
            
        }

        
    }else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqqbrowser://"]] && (bt.tag == 1110 || bt.tag == 1111|| bt.tag == 1112|| bt.tag == 1113)){
        
        if (bt.tag == 1110 ) {
            //微信朋友圈
            
            
            [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"wechat_moments"];
            
            self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare,NSString * thumb,NSString * title) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mqqbrowser://url=%@",ucShare]]];
              
                [hud hideAnimated:YES];

            };
            
            
        }else if (bt.tag == 1111 ){
            //微信好友
            
            [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"wechat_friend"];
            self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare,NSString * thumb,NSString * title) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mqqbrowser://url=%@",ucShare]]];

                [hud hideAnimated:YES];

            };
            
        }else if (bt.tag == 1112 ){
            //QQ
            
            [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"qq_mobile"];
            self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare,NSString * thumb,NSString * title) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mqqbrowser://url=%@",ucShare]]];
                
                [hud hideAnimated:YES];

            };
            
            
        }else if (bt.tag == 1113 ){
            //QZone
            
            [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"qq_zone"];
            self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare,NSString * thumb,NSString * title) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mqqbrowser://url=%@",ucShare]]];
                
                [hud hideAnimated:YES];

            };
            
            
        }

    }
    //本地分享
    else if(bt.tag == 1110 || bt.tag == 1111|| bt.tag == 1112|| bt.tag == 1113){
        
        
        [self.net getLocationLinkWithArticleID:self.id_];
        
        __weak webViewController * weakSelf = self;
        
        self.net.lociationLinkBK = ^(NSString * shareLink,NSString * thumb,NSString * title) {
            
            [hud hideAnimated:YES];

            [weakSelf getShareImageWithThumb:thumb andHUD:nil andShareLink:shareLink];
            
        };
        
    }
    

    /*
    if (bt.tag == 1110 && self.isHeighPrice == YES) {
        //微信朋友圈
        
        
        [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"wechat_moments"];
        
        self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"ucbrowser://%@",ucShare]]];

        };
        
        
    }else if (bt.tag == 1111 && self.isHeighPrice == YES){
        //微信好友
        
        [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"wechat_friend"];
        self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"ucbrowser://%@",ucShare]]];
            
        };
        
    }else if (bt.tag == 1112 && self.isHeighPrice == YES){
        //QQ
        
        [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"qq_mobile"];
        self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"ucbrowser://%@",ucShare]]];
            
        };
        
    }else if (bt.tag == 1113 && self.isHeighPrice == YES){
        //Qzone
        
        [self.net getHeightPriceUCshareLinkWithArticleID:self.id_ andShareType:@"qq_zone"];
        self.net.heightPriceUCshareLinkBK = ^(NSString * ucShare) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"ucbrowser://%@",ucShare]]];
            
        };
        
    }else if (bt.tag == 1110) {
        NSLog(@"微信朋友圈分享");
        NSString * sharetype = [NSString stringWithFormat:@"wechat_moments"];

        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"ucbrowser://%@/token/%@/id/%@/uid/%@/sharetype/%@",self.ucshare,token,id_,uid,sharetype]]];
        
//       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"ucbrowser://wz.lgmdl.com/App/Share/ucshare/uid/%@/token/%@/id/%@/sharetype/%@",uid,token,id_,sharetype]]];
        
    }else if (bt.tag == 1111) {
        NSLog(@"微信好友分享");
        NSString * sharetype = [NSString stringWithFormat:@"wechat_friend"];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"ucbrowser://%@/token/%@/id/%@/uid/%@/sharetype/%@",self.ucshare,token,id_,uid,sharetype]]];
        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"ucbrowser://wz.lgmdl.com/App/Share/ucshare/uid/%@/token/%@/id/%@/sharetype/%@",uid,token,id_,sharetype]]];
        
    }
    else if (bt.tag == 1112) {
        NSLog(@"QQ好友分享");
        

        //分享类型
        
        //    UMSocialPlatformType_Sina,          //新浪
        //    UMSocialPlatformType_WechatSession, //微信聊天
        //    UMSocialPlatformType_WechatTimeLine,//微信朋友圈
        //    UMSocialPlatformType_WechatFavorite,//微信收藏
        //    UMSocialPlatformType_QQ,            //QQ聊天页面
        //    UMSocialPlatformType_Qzone,         //qq空间
        
        
        [self shareDataWithPlatform:UMSocialPlatformType_QQ];

        
        
    }else if (bt.tag == 1113) {
        NSLog(@"QQ空间分享");
        
        [self shareDataWithPlatform:UMSocialPlatformType_Qzone];

    }*/
     else if (bt.tag == 1114) {
        NSLog(@"新浪分享");
        
        self.isWeiBoShare = YES;
        [self shareDataWithPlatform:UMSocialPlatformType_Sina];
    
        
    }else if (bt.tag == 1115) {
        NSLog(@"复制分享链接");
        
        NSString * url = @"http://wz.lgmdl.com/App/Article/detail_new";
        
        
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [NSString stringWithFormat:@"%@/id/%@/uid/%@",url,id_,uid];
        
        if (pasteboard.string != nil) {
            
            UIAlertController * alertControll = [UIAlertController alertControllerWithTitle:@"复制成功" message:nil preferredStyle: UIAlertControllerStyleAlert];
            
            [self presentViewController:alertControll animated:YES completion:^{
                
                NSLog(@"提示框来了!");
                
            }];
            
            [self performSelector:@selector(removeAlerateFromSuperView:) withObject:self afterDelay:1];
            
            
        }else {
            UIAlertController * alertControll = [UIAlertController alertControllerWithTitle:@"复制失败" message:nil preferredStyle: UIAlertControllerStyleAlert];
            
            [self presentViewController:alertControll animated:YES completion:^{
                
                NSLog(@"提示框来了!");
                
            }];
            
            [self performSelector:@selector(removeAlerateFromSuperView:) withObject:self afterDelay:1];
            
        }

        
        
        
    }else if (bt.tag == 404040) {
        
        NSLog(@"取消分享!");
        
        [self.ucShare removeFromSuperview];
        
        return;
    }
    
    [self.ucShare removeFromSuperview];


}


//提示框消失
- (void)removeAlerateFromSuperView:(UIAlertController *)alertControll{
    
    [alertControll dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark-webViewCrat
- (void)webViewCreat{

    if (self.isNewTeach) {
        
        self.web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64)];
        
    }else if(self.isReadEarn){
        
        self.web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64)];

    }else{
        
        self.web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64 - 49)];

    }
                                                              
    self.web.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",_urlString);
    self.web.scalesPageToFit = YES;
    self.web.dataDetectorTypes = UIDataDetectorTypeAll;
    
#pragma mark- NJWebView
    self.progress = [[NJKWebViewProgress alloc]init];
    self.web.delegate = _progress;
    _progress.webViewProxyDelegate = self;
    _progress.progressDelegate = self;
    

    
    CGFloat progressBarHeight = 1.f;
    CGRect barFrame = CGRectMake(0, self.navView.bounds.size.height-1,self.navView.bounds.size.width, progressBarHeight);
    
    self.progressView = [[NJKWebViewProgressView alloc]initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleWidth;
    [_progressView setProgress:0 animated:YES];
    
    [_navView addSubview:_progressView];
    
    
    if (self.isPost) {
        NSURL * url = [NSURL URLWithString:self.urlString];
        NSString * body = [NSString stringWithFormat:@"/token=%@&uid=%@&cid=%ld",self.token,self.uid,self.cid];
        
        NSLog(@"%@",body);
        NSLog(@"%@",url);

        
        NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
        
        [request setHTTPMethod:@"POST"];
        
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSLog(@"%@",request);

        [self.web loadRequest:request];
        
        

        
    }else{
    
        [self.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];

    }
    
    [self.view addSubview:_web];
}


#pragma mark- NJKWebViewProgressDelegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
     
    [_progressView setProgress:progress animated:YES];
    self.titLabel.text = [_web stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    self.bigTitle = self.titLabel.text;
}

#pragma mark- 分享栏

- (void)shareBarCreat{
    self.shareBar = [[UIView alloc]initWithFrame:CGRectMake(-1, SCREEN_H-48, SCREEN_W+2, 49)];
    self.shareBar.backgroundColor = [UIColor whiteColor];
    self.shareBar.layer.borderColor =[UIColor lightGrayColor ].CGColor;
    self.shareBar.layer.borderWidth = 1;
    [self.view addSubview:_shareBar];

    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"c1-1.png"] forState:UIControlStateNormal];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(0, 0, SCREEN_W/3, 30);
    shareButton.center = CGPointMake(SCREEN_W/6 - 5, 49/2);
    [self.shareBar addSubview:shareButton];
    [shareButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:14];
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
#pragma mark- shareButton.tag - 6666;
    shareButton.tag = 6666;
    [shareButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(10, 3, 0, 0);
    self.shareButton = shareButton;
    
    
    UILabel * share_count = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/7, -5, 50,15)];
    share_count.backgroundColor =[UIColor redColor];
    share_count.textColor = [UIColor whiteColor];
    share_count.textAlignment = NSTextAlignmentCenter;
    [shareButton addSubview:share_count];
    share_count.layer.cornerRadius = 5;
    share_count.clipsToBounds = YES;
    
    NSLog(@"%@",self.share_count);
    share_count.text = self.share_count;
    share_count.font = [UIFont systemFontOfSize:13];
    
    UIButton * starButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [starButton setImage:[UIImage imageNamed:@"c4-1.png"] forState:UIControlStateNormal];
    [starButton setImage:[UIImage imageNamed:@"c4.png"] forState:UIControlStateSelected];
    starButton.frame = CGRectMake(0, 0, SCREEN_W/8, 30);
    starButton.center = CGPointMake(SCREEN_W-SCREEN_W/7, 49/2);
    [self.shareBar addSubview:starButton];
    [starButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    starButton.titleLabel.font = [UIFont systemFontOfSize:14];
    starButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
#pragma mark- shareButton.tag - 6667;
    starButton.tag = 6667;
    [starButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.starButton = starButton;
    
#pragma mark- fontAndScreenLight
    UIButton * AAButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [AAButton setImage:[UIImage imageNamed:@"c5-1.png"] forState:UIControlStateNormal];
    AAButton.frame = CGRectMake(0, 0, SCREEN_W/8, 30);
    AAButton.center = CGPointMake(SCREEN_W-SCREEN_W/15, 49/2);
    [self.shareBar addSubview:AAButton];
    [AAButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    AAButton.titleLabel.font = [UIFont systemFontOfSize:14];
    AAButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
#pragma mark- shareButton.tag - 6668;
    AAButton.tag = 6668;
    [AAButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self creatAdv];
}


- (void)GGviewCreat{


}

- (void)AAViewCreat{
    self.AAView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H + SCREEN_H/4 - SCREEN_H/9, SCREEN_W, SCREEN_H/4 -SCREEN_H/9)];
    [self.view addSubview:_AAView];
    self.AAView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
//    self.AAView.backgroundColor = [UIColor redColor];
    
    
    UIButton * button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = CGRectMake(0, SCREEN_H/4 -SCREEN_W/8 , SCREEN_W, SCREEN_W/8);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [self.AAView addSubview:button];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1122;
    
    UIButton * imgBt = [UIButton buttonWithType:UIButtonTypeCustom];
    imgBt.frame = CGRectMake(0, 0, SCREEN_W/4, SCREEN_W/10);
    imgBt.center = CGPointMake(SCREEN_W/8 + 10, (_AAView.bounds.size.height/2));
    [imgBt setTitle:@"亮度" forState:UIControlStateNormal];
    [imgBt setImage:[UIImage imageNamed:@"s2.png"] forState:UIControlStateNormal];
    imgBt.titleLabel.font = [UIFont systemFontOfSize:15];
    [imgBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.AAView addSubview:imgBt];
    [imgBt setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];

    UISlider * slider = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W * 2/3, SCREEN_W/15)];
    slider.center = CGPointMake(imgBt.bounds.size.width +SCREEN_W * 1/3 + 10, (_AAView.bounds.size.height/2));
    [self.AAView addSubview:slider];
    [slider setMaximumValueImage:[UIImage imageNamed:@"s3.png"]];
    [slider setMinimumValueImage:[UIImage imageNamed:@"s3.png"]];
    self.slider = slider;
    [slider addTarget:self action:@selector(screenLight:) forControlEvents:UIControlEventValueChanged];
    slider.maximumValue = 1;
    slider.minimumValue = 0;
    //获取系统屏幕当前的亮度值
    slider.value = [UIScreen mainScreen].brightness;
    
}


- (void)screenLight:(UISlider *)slider{
    NSLog(@"slider.value = %f",slider.value);
    //获取系统屏幕当前的亮度值
    //float value = [UIScreen mainScreen].brightness;
    //slider.value = value;
    
    //设置系统屏幕的亮度值
    [[UIScreen mainScreen] setBrightness:slider.value];

}


- (void)creatLoadingAnimation{
    _imgArray = [NSMutableArray new];

    for (int i = 0; i < 8; i++) {
        UIImage * img = [UIImage imageNamed:[NSString stringWithFormat:@"loading%d.png",i]];
        if (img == nil) {
            [_imgArray addObject:@""];
        }else {
            [_imgArray addObject:img];
        }
    }
    [_imgArray removeObject:@""];
    
    
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.imgView.center = self.view.center;
    self.imgView.animationImages = _imgArray;
    self.imgView.animationDuration = 0.3;
    
}




- (void)loadingAnimation{

    [self.view addSubview:_imgView];
    [self.imgView startAnimating];
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSLog(@"shouldStartLoadWithRequest-URL=>>>>>%@",webView.request.URL.absoluteString);

    [self getArticleIdWithArticleURL:webView.request.URL.absoluteString];
    
    return YES;
}



- (void)webViewDidStartLoad:(UIWebView *)webView{

    NSLog(@"网页开始加载");
    
    NSLog(@"webViewDidStartLoad-URL=>>>>>%@",webView.request.URL.absoluteString);


}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"网页加载完成");
    NSLog(@"webViewDidFinishLoad-URL=>>>>>%@",webView.request.URL.absoluteString);

    [self getArticleIdWithArticleURL:webView.request.URL.absoluteString];
    
    
    if (webView.canGoBack) {
        
        self.closeBt.alpha = 1;
    }else{
        self.closeBt.alpha = 0;
    
    }
    

}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%@",error);
}




- (void)starToReckonByTime{

    self.isTimer = YES;
    
    self.timeValue = 0;
    
    if(self.myTimer == nil){
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reckonTime) userInfo:nil repeats:YES];

        [[NSRunLoop mainRunLoop] addTimer:self.myTimer forMode:NSRunLoopCommonModes];
        
    }

}

//计时
- (void)reckonTime{

    self.timeValue ++;
    
    
    if (self.timeValue > 300) {
        
        NSLog(@"任务完成");

        [self endReadArticle];
        
        [self stopTimer];
        
//        [self showFinishView];
        
    }

    NSLog(@"timeValue = %ld",self.timeValue);

}


//开始阅读
- (void)beginReadArticle{

    if (self.net == nil) {
        self.net = [[NetWork alloc]init];
    }
    
    [self.net readBeginStar];
    
    __weak webViewController * weakSelf = self;
    
    self.net.readEarnB=^(NSString * code,NSString * message){
    
        if ([code isEqualToString:@"1"]) {
            
            [weakSelf starToReckonByTime];

        }else{
        
            
        
        }
        
    };
    
}

//结束阅读
- (void)endReadArticle{
    if (self.net == nil) {
        self.net = [[NetWork alloc]init];
    }
    
    [self.net readEnd];
    
    
    __weak webViewController * weakSelf = self;
    
    self.net.readEarnFinishB = ^(NSString * code){
    
    
        if ([code isEqualToString:@"1"]) {
            
            [weakSelf showFinishView];
            
        }
        
    };
}

//移除定时器
- (void)stopTimer{

    [self.myTimer invalidate];
    self.myTimer = nil;

}

//完成任务提示
- (void)showFinishView{

    self.isFinishTask = YES;
    
    UIView * view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.tag = 1221;
    view.backgroundColor = [UIColor colorWithRed:36/255.0 green:38/255.0 blue:47/255.0 alpha:0.7];
    
    [self.view addSubview:view];
    
    UIImageView * imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/2, SCREEN_W/2)];
    imgV.center = CGPointMake(SCREEN_W/2, SCREEN_H/2 - 20);
    imgV.image = [UIImage imageNamed:@"tip_bg_star.png"];
    [view addSubview:imgV];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/2, 20)];
    label.text = @"稍后请在明细里查看收益";
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


//时间戳
- (void)nowTime{

//    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    
//    NSString * addTime = [NSString stringWithFormat:@"%.f",interval];


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
        case UMSocialPlatformType_Qzone:
            imageName = @"UMS_qzone_icon";
            paltFormName = @"Qzone";
            break;
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
                    case 2:
                        message = @"未安装该应用,无法分享!";
                        break ;
                        
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

    NSDictionary * dict =[[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    NSString * uid = dict[@"uid"];
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    NSString *title = self.bigTitle;
    NSString *url = [NSString stringWithFormat:@"%@/uid/%@",self.shareUrl,uid];
    messageObject.text = [NSString stringWithFormat:@"转//#微转啦#<<%@>>%@",title,url];
    //创建图片对象
    UMShareImageObject *shareImgObject = [[UMShareImageObject alloc]init];
    [shareImgObject setShareImage:self.thumbimg];
    messageObject.shareObject = shareImgObject;
    return messageObject;

}

//创建分享内容对象
- (UMSocialMessageObject *)creatMessageObject
{
    
    NSDictionary * dict =[[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
    NSString * uid = dict[@"uid"];

    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    NSString *title = self.bigTitle;
    NSString *url = [NSString stringWithFormat:@"%@/uid/%@",self.shareUrl,uid]; //@"http://wsq.umeng.com";
    NSString *text = self.abstract;
    NSString * thumbImg = self.thumbimg;
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:text thumImage:thumbImg];
    [shareObject setWebpageUrl:url];
    messageObject.shareObject = shareObject;
    
    return messageObject;
}



#pragma mark- 检查是否有收藏
- (void)checkIsCollect{

    if (self.net == nil) {
        self.net = [[NetWork alloc]init];
    }

    [self.net userCollectionArticleShow];

    __weak webViewController * weakSelf = self;
    
    self.net.userArticleCollection=^(NSArray * dataArray){
    
        for (userCollectionArticleModel * model in dataArray) {
            
            if ([model.id_ isEqualToString:weakSelf.id_]) {
                
                weakSelf.starButton.selected = !weakSelf.starButton.selected;
                
            }
            
            
        }
        
        
    };
    
    
}


#pragma mark- 横幅广告

- (void)creatAdv{

    UIView * henfuAdv = [[UIView alloc]init];
    
    if (self.isReadEarn) {
        
        henfuAdv.frame = CGRectMake(0, SCREEN_H - SCREEN_W/8, SCREEN_W, SCREEN_W/8);
        
    }else{
        
        henfuAdv.frame = CGRectMake(0, CGRectGetMinY(self.shareBar.frame) - SCREEN_W/8, SCREEN_W, SCREEN_W/8);

    }
    
//    UIView * henfuAdv = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.shareBar.frame) - SCREEN_W/8, SCREEN_W, SCREEN_W/8)];
//    henfuAdv.backgroundColor =[UIColor clearColor];
    
    [self.view addSubview:henfuAdv];
    

}


- (NSString *)publisherId
{
    return  @"a6cbb950"; //@"your_own_app_id";注意，iOS和android的app请使用不同的app ID
    //    return @"ccb60059";
}

-(BOOL) enableLocation
{
    //启用location会有一次alert提示
    return YES;
}




- (void)didAdImpressed {
    NSLog(@"delegate: didAdImpressed");
    
}

- (void)didAdClicked {
    NSLog(@"delegate: didAdClicked");
}

- (void)didAdClose {
    NSLog(@"delegate: didAdClose");
}



#pragma mark- 调用原生分享
/**原生分享*/
- (void)locationShareActionWithURL:(NSString *)link{

    if (self.locationShareImage == nil) {
        
        self.locationShareImage = [UIImage imageNamed:@"icon200"];
    }
    
    NSArray * iteams = @[self.locationShareImage,self.bigTitle,[NSURL URLWithString:link]];
    
    
    UIActivityViewController * activity = [[UIActivityViewController alloc]initWithActivityItems:iteams applicationActivities:nil];
    
    [self presentViewController:activity animated:YES completion:nil];
        
    activity.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
    
        
        if (completed) {
            
            NSLog(@"分享成功！！");
            
        }else{
        
            NSLog(@"分享失败！！Error:%@",activityError);

        }
        
    };
    
    
}


/**获取分享缩略图*/
- (void)getShareImageWithThumb:(NSString *)thumb andHUD:(MBProgressHUD *)hud andShareLink:(NSString *)shareLink{
    

    SDWebImageManager * manger = [SDWebImageManager sharedManager];
    
    __weak webViewController * weakSelf = self;
    
    [manger.imageDownloader downloadImageWithURL:[NSURL URLWithString:self.thumbimg] options:SDWebImageDownloaderHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
        weakSelf.locationShareImage = image;
    
        [weakSelf locationShareActionWithURL:[NSString stringWithFormat:@"%@",shareLink]];

    }];
    
}

#pragma mark- 获取文章ID
- (void)getArticleIdWithArticleURL:(NSString *)url{
    
    NSArray * arr = [url componentsSeparatedByString:@"/"];
    
    NSLog(@"%@",arr);
    
    if (arr.count > 0) {
        
        
        for (int i = 0 ; i < arr.count ; i++) {
            
            if ([arr[i] isEqualToString:@"id"]) {
                
                if (i + 1 != arr.count) {
                    
                    self.id_ = arr[i + 1];
                    
                    break;
                }
            }
        }
        
        NSLog(@"-----current_ID:%@----",self.id_);
    }
    
    
}

@end
