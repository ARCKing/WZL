//
//  MoneyNextVC.m
//  发发啦
//
//  Created by gxtc on 16/9/13.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "MoneyNextVC.h"
#import "taskView.h"
#import "newUserFuLiView.h"
#import "readEarnView.h"
#import "shareEarnView.h"
#import "webViewController.h"
#import "LogInViewController.h"
#import "Invite_ViewController.h"
#import "shareEarnDetailVC.h"
#import "EditProfileViewController.h"
#import "HomeNextViewController.h"
#import "dayPupilView.h"
#import "NetWork.h"

@interface MoneyNextVC ()
@property(nonatomic,strong)taskView * taskView;
@property(nonatomic,strong)readEarnView * readView;
@property(nonatomic,strong)shareEarnView * shareView;
@property(nonatomic,strong)newUserFuLiView * FuLiView;




@end

@implementation MoneyNextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self addView:_buttonTag];
    
        
}


- (void)popVC{

    [self.navigationController popViewControllerAnimated:YES];

    self.toFourVc();
}


- (void)addView:(NSInteger)buttonTag{

    if (buttonTag == 1221) {
        
        _taskView =[[taskView alloc]initWithFrame:self.view.bounds];
        [_taskView initCreat];
        [self.view addSubview:_taskView];
        
        [_taskView.toFourVcButton addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
        
        
        __weak MoneyNextVC * weakSelf = self;
        _taskView.backBlock = ^{
        

            [weakSelf.navigationController popViewControllerAnimated:YES];
            
        };
        
        _taskView.readEarn=^{
        
            MoneyNextVC * money = [[MoneyNextVC alloc]init];
            
            money.buttonTag = 1;
        
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:money animated:YES];
        };
        
        _taskView.inviteFriend=^{
        
            Invite_ViewController * invite = [[Invite_ViewController alloc]init];
            
            invite.isShowBackButton = YES;
            
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:invite animated:YES];

            
        };
        
        _taskView.shareEarnBlock=^{
        
            MoneyNextVC * vc = [[MoneyNextVC alloc]init];
            vc.buttonTag = 2;
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        
        
    }else if(buttonTag == 1222){
        newUserFuLiView * fuli = [[newUserFuLiView alloc]initWithFrame:self.view.bounds];
        [fuli initCreat];
        [self.view addSubview:fuli];
        
        __weak MoneyNextVC * weakSelf = self;

        fuli.fuLiBlock =^{
        
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        
        
    }else if(buttonTag == 100){
        NSLog(@"每日收徒");
        
        dayPupilView * view = [[dayPupilView alloc]initWithFrame:self.view.bounds AndButtonTag:100 andMoney:@"0" andType:@"1"];
        
        
        [self.view addSubview:view];
        
        __weak MoneyNextVC * weakSelf = self;
        view.back=^{
        
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        
    }else if(buttonTag == 101){
        NSLog(@"每周收徒");
        
        dayPupilView * view = [[dayPupilView alloc]initWithFrame:self.view.bounds AndButtonTag:101 andMoney:@"0" andType:@"7"];

        [self.view addSubview:view];

        __weak MoneyNextVC * weakSelf = self;
        view.back=^{
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }else if(buttonTag == 102){
        NSLog(@"每月收徒");
        
        dayPupilView * view = [[dayPupilView alloc]initWithFrame:self.view.bounds AndButtonTag:102 andMoney:@"0" andType:@"30"];
        [self.view addSubview:view];

        __weak MoneyNextVC * weakSelf = self;
        view.back=^{
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        
    }else if (buttonTag == 1) {
    
        
        
        _readView =[[readEarnView alloc]initWithFrame:self.view.bounds];
        [_readView initCreat];
        [self.view addSubview:_readView];
        
        __weak MoneyNextVC * weakSelf = self;
        _readView.backBlock = ^{
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        

        _readView.toWebView=^(NSString * titlt,NSInteger inddex){
        
            NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"usermessage"];
            NSString * isLogin = [[NSUserDefaults standardUserDefaults]objectForKey:@"isLogIn"];

            NSLog(@"%@%ld",titlt,inddex);
            
            if ([isLogin isEqualToString:@"1"]) {
                
                NSString * url = @"http://wz.lgmdl.com/App/Read/category";
                NSString * token = dic[@"token"];
                NSString * uid = dic[@"uid"];
                NSInteger cid = inddex + 1;
                
                
                webViewController * webView = [[webViewController alloc]init];
                webView.isPost = YES;
                webView.isReadEarn = YES;
                webView.urlString = url;
                webView.articleTitle =titlt;
                webView.token = token;
                webView.uid = uid;
                webView.cid = cid;
                
                
                weakSelf.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:webView animated:YES];
                weakSelf.hidesBottomBarWhenPushed = YES;
                
            }else{
                LogInViewController * login = [[LogInViewController alloc]init];
                [weakSelf presentViewController:login animated:YES completion:nil];
            }
            
        };
        
        
    }else if (buttonTag == 2) {
        
        
        _shareView = [[shareEarnView alloc]initWithFrame:self.view.bounds];
        [_shareView initCreat];
        [self.view addSubview:_shareView];

        __weak MoneyNextVC * weakSelf = self;
        _shareView.backBlock = ^{
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };

        _shareView.shareEarnDetail=^(shareEarnModel * model){
        
            shareEarnDetailVC * vc = [[shareEarnDetailVC alloc]init];
        
            vc.model = model;
            weakSelf.hidesBottomBarWhenPushed = YES;

            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    
    }else if (buttonTag == 3) {
        
    }else if (buttonTag == 0) {
        self.FuLiView = [[newUserFuLiView alloc]initWithFrame:self.view.bounds];
        [self.FuLiView initCreat];
        [self.view addSubview:self.FuLiView];
        
        __weak MoneyNextVC * weakSelf = self;
        self.FuLiView.fuLiBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };

        self.FuLiView.editPersonMessage=^{
        
            EditProfileViewController * editVc = [[EditProfileViewController alloc]init];
        
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:editVc animated:YES];
        };
        
        
        self.FuLiView.signRed=^{
        
            HomeNextViewController * homeNext = [[HomeNextViewController alloc]init];
            homeNext.buttonTag = 8000;
            
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:homeNext animated:YES];
        };
        
        
        self.FuLiView.toInvite=^{
        
            Invite_ViewController * invite = [[Invite_ViewController alloc]init];
            invite.isShowBackButton = YES;
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:invite animated:YES];

        
        };
        
        
        self.FuLiView.toWeb=^(articleModel * model){
        
            webViewController * web = [[webViewController alloc]init];
        
            NSString * url = [NSString stringWithFormat:@"http://wz.lgmdl.com/app/article/detail_new/id/%@",model.id_];
            
            web.id_ = model.id_;
            web.urlString = url;
            web.share_count = [NSString stringWithFormat:@"%@",model.share_count];
            web.shareUrl = url;
            web.thumbimg = model.thumb;
            web.bigTitle = model.title;
            
            web.ucshare = model.ucshare;
            web.qqshare = model.qqshare;
            web.share = model.share;
            
            web.share_count = [NSString stringWithFormat:@"%d",arc4random()%5000+1000];
            
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:web animated:YES];
            
            
            
        };
        
        
    }

}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
