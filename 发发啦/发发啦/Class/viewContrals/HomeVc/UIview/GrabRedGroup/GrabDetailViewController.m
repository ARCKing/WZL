//
//  GrabDetailViewController.m
//  发发啦
//
//  Created by gxtc on 16/9/2.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "GrabDetailViewController.h"
#import "myTableViewCell.h"
#import "grabMoneyCell.h"
#import "GrabRedCashLuckVC.h"
#import "redModel.h"
#import "userRedModel.h"
#import "NetWork.h"
#import "redBigModel.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "UCShareView.h"
#import "UIImageView+WebCache.h"





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

@interface GrabDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,retain)UILabel * mylabel;
@property(nonatomic,retain)NSMutableAttributedString * attrstring;
@property(nonatomic,retain)UITableView * tableview;

@property(nonatomic,retain)myTableViewCell * myCell;
@property(nonatomic,retain)grabMoneyCell * grabCell;

@property(nonatomic,retain)UIView * navView;

@property(nonatomic,retain)UIView * getMoneyView;
@property(nonatomic,retain)UIImageView * getMoneyImageView;
@property(nonatomic,retain)UILabel * placeHolderLabel;
@property(nonatomic,retain)UIButton * resoultButton;

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,strong)NSMutableArray * redModelArray;
@property(nonatomic,strong)NSMutableArray * articleModelArray;

@property(nonatomic,strong)UILabel * nextTimeLabel;

@property(nonatomic,strong)NetWork * net;

@property(nonatomic,strong)UIButton * refrushButton;

@property(nonatomic,assign)BOOL grabMoneyStatus;

@property(nonatomic,strong)MBProgressHUD * HUD;


@property(nonatomic,strong) UCShareView * ucShareView;
@property(nonatomic,retain)UIActivityViewController * activity;
@property(nonatomic,retain)UIImageView * saoYiSaoView;
@property(nonatomic,copy)NSString * isLoginState;


@property(nonatomic,copy)NSString * shareLink;
@property(nonatomic,copy)NSString * shareBgViewImgLing;
@property(nonatomic,strong)UIImageView * QrImagView;
@property(nonatomic,strong)UIImage * QrImag;
@property(nonatomic,strong)UIImage * addImage;
@property(nonatomic,assign)BOOL isWeiBoShare;
@property(nonatomic,copy)NSString * isLogIn;

@property(nonatomic,copy)NSString * nextTime;
@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,strong)NSTimer * timer2;

@property(nonatomic,assign)int sss;
@property(nonatomic,assign)int mmm;


@end

@implementation GrabDetailViewController




- (void)viewWillAppear:(BOOL)animated{

//    [[UIApplication sharedApplication].keyWindow addSubview:self.refrushButton];
    
    [super viewWillAppear:animated];
    
    [self.view addSubview:self.refrushButton];

    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray new];
    self.redModelArray = [NSMutableArray new];
    self.articleModelArray = [NSMutableArray new];
    
    [self navViewCreat];
    [self tableViewCreat];
    [self getRedDataFromNet];
    
    
       
}

#pragma mark- 获取红包列表数据
- (void)getRedDataFromNet{

    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.removeFromSuperViewOnHide = YES;
    [self.HUD hideAnimated:YES afterDelay:3];
    self.HUD.mode = MBProgressHUDModeIndeterminate;
    
    if (self.net == nil) {
        
        self.net = [[NetWork alloc]init];
    }

    [self.net grabRedDataMessage];
    
    __weak GrabDetailViewController * weakSelf = self;
    
    self.net.redBigBlock=^(redBigModel * model){
    
        
        weakSelf.redModelArray = [NSMutableArray arrayWithArray:model.redModelArray];
        weakSelf.articleModelArray = [NSMutableArray arrayWithArray:model.articleModelArray];
        
        weakSelf.nextTimeLabel.text = [NSString stringWithFormat:@"下一波红包%@开枪",model.next];
        [weakSelf.view addSubview:weakSelf.nextTimeLabel];
        
        
        [weakSelf.tableview reloadData];
        weakSelf.HUD.hidden = YES;
        
        weakSelf.nextTime = model.next;

        [weakSelf timeStar];

        
        NSLog(@"2==%f",weakSelf.tableview.contentSize.height);
        
#pragma mark-滑到底部
//        滑到底部
        if (self.tableview.contentSize.height > self.tableview.frame.size.height)
        {
            CGPoint offset = CGPointMake(0, weakSelf.tableview.contentSize.height - weakSelf.tableview.frame.size.height);
            
            [weakSelf.tableview setContentOffset:offset animated:NO];
            
        }else {
        
            [weakSelf.tableview setContentOffset:CGPointMake(0, weakSelf.tableview.bounds.size.height) animated:NO];

        }
        
        
    };
    
}


