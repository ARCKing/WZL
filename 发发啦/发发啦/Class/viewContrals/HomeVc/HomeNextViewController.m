//
//  HomeNextViewController.m
//  发发啦
//
//  Created by gxtc on 16/8/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "HomeNextViewController.h"
#import "NewComerView.h"
#import "InComeRankView.h"
#import "SetView.h"
#import "WithdrawView.h"
#import "profitView.h"
#import "SignInRedView.h"
#import "GrabRedCashView.h"
#import "MyCollectView.h"
#import "EditProfileViewController.h"
#import "LogInViewController.h"
#import "ResetCodeViewController.h"
#import "GrabDetailViewController.h"
#import "ContactUsView.h"
#import "RingMessageVC.h"
#import "changePassWordVc.h"
#import "webViewController.h"
#import "UCShareView.h"
#import "userCollectionArticleModel.h"
#import "NetWork.h"
#import "UCShareView.h"
#import "NetWork.h"
#import "UIImageView+WebCache.h"
#import "BinDingWeChatVC.h"
#import "aboutUsVc.h"
#import "MBProgressHUD.h"

#import <UMMobClick/MobClick.h>

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
@interface HomeNextViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong) UCShareView * ucShareView;
@property(nonatomic,retain)UIActivityViewController * activity;
@property(nonatomic,retain)UIImageView * saoYiSaoView;
@property(nonatomic,retain)NetWork * net;
@property(nonatomic,copy)NSString * isLoginState;


@property(nonatomic,copy)NSString * shareLink;
@property(nonatomic,copy)NSString * shareBgViewImgLing;
@property(nonatomic,strong)UIImageView * QrImagView;
@property(nonatomic,strong)UIImage * QrImag;
@property(nonatomic,strong)UIImage * addImage;
@property(nonatomic,assign)BOOL isWeiBoShare;
@property(nonatomic,retain)NSString * isLogIn;

@property(nonatomic,retain)UIView* myAdvView;
@property(nonatomic,retain)MBProgressHUD * hud;



@end

@implementation HomeNextViewController


- (void)viewDidAppear:(BOOL)animated{

    
    [super viewDidAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];


//    [self didLoadViewWithButtonTag];

}




- (void)viewDidLoad {
    [super viewDidLoad];
    

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webJump:) name:@"userInfoNotification" object:nil];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reLoginAleartView) name:@"reLogin" object:nil];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    self.isLoginState = [userDefaults objectForKey:@"isLogIn"];

    if ([self.isLoginState isEqualToString:@"1"]) {
        
        [self checkingUserToken];
    }
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    [self didLoadViewWithButtonTag];
    
    
    
    
    if (![self.isLoginState isEqualToString:@"1"]) {

        
        LogInViewController * log = [[LogInViewController alloc]init];
        
        [self presentViewController:log animated:YES completion:nil];
    }
    
    
}


//推送跳转
- (void)webJump:(NSNotification *)userInfo{
    
    webViewController * web = [[webViewController alloc]init];
    web.urlString = userInfo.userInfo[@"aps"][@"sound"];
    [self.navigationController pushViewController:web animated:YES];
    
    
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
    
        __weak HomeNextViewController * weakSelf = self;
    
    self.net.checkingToken= ^(NSString * code){
        
        if ([code isEqualToString:@"0"]) {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"reLoginHome" object:nil];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"isLogIn"];
            
            [weakSelf performSelector:@selector(reLoginAleartView) withObject:nil];
        }
        
    };
}


- (void)reLoginAleartView{
    
    
    UILabel * Label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 90)];
    Label.center = self.view.center;
    Label.backgroundColor =[ UIColor blackColor];
    Label.text = [NSString stringWithFormat:@"登录异常，请重新登录!"];
    Label.textColor = [UIColor whiteColor];
    Label.textAlignment = NSTextAlignmentCenter;
    Label.layer.cornerRadius = 5;
    Label.clipsToBounds = YES;
    [self.view addSubview:Label];
    
    [self performSelector:@selector(reLoginPlease:) withObject:Label afterDelay:1];
    
    
}



//重新登录
- (void)reLoginPlease:(UILabel *)label{
    
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController popViewControllerAnimated:YES];
    
    [label removeFromSuperview];
//    LogInViewController * loginVc = [[LogInViewController alloc]init];
//    [self presentViewController:loginVc animated:YES completion:nil];
}








