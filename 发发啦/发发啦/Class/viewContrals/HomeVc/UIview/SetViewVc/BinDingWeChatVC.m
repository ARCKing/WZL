//
//  BinDingWeChatVC.m
//  发发啦
//
//  Created by gxtc on 16/11/14.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "BinDingWeChatVC.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "RegisterViewController.h"
#import "NetWork.h"
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface BinDingWeChatVC ()

@property(nonatomic,retain)UIView * navView;
@property(nonatomic,strong)UIScrollView * scrollView;

@property(nonatomic,retain)UIView * alertShowBgView;

@property(nonatomic,strong)UIButton * button;
@property(nonatomic,strong)UILabel * label;

@end

@implementation BinDingWeChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self navViewCreat];
    [self creatScrollView];
    
    [self weiXinBangDingStatus];
}


#pragma mark- 微信绑定状态与信息
- (void)weiXinBangDingStatus{

    NetWork * net = [[NetWork alloc]init];

    [net weiXingBangDingStatusData ];
    
    __weak BinDingWeChatVC * weakSelf = self;
    
    net.weixingStatusBangDing = ^(NSString * code,NSString * bind,NSString * wxbind,NSString * exchange_publicno){
    
        
        if ([code isEqualToString:@"1"]) {
        
            weakSelf.label.text = exchange_publicno;
        
            if ([wxbind isEqualToString:@"1"]) {
            
                [weakSelf.button setTitle:@"已绑定微信" forState:UIControlStateNormal];
//                weakSelf.button.backgroundColor = [UIColor greenColor];
                weakSelf.button.selected = YES;
            
                NSLog(@"%@",code);
            
            }
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
    //    [button setTitle:@"<–" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
    //    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
#pragma mark- button.tag-3000
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"绑定账号";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}

#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    if (button.tag == 3000) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (button.tag == 3344){
    
        NSLog(@"去绑定微信");
        
        NSLog(@"我是微信登录");
        NSLog(@"%s",__func__);
        
        if ([WXApi isWXAppInstalled]) {
            SendAuthReq *req = [[SendAuthReq alloc] init];
            req.scope = @"snsapi_userinfo" ;
            req.state = @"App";
            [WXApi sendReq:req];
        }
        else {
            [self setupAlertController];
        }
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bangDingWeiXin:) name:@"bangDingWeiXin" object:nil];


        
    }else if (button.tag == 4455){
        
        NSLog(@"完成绑定");
//        [self.navigationController popViewControllerAnimated:YES];
        
        
        NetWork * net = [[NetWork alloc]init];
        [net weiXinGuanZhuStatues];
        __weak BinDingWeChatVC * weakSelf = self;

        net.weiXinGuanZhu=^(NSString * code,NSString * message){
        
            [weakSelf aleratShow:message];
        
        };
        
    }
}








#pragma mark- 绑定微信
- (void)bangDingWeiXin:(NSNotification *)notificiation{

    NSDictionary * dic = notificiation.userInfo;
    
    NetWork * net = [[NetWork alloc]init];
    
    [net bangDingWeiXinWithToken:dic[@"access_token"] andOpinid:dic[@"openid"] andUnionid:dic[@"unionid"]];
    
    __weak BinDingWeChatVC * weakSelf = self;
    
    net.weiXinBangDing =^(NSString * code,NSString * message){
    
    
        if ([code isEqualToString:@"1"]) {
            
            [weakSelf.button setTitle:@"已绑定微信" forState:UIControlStateNormal];
            weakSelf.button.selected = YES;
            
        }
        
        NSLog(@"%@",message);
    
        [weakSelf aleratShow:message];
        
    };
    
}



- (void)aleratShow:(NSString *)message{


    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width / 2, self.view.bounds.size.width/4)];
    label.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    label.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = message;
    label.font = [UIFont systemFontOfSize:14];
    label.layer.cornerRadius = 10;
    label.clipsToBounds = YES;
    
//    [self performSelector:@selector(cancleAlraterReset:) withObject:label afterDelay:2];

    [UIView animateWithDuration:3 animations:^{
       
        label.alpha = 0;
    }];

}



//- (void)phoneRegister:(NSNotification *)notifiction{
//    
//    NSDictionary * dic = notifiction.userInfo;
//    
//    NSLog(@"%@",dic);
//    RegisterViewController * registerVc = [[RegisterViewController alloc]init];
//    registerVc.openId = dic[@"openid"];
//    registerVc.access_token = dic[@"access_token"];
//    NSLog(@"%@",registerVc.openId);
//    [self presentViewController:registerVc animated:NO completion:nil];
//    
//    
//}



//微信安装提示
- (void)setupAlertController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
}