#pragma mark- navViewCreat
- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    [self.view addSubview:button];
#pragma mark- button.tag-3000
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
//    titleLabel.text = @"签到红包";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 40);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    
    
    if (self.buttonTag == 0) {
        
        titleLabel.text = @"普通群";
    }else if (self.buttonTag == 1) {
        titleLabel.text = @"VIP1群";
    }else if (self.buttonTag == 2) {
        titleLabel.text = @"VIP2群";

    }
    
    
    self.nextTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, 40)];
    self.nextTimeLabel.font =[ UIFont systemFontOfSize:16];
    self.nextTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.nextTimeLabel.backgroundColor = [UIColor blackColor];
    self.nextTimeLabel.alpha = 0.6;
    self.nextTimeLabel.textColor = [UIColor whiteColor];
    
    
#pragma mark- 刷新按钮
    self.refrushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.refrushButton setImage:[UIImage imageNamed:@"group_refresh.png"] forState:UIControlStateNormal];
    self.refrushButton.frame = CGRectMake(SCREEN_W - SCREEN_W/8 - 15, SCREEN_H - SCREEN_W/8 - 64, SCREEN_W/8, SCREEN_W/8);
    [self.refrushButton addTarget:self action:@selector(refrushButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
}


//刷新按钮
- (void)refrushButtonAction{

    NSLog(@"刷新!");
    
    
    [self getRedDataFromNet];

}

- (void)tableViewCreat{


    self.view.backgroundColor = [UIColor whiteColor];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W , SCREEN_H -64) style:UITableViewStylePlain];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
//    self.tableview.rowHeight = SCREEN_H /2;
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableview.cellLayoutMarginsFollowReadableWidth = YES;
    
    [self.tableview layoutIfNeeded];
    
    [self.view addSubview:_tableview];


}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger num = self.redModelArray.count;
    return num;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _myCell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"cell_%ld",indexPath.row]];
    if (_myCell == nil) {
        _myCell = [[myTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"cell_%ld",indexPath.row]];
    }
    
    _myCell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    [_myCell.button addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
    
    [_myCell.getButton addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _myCell.button.tag = indexPath.row + 1111;
    _myCell.getButton.tag = indexPath.row + 2222;
    
    
    redModel * model = self.redModelArray[indexPath.row];
    
    NSArray * threePeopleArray = model.manArray;
    
    
    NSLog(@"%@",model.title);
    
    _myCell.redModel = model;
    
    [_myCell showThreePeople:threePeopleArray];
    
    return _myCell;
    
}


- (void)buttonAction1:(UIButton *)button{

    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    
    
    int index = (int)button.tag - 2222;
    
    redModel * model = self.redModelArray[index];

    NSString * hour = model.hour;
    
    NSLog(@"点击红包");
    
    if ( self.net == nil) {
        self.net = [[NetWork alloc]init];
    }
    
    [self.net starGrabRedMoneyWithHour:hour];
    
    
    __weak GrabDetailViewController * weakSelf = self;
    
    self.net.grabMoner=^(NSString * data){
        
        hud.hidden = YES;
        
        NSLog(@"%@",data);
        
    weakSelf.placeHolderLabel.text = data;

    [weakSelf.view addSubview:weakSelf.getMoneyView];

        
    };
    
    [weakSelf subViewCreat];

}


- (void)buttonAction2:(UIButton *)button{
    
    int index = (int)button.tag - 1111;
    redModel * model = self.redModelArray[index];
    NSString * hour = model.hour;
    
    NSLog(@"查看手气");
      
    
    GrabRedCashLuckVC * luckVC = [[GrabRedCashLuckVC alloc]init];
    luckVC.hour = hour;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:luckVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;

    [self.refrushButton removeFromSuperview];
    
}



- (void)buttonAction:(UIButton *)button{
    
    
       if (button.tag == 3000) {
    
        NSLog(@"=3000=");
        [self.refrushButton removeFromSuperview];
        [self stopTimer];
           
        self.navigationController.hidesBottomBarWhenPushed = YES;
        [self.navigationController popViewControllerAnimated:YES];
    }else if (button.tag == 9900) {
        
        [self.getMoneyView removeFromSuperview];
     
    }
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//    _myCell = [tableView cellForRowAtIndexPath:indexPath];
//    _myCell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    NSLog(@"%ld",indexPath.row);
//}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    redModel * model = self.redModelArray[indexPath.row];
    
    NSArray * threePeopleArray = model.manArray;


    int count = (int)threePeopleArray.count;
    int num = 3;
    
    if (count > 3) {
        
        count = 3;
    }
    
    
    num = num - count;
    
    
    NSLog(@"%f",SCREEN_H/2 + 5 - num * SCREEN_W/8);
    
    return SCREEN_H/2 + 5 - num * SCREEN_W/8;
}




#pragma mark- subViewCreaet

- (void)subViewCreat{
    
    if (self.getMoneyView) {
        
        return;
    }
    
    
    
    self.getMoneyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    self.getMoneyView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    
    self.getMoneyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W/6, SCREEN_H/4, SCREEN_W - 30, SCREEN_H * 4/5)];
    
    self.getMoneyImageView.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);

    self.getMoneyImageView.userInteractionEnabled = YES;
    [self.getMoneyView addSubview:_getMoneyImageView];
    
    self.getMoneyImageView.image = [self addDownImage:@"red_envelope02.png" andUpImage:@"red_envelope01.png"];
    self.getMoneyImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.getMoneyImageView.userInteractionEnabled = YES;