//- (NSString *)publisherId
//{
//    return  @"a6cbb950"; //@"your_own_app_id";注意，iOS和android的app请使用不同的app ID
//}
//
//-(BOOL) enableLocation
//{
//    //启用location会有一次alert提示
//    return YES;
//}
//
//
//-(void) willDisplayAd:(BaiduMobAdView*) adview
//{
//    NSLog(@"delegate: will display ad");
//}
//
//-(void) failedDisplayAd:(BaiduMobFailReason) reason;
//{
//    NSLog(@"delegate: failedDisplayAd %d", reason);
//}
//
//- (void)didAdImpressed {
//    NSLog(@"delegate: didAdImpressed");
//    
//}
//
//- (void)didAdClicked {
//    NSLog(@"delegate: didAdClicked");
//}
//
//- (void)didAdClose {
//    NSLog(@"delegate: didAdClose");
//}

//==========================================================

- (void)didLoadViewWithButtonTag{

    if(_buttonTag == 1000){
        NSLog(@"1000");
        
    }else if (_buttonTag == 8000){
        NSLog(@"8000");
        
        
        
        SignInRedView * signInView = [[SignInRedView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:signInView];
        [signInView initCreat];
        

        
        signInView.backBlock= ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        };
        
        
        __weak HomeNextViewController * weakSelf = self;
        signInView.shareViewBlock=^{
        
            _ucShareView = [[UCShareView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_W, SCREEN_H) andIsinvite:YES];
            
            [weakSelf.view addSubview:_ucShareView];
        
            [weakSelf getShareLinkFromNet];
            
        };
        
        
        signInView.advViewShou = ^(UIView * advView){
        
        
        
        };
        
        
        
    }else if (_buttonTag == 8001){
        NSLog(@"8001");
        
        WithdrawView * withDraw = [[WithdrawView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:withDraw];
        [withDraw initCreat:0];
        withDraw.backBlock = ^{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        };
        
        
        __weak HomeNextViewController * weakSelf = self;

        withDraw.WXBangDing=^(NSString * message){
        
        
            UIAlertController * alterContral = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"以后再说" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"去绑定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                BinDingWeChatVC * vc = [[BinDingWeChatVC alloc]init];
               
                weakSelf.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:vc animated:YES];
//                weakSelf.hidesBottomBarWhenPushed = NO;
                
            }];

            
            [action1 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
            [action2 setValue:[UIColor orangeColor] forKey:@"titleTextColor"];
            
            [alterContral addAction:action1];
            [alterContral addAction:action2];
            
            
            [weakSelf presentViewController:alterContral animated:YES completion:nil];
        
        };
        
        
        
    }else if (_buttonTag == 8002){
        NSLog(@"8002");
        
       
        
        InComeRankView * inComeRankView = [[InComeRankView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:inComeRankView];
        
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide = YES;

        self.hud = hud;

        [inComeRankView initCreat:hud];
        inComeRankView.incomeBlock=^{
        
            [self.navigationController popToRootViewControllerAnimated:YES];

        };
        
        
    }else if (_buttonTag == 8003){
        NSLog(@"8003");
        
        ContactUsView * contUsView = [[ContactUsView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:contUsView];
        
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide = YES;
        
        self.hud = hud;

        [contUsView initCreat:hud];
        
        contUsView.backBlock = ^{
            [self.navigationController popToRootViewControllerAnimated:YES];

            
        };
        
    }else if (_buttonTag == 8004){
        NSLog(@"8004");
        
        MyCollectView * myCollectView = [[MyCollectView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:myCollectView];
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide = YES;

        self.hud = hud;

        
        [myCollectView initCreat:hud];
        myCollectView.backBlock=^{
            [self.navigationController popViewControllerAnimated:YES];
        };
        
        
        __weak HomeNextViewController * weakSelf = self;
        myCollectView.webBlock=^(userCollectionArticleModel * model){
        
            webViewController * web = [[webViewController alloc]init];
        
            web.urlString = model.url;
        
            web.id_ = model.id_;
            
            web.share_count = model.share_count;
            
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:web animated:YES];
        };
        
        
        
        
    }else if (_buttonTag == 8005){
        NSLog(@"8005");
        
    }else if (_buttonTag == 8006){
        NSLog(@"8006");
        SetView * setView = [[SetView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:setView];
        [setView initCreat];
        __weak SetView * weakSetView = setView;

        setView.exitBlock=^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        };
        
        setView.exitBlock2=^{

            UIAlertController * alertController =[ UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"温馨提示"] message:[NSString stringWithFormat:@"是否退出"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"确定"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
                
                if ([[userDefaults objectForKey:@"isLogIn"] isEqualToString:@"1"]) {
                    
                    [userDefaults setObject:@"0" forKey:@"isLogIn"];
                    
                }

                [MobClick profileSignOff];

                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
            
            UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"取消"] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"取消退出登录！");
            }];
            
            [alertController addAction:defaultAction];
            [alertController addAction:cancleAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        };
        
        
        setView.editBolck=^{
        
            EditProfileViewController * editProfile = [[EditProfileViewController alloc]init];
            
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:editProfile animated:YES];
        
        };
        
        setView.logBlock=^{
            LogInViewController * logInVC = [[LogInViewController alloc]init];
            [self presentViewController:logInVC animated:YES completion:nil];
        

        };
        
        setView.newPassBlock=^{
           changePassWordVc  * changeVC = [[changePassWordVc alloc]init];
            [self presentViewController:changeVC animated:YES completion:nil];
        
        };
        
        
        setView.clearBlock=^{
            UIAlertController * alertController =[ UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"温馨提示"] message:[NSString stringWithFormat:@"是否清除缓存"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"确定"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [weakSetView ClearManager];
            }];
            
            UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"取消"] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"取消清除缓存！");
            }];
            
            [alertController addAction:defaultAction];
            [alertController addAction:cancleAction];
            [self presentViewController:alertController animated:YES completion:nil];
        
        };
        
        
        setView.bdWeiXing=^{
        
            BinDingWeChatVC * bangdingWeiXin = [[BinDingWeChatVC alloc]init];
            
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:bangdingWeiXin animated:YES];
        
        };
        
        
        __weak HomeNextViewController * weakSelf = self;
        setView.aboutUs=^{
        
            aboutUsVc * aboutUs = [[aboutUsVc alloc]init];
            
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:aboutUs animated:YES];
        
        
        };
        
        
        setView.toWeb=^{
        
            webViewController * web = [[webViewController alloc]init];
            web.urlString = @"http://wz.lgmdl.com/App/Course/newCourse/type/privacy";
            web.isNewTeach = YES;
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:web animated:YES];
            
        };
        
        
        setView.collectionBK = ^{
            
          
            HomeNextViewController * vc =[[HomeNextViewController alloc]init];
            vc.buttonTag = 8004;
            
            self.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        
        
    }else if (_buttonTag == 8007){
        NSLog(@"8007");
        NewComerView * comerView = [[NewComerView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:comerView];
        [comerView initCreat];
        
        comerView.backBlock = ^{
        
            [self.navigationController popToRootViewControllerAnimated:YES];
        
        };
        
        comerView.h5Block=^(NSString * type){
        
            webViewController * web = [[webViewController alloc]init];
            NSString * str = @"http://wz.lgmdl.com/App/Course/newCourse/type/";
            NSString * url = [NSString stringWithFormat:@"%@%@",str,type];
            
            web.isNewTeach = YES;
            
            web.urlString = url;
        
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:web animated:YES];
//            self.hidesBottomBarWhenPushed = NO;
        };
        
        
        
    }else if (_buttonTag == 100){
        NSLog(@"100");
        
    }else if (_buttonTag == 101){
        NSLog(@"101");
        
        GrabRedCashView * grabRedView = [[GrabRedCashView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:grabRedView];
        [grabRedView initCreat];
        grabRedView.backBlock=^{
        
            [self.navigationController popViewControllerAnimated:YES];

        };
        
        
        
        
        grabRedView.groupBlock=^(NSInteger Buttontag){
        
            GrabDetailViewController * detailVc = [[GrabDetailViewController alloc]init];
            detailVc.buttonTag = Buttontag;
            
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailVc animated:YES];
        
        };
        
        
        
    }else if (_buttonTag == 102){
        NSLog(@"102");
        
    }else if (_buttonTag == 4000 || _buttonTag == 4008||_buttonTag == 4009||_buttonTag == 4010){
        
        NSLog(@"4000");
        
       
        
        
        profitView * profitVc = [[profitView alloc]initWithFrame:self.view.bounds];
        
        if (_buttonTag == 4010) {
            
            profitVc.page = 1;
        }else{
            
            profitVc.page = 0;
        }
        
        
        
        [self.view addSubview:profitVc];
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide = YES;
        [profitVc initCreat:hud];
        self.hud = hud;
        profitVc.backBlock = ^{
         [self.navigationController popToRootViewControllerAnimated:YES];
            
        };
        
    }else if (_buttonTag == 4001){
        NSLog(@"4001");
        
        WithdrawView * withDraw = [[WithdrawView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:withDraw];
        [withDraw initCreat:1];
        
        withDraw.backBlock = ^{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        };
        
    }else if (_buttonTag == 4002){
        
                
    }


}