#pragma mark- scrollViewCreat
- (void)creatScrollView{

    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64)];
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_H +1+SCREEN_W/2);
    
    
    [self.view addSubview:self.scrollView];
    
    UIImageView * imgvView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H /2)];
    imgvView.image = [UIImage imageNamed:@"huiyuan.png"];
    [self.scrollView addSubview:imgvView];
    
    
    UILabel * label0 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/8, SCREEN_W/8)];
    label0.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(imgvView.frame)+SCREEN_W/8);
    label0.text = [NSString stringWithFormat:@"第一步"];
    label0.textColor = [UIColor whiteColor];
    label0.textAlignment = NSTextAlignmentCenter;
    label0.backgroundColor = [UIColor colorWithRed:25/255.0 green:142/255.0 blue:246/255.0 alpha:1];
    label0.layer.cornerRadius = SCREEN_W/16;
    label0.clipsToBounds = YES;
    label0.font = [UIFont systemFontOfSize:11];
    [self.scrollView addSubview:label0];
    
    UILabel * label00 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W/10)];
    label00.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(label0.frame)+SCREEN_W/10);
    label00.text = [NSString stringWithFormat:@"点击下方按钮前往微信授权绑定"];
    label00.textColor = [UIColor blackColor];
    label00.textAlignment = NSTextAlignmentCenter;
    label00.font = [UIFont systemFontOfSize:15];
    [self.scrollView addSubview:label00];
    
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(SCREEN_W/4, CGRectGetMaxY(label00.frame) + 20, SCREEN_W/2, SCREEN_W/10);
    [button1 setTitle:@"去绑定微信" forState:UIControlStateNormal];
    [button1 setBackgroundColor:[UIColor lightGrayColor]];
    button1.layer.cornerRadius = 5;
    [self.scrollView addSubview:button1];
    button1.tag = 3344;
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.button = button1;
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W/8, SCREEN_W/8)];
    label.center = CGPointMake(SCREEN_W/2, CGRectGetMaxY(button1.frame)+SCREEN_W/8);
    label.text = [NSString stringWithFormat:@"第二步"];
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithRed:25/255.0 green:142/255.0 blue:246/255.0 alpha:1];
    label.layer.cornerRadius = SCREEN_W/16;
    label.clipsToBounds = YES;
    [self.scrollView addSubview:label];

    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(label.frame)+SCREEN_W/15, SCREEN_W - 40, SCREEN_W/8)];
    label2.text = [NSString stringWithFormat:@"请前往微信里添加【微转啦资讯】为好友或长按复制下框账号前往微信添加好友"];
    label2.numberOfLines = 0;
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor = [UIColor blackColor];
    [self.scrollView addSubview:label2];
    
    UIImageView * imgvView2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W/4, CGRectGetMaxY(label2.frame)+SCREEN_W/15, SCREEN_W/2, SCREEN_W/10)];
    imgvView2.image = [UIImage imageNamed:@"03.png"];
    [self.scrollView addSubview:imgvView2];
    imgvView2.userInteractionEnabled = YES;
    
    UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,SCREEN_W/2, SCREEN_W/10)];
    label3.text = [NSString stringWithFormat:@"zhaoqd007"];
    label3.numberOfLines = 0;
    self.label = label3;
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = [UIFont systemFontOfSize:16];
    label3.textColor = [UIColor greenColor];
    [imgvView2 addSubview:label3];
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(30, CGRectGetMaxY(imgvView2.frame) + SCREEN_W/10, SCREEN_W - 60, SCREEN_W/10);
    [button2 setTitle:@"完成绑定" forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor orangeColor]];
    button2.layer.cornerRadius = 5;
    [self.scrollView addSubview:button2];
    button2.tag = 4455;
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    

    [self addLongGuest:imgvView2];
}


#pragma mark-添加手势
- (void)addLongGuest:(UIImageView *)view{
    UILongPressGestureRecognizer * longPressGuest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longGuestAction:)];
    longPressGuest.minimumPressDuration = 1;

    [view addGestureRecognizer:longPressGuest];
}


- (void)longGuestAction:(UILongPressGestureRecognizer *)sender{

    if (sender.state == UIGestureRecognizerStateBegan) {
        
        NSLog(@"长按复制");
        
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [NSString stringWithFormat:@"zhaoqd007"];
        

        if (pasteboard.string != nil) {
            
            [self alerateViewShow];
        }

        
    }
}


- (void)alerateViewShow{
    
    UIView * bgView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    self.alertShowBgView = bgView;

    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W - 20, SCREEN_H/3)];
    view.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);
    [bgView addSubview:view];
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
    detailLabel.text = @"已复制微转啦资讯公众号，请到微信里添加关注公众号";
    detailLabel.font = [UIFont systemFontOfSize:15];
    detailLabel.numberOfLines = 2;
    detailLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:detailLabel];
    
    UIButton * cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(10, SCREEN_H/3 - 15 - SCREEN_H/13, (view.frame.size.width - 30)/2, SCREEN_H/14);
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleButton.tag = 4404;
    [view addSubview:cancleButton];
    cancleButton.layer.borderWidth = 0.5;
    cancleButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cancleButton.clipsToBounds = YES;
    cancleButton.layer.cornerRadius = 10;
    
    UIButton * sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(20 + (view.frame.size.width - 30)/2, SCREEN_H/3 - 15 - SCREEN_H/13, (view.frame.size.width - 30)/2, SCREEN_H/14);
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    sureButton.tag = 5505;
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    sureButton.layer.borderWidth = 0.5;
    //    sureButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    sureButton.clipsToBounds = YES;
    sureButton.layer.cornerRadius = 10;
    sureButton.backgroundColor = [UIColor orangeColor];
    [view addSubview:sureButton];


    [cancleButton addTarget:self action:@selector(alerateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [sureButton addTarget:self action:@selector(alerateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)alerateButtonAction:(UIButton *)bt{

    if (bt.tag == 4404) {
        NSLog(@"取消");
        [self.alertShowBgView removeFromSuperview];
        
    }else if (bt.tag == 5505){
    
        NSLog(@"确定");
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
        
        
        [self.alertShowBgView removeFromSuperview];

    }

    
    
}

@end