//    [self.view addSubview:_getMoneyView];
    
    
    UIButton * xxbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    xxbutton.frame = CGRectMake(_getMoneyImageView.bounds.size.width * 10/12 - _getMoneyImageView.bounds.size.width/24, _getMoneyImageView.bounds.size.height/10 + _getMoneyImageView.bounds.size.height/14, _getMoneyImageView.bounds.size.width/12,_getMoneyImageView.bounds.size.height/14);
    //    xxbutton.backgroundColor = [UIColor blackColor];
    [self.getMoneyImageView addSubview:xxbutton];
#pragma mark- xxButton.tag-9900
    xxbutton.tag = 9900;
    
    [xxbutton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addResoutOfRedSingInButttonAndLabel];
    
    
   
}


#pragma mark- 签到处理结果
- (void)addResoutOfRedSingInButttonAndLabel{
    
    
    self.placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/2,25 )];
    self.placeHolderLabel.center = CGPointMake(self.getMoneyImageView.bounds.size.width/2, self.getMoneyImageView.bounds.size.height/2 - 10);
    //    self.placeHolderLabel.backgroundColor = [UIColor blackColor];
    self.placeHolderLabel.textColor = [UIColor colorWithRed:251/255.0 green:226/255.0 blue:0 alpha:1];
    self.placeHolderLabel.font = [UIFont systemFontOfSize:14];
    self.placeHolderLabel.textAlignment = NSTextAlignmentCenter;
    [self.getMoneyImageView addSubview:_placeHolderLabel];
    
    
    self.resoultButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.resoultButton.frame = CGRectMake(0, 0, self.getMoneyImageView.bounds.size.width * 3/5, 30);
    self.resoultButton.center = CGPointMake(self.getMoneyImageView.bounds.size.width/2, self.getMoneyImageView.bounds.size.height/2 + 20);
    self.resoultButton.backgroundColor = [UIColor colorWithRed:251/255.0 green:226/255.0 blue:0 alpha:1];
    self.resoultButton.layer.cornerRadius = 5;
    [self.getMoneyImageView addSubview:_resoultButton];
    self.resoultButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.resoultButton setTitleColor:[UIColor colorWithRed:36/255.0 green:38/255.0 blue:47/255.0 alpha:1] forState:UIControlStateNormal];
    
    
    [self.resoultButton addTarget:self action:@selector(resoultButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.resoultButton setTitle:@"立即收徒赚钱" forState:UIControlStateNormal];
}