#pragma mark- 请求分享链接
- (void)getShareLinkFromNet{
    
    NetWork * net = [[NetWork alloc]init];
    [net getShareLinkFromNet];
    
    __weak HomeNextViewController * weakSelf = self;
    
    net.shareLinkBackBlock=^(NSString * url,NSString * imgUrl){
        weakSelf.shareLink = url;
        weakSelf.shareBgViewImgLing = imgUrl;
        
        
//            weakSelf.ucShareView = [[UCShareView alloc]initWithFrame:self.view.bounds andIsinvite:YES];
            
            [weakSelf.ucShareView.weixin addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [weakSelf.ucShareView.weixinFriend addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [weakSelf.ucShareView.QQ addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [weakSelf.ucShareView.QZone addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [weakSelf.ucShareView.saoYiSao addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [weakSelf.ucShareView.sinaWeiBo addTarget:weakSelf action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
        
        [weakSelf.view addSubview:weakSelf.ucShareView];
        
        [self QrBgViewGet];
        [self QrCode];
        
    };
    
    
}



#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    
    LogInViewController * logVc = [[LogInViewController alloc]init];
    
    if (button.tag == 1000) {
        NSLog(@"1000-未登录");
        
        [self presentViewController:logVc animated:YES completion:nil];
        
    }else if (button.tag == 1001) {
        
        NSLog(@"1001");
        
        if ([_isLogIn isEqualToString:@"1"]) {
            
            [self getShareLinkFromNet];
            
            
            
            
            //            if (self.ucShareView == nil) {
            //                self.ucShareView = [[UCShareView alloc]initWithFrame:self.view.bounds andIsinvite:YES];
            //
            //                [self.ucShareView.weixin addTarget:self action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            //
            //                [self.ucShareView.weixinFriend addTarget:self action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            //
            //                [self.ucShareView.QQ addTarget:self action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            //
            //                [self.ucShareView.QZone addTarget:self action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            //
            //                [self.ucShareView.saoYiSao addTarget:self action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            //
            //                [self.ucShareView.exitShare2 addTarget:self action:@selector(ucshareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            //
            //
            //
            //            }
            //
            //            [self.view addSubview:self.ucShareView];
            
            
            
            
            
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
    }
    
}


#pragma mark- 扫一扫背景图
- (void)QrBgViewGet{
    
    self.QrImagView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W *3/4, SCREEN_H *3/4)];
    self.QrImagView.center = self.view.center;
    [self.QrImagView sd_setImageWithURL:[NSURL URLWithString:self.shareBgViewImgLing]];
    self.QrImagView.userInteractionEnabled = YES;
    
}

//分享
- (void)ucshareButtonAction:(UIButton *)bt{
    
    
    
    UIImage * upImg;
    upImg = self.QrImagView.image;
    
    if (upImg == nil) {
        upImg = [UIImage imageNamed:@"friends.jpg"];
    }

    
    UIImage * addImage = [self addDownImage:upImg andUpImage:self.QrImag];
    
    self.addImage = addImage;
    
    
    if (bt.tag == 1115) {
        //扫一扫
        NSLog(@"扫一扫");
        [_ucShareView removeFromSuperview];
        
        
        if (self.saoYiSaoView == nil) {
            
            self.saoYiSaoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W *2/ 5, SCREEN_W *2/ 5 )];
            self.saoYiSaoView.center = CGPointMake(self.QrImagView.frame.size.width/2, self.QrImagView.frame.size.height/2 + SCREEN_W/5);
            self.saoYiSaoView.image = self.QrImag;
            self.saoYiSaoView.userInteractionEnabled = YES;
            [self.QrImagView addSubview:self.saoYiSaoView];
            
        }
        [self.QrImagView addSubview:self.saoYiSaoView];
        
        [self.view addSubview:self.QrImagView];
        
        
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
    
    [self.QrImagView removeFromSuperview];
    
    [self.hud hideAnimated:YES];

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
        NSString * title = @"微转啦-赚钱啦";
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
    
    [self.ucShareView removeFromSuperview];
    
}


#pragma mark- 二图叠加

- (UIImage *)addDownImage:(UIImage *)image1 andUpImage:(UIImage *)image2{
    
    UIImage * downImage = image1;
    UIImage * upImage = image2;
    
    UIGraphicsBeginImageContext(downImage.size);
    
    [downImage drawInRect:CGRectMake(0, 0, downImage.size.width, downImage.size.height)];
    [upImage drawInRect:CGRectMake(downImage.size.width/2 - upImage.size.width, downImage.size.height/2, upImage.size.width * 2, upImage.size.height * 2)];
    
    
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
    
    UMSocialMessageObject * messageObject;
    
    
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"分享状态"]
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









//- (void)dismss:(UIAlertController *)alert{
//    
//    if (alert) {
//        [alert dismissViewControllerAnimated:YES completion:^{
//            
//            //            消失后所执行的代码
//            
//        }];
//    }
//    
//}

@end