#pragma mark- 一直收徒
- (void)resoultButtonAction{

    NSLog(@"收徒啦!");
    [self.getMoneyView removeFromSuperview];
    
  
        
    [self getShareLinkFromNet];
    

    
}



#pragma mark- 二图叠加

- (UIImage *)addDownImage:(NSString *)imageName1 andUpImage:(NSString *)imageName2{
    
    UIImage * downImage = [UIImage imageNamed:imageName1];
    UIImage * upImage = [UIImage imageNamed:imageName2];
    
    UIGraphicsBeginImageContext(downImage.size);
    
    [downImage drawInRect:CGRectMake(0, 0, downImage.size.width, downImage.size.height)];
    [upImage drawInRect:CGRectMake((downImage.size.width - upImage.size.width)/2, (downImage.size.height - upImage.size.height)/2, upImage.size.width, upImage.size.height)];
    
    
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}


//====================================
#pragma mark- 邀请收徒
#pragma mark- 请求分享链接
- (void)getShareLinkFromNet{
    
    NetWork * net = [[NetWork alloc]init];
    [net getShareLinkFromNet];
    
    __weak GrabDetailViewController * weakSelf = self;
    
    net.shareLinkBackBlock=^(NSString * url,NSString * imgUrl){
        weakSelf.shareLink = url;
        weakSelf.shareBgViewImgLing = imgUrl;
        
        
        weakSelf.ucShareView = [[UCShareView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_W, SCREEN_H) andIsinvite:YES];
        
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

    
    UIImage * addImage = [self addDownImages:upImg andUpImage:self.QrImag];
    
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
    [self.HUD hideAnimated:YES];
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
//        NSString * title = @"微转啦-赚钱啦";
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

- (UIImage *)addDownImages:(UIImage *)image1 andUpImage:(UIImage *)image2{
    
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
    
    UMSocialMessageObject *messageObject ;
    
    
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

#pragma mark-获取抢红包开始时间
- (void)getStarTime{

    
    NSDate * date = [NSDate date];

    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSString * dateString = [formatter stringFromDate:date];
    
    NSLog(@"%@",dateString);
    
    NSArray * nowTimeArray = [dateString componentsSeparatedByString:@":"];
    
    NSArray * nextTimeArray= [self.nextTime componentsSeparatedByString:@":"];
    
    int nowH = [nowTimeArray[0] intValue];
    int nowM =[nowTimeArray[1] intValue];
    int nowS = [nowTimeArray[2] intValue];
    
    int nextH = [nextTimeArray[0] intValue];
    int nextM = [nextTimeArray[1] intValue];

    NSLog(@"%d:%d:%d %d:%d",nowH,nowM,nowS,nextH,nextM);
    
    if (nowH == nextH) {
        
        if (nowM + 1 == nextM) {
            
            self.sss = 60 - nowS;
            self.mmm = 0.1;
            
            [self stopTimer];
            
            [self willToStar];
        }
        
        
    }
    
    
    NSLog(@"%@",[NSThread currentThread]);
    
}



#pragma mark-倒计时
- (void)willToStar{


    self.timer2 = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tiemOut) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer2 forMode:NSRunLoopCommonModes];

}




- (void)tiemOut{

    self.mmm++;
    
    if (self.mmm == 100) {
        self.mmm = 0.01;
        self.sss--;
    }
    
    
    self.nextTimeLabel.text = [NSString stringWithFormat:@"下一波红包%0.2d.%0.2d开枪",self.sss,self.mmm];
    

    if (self.sss == 0) {
        
        [self stopTimer];
        
        [self getRedDataFromNet];
    }
    
}


#pragma mark- 计时
- (void)timeStar{

    if (self.timer == nil) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getStarTime) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

    }

}


- (void)stopTimer{
    
    [self.timer invalidate];
    self.timer = nil;
    
    [self.timer2 invalidate];
    self.timer2 = nil;

}






@end
