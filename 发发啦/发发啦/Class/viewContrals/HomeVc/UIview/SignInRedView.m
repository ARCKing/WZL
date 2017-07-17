//
//  SignInRedView.m
//  发发啦
//
//  Created by gxtc on 16/8/17.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "SignInRedView.h"
#import "NetWork.h"
#import "UCShareView.h"
#import "MBProgressHUD.h"

#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface SignInRedView()
@property(nonatomic,retain)UIView * navView;
@property(nonatomic,retain)UIScrollView * scrollView;

@property(nonatomic,retain)UIImageView * getMoneyImageView;

@property(nonatomic,retain)UILabel * placeHolderLabel;

@property(nonatomic,retain)NSUserDefaults * userdefaults;
@property(nonatomic,retain)NetWork * net;
@property(nonnull,copy)NSString * token;
@property (nonatomic,copy)NSString * uid;
@property(nonatomic,strong) UCShareView * uc ;
@property(nonatomic,strong)MBProgressHUD * hud;



@end

@implementation SignInRedView



- (void)initCreat{
    
    
    
    [self navViewCreat];
    [self scrollViewcreat];
    [self threeIteamCreat];
    
    if (_userdefaults == nil) {
        _userdefaults = [NSUserDefaults standardUserDefaults];
    }

    NSDictionary * dic = [_userdefaults objectForKey:@"usermessage"];
    
    self.uid = dic[@"uid"];
    self.token = dic[@"token"];
    
    if (_net == nil) {
        _net = [[NetWork alloc]init];
    }
    
    __weak SignInRedView * weakSelf = self;
    _net.userSign=^(NSString * money,NSString * message){
        
        [weakSelf addSubview: weakSelf.getMoneyView];
        [weakSelf subViewCreat];
        weakSelf.hud.hidden = YES;
        weakSelf.placeHolderLabel.text = message;
        
    };

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.hud hideAnimated:YES];

}

#pragma mark- navViewCreat
- (void)navViewCreat{
    self.navView = [[UIView alloc]init];
    self.navView.frame = CGRectMake(0, 0, SCREEN_W, 64);
    self.navView.backgroundColor = [UIColor orangeColor];
    [self addSubview:_navView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"<–" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"comm_icon_back_white.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 35, 40, 20);
//    button.backgroundColor = [UIColor redColor];
    [self addSubview:button];
#pragma mark- button.tag-3000
    button.tag = 3000;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.text = @"签到红包";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.center = CGPointMake(SCREEN_W/2, 45);
    [self.navView addSubview:titleLabel];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
}


#pragma mark- buttonAction
- (void)buttonAction:(UIButton *)button{
    
    if (button.tag == 5000) {
        NSLog(@"5000");
        
        NSDictionary * dic = @{@"stype":@"zao",
                               @"uid":self.uid,@"token":self.token};
        
        
       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
       hud.removeFromSuperViewOnHide = YES;
        self.hud = hud;
        
        [_net customerSignGetMoney:dic];
//        [self subViewCreat];

        return;
    }else if (button.tag == 5001){
        NSLog(@"5001");
        
        NSDictionary * dic = @{@"stype":@"zhong",
                               @"uid":self.uid,@"token":self.token};
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.removeFromSuperViewOnHide = YES;
        self.hud = hud;

        [_net customerSignGetMoney:dic];

//        [self subViewCreat];
        return;
    }else if (button.tag == 5002){
        NSLog(@"5002");
        NSDictionary * dic = @{@"stype":@"wan",
                               @"uid":self.uid,@"token":self.token};
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hud.removeFromSuperViewOnHide = YES;
        self.hud = hud;

        
        [_net customerSignGetMoney:dic];

//        [self subViewCreat];
        
        return;
    }else if (button.tag == 3000){
        NSLog(@"3000");
        self.backBlock();
        
    }else if (button.tag == 9900) {
    
        NSLog(@"9900");
        
        [self.getMoneyView removeFromSuperview];
    
    }

}


#pragma mark- subViewCreaet

- (void)subViewCreat{

    if (self.getMoneyView) {
        [self addSubview:_getMoneyView];
        
        
        self.advViewShou(self.getMoneyView);
        
        return;
    }
    
    self.getMoneyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    self.getMoneyView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    

    self.getMoneyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W -30, SCREEN_H*4/5)];
//    self.getMoneyImageView.backgroundColor = [UIColor purpleColor];
    self.getMoneyImageView.center = CGPointMake(SCREEN_W/2, SCREEN_H/2);
    
    [self.getMoneyView addSubview:_getMoneyImageView];
    
    self.getMoneyImageView.image = [self addDownImage:@"red_envelope02.png" andUpImage:@"red_envelope01.png"];
    self.getMoneyImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.getMoneyImageView.userInteractionEnabled = YES;
//    [self addSubview:_getMoneyView];
    
    
    UIButton * xxbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    xxbutton.frame = CGRectMake(_getMoneyImageView.bounds.size.width * 10/12 - _getMoneyImageView.bounds.size.width/24, _getMoneyImageView.bounds.size.height/10 + _getMoneyImageView.bounds.size.height/12, _getMoneyImageView.bounds.size.width/10,_getMoneyImageView.bounds.size.height/14);
//    xxbutton.backgroundColor = [UIColor blackColor];
    [self.getMoneyImageView addSubview:xxbutton];
#pragma mark- xxButton.tag-9900
    xxbutton.tag = 9900;
    
    [xxbutton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addResoutOfRedSingInButttonAndLabel];
    
    [self addSubview:_getMoneyView];

    
    self.advViewShou(self.getMoneyView);

}



#pragma mark- 签到处理结果
- (void)addResoutOfRedSingInButttonAndLabel{


    self.placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W * 2/3,25 )];
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
    

    self.placeHolderLabel.text = @"";
    [self.resoultButton setTitle:@"立即收徒赚钱" forState:UIControlStateNormal];
}

- (void)resoultButtonAction{
    NSLog(@"弹出分享页面!");
    [self.getMoneyView removeFromSuperview];
    
    self.shareViewBlock();
}


- (void)shareViewCreat{

//    UCShareView * uc =[[ UCShareView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
//    [self addSubview:uc];
//    self.uc = uc;
//    [uc.exitShare addTarget:self action:@selector(exitShareBtuuonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)exitShareBtuuonAction{

    [self.uc removeFromSuperview];
}

#pragma mark- 签到领红包网络请求
- (void)signInNetWork{


}


#pragma mark- 根据网络返回数据设置显示参数
- (void)plaveHoldLabelAndResoultButtonDetailText:(NSString *)placeHolder andButtonTitle:(NSString *)buttonTitle{



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


#pragma mark- scrollViewcreat
- (void)scrollViewcreat{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64)];
    [self addSubview:_scrollView];
    
    self.scrollView.contentSize = CGSizeMake(0, SCREEN_H - 63);
    self.scrollView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];

}

#pragma mark- threeIteamCreat

- (void)threeIteamCreat{

    NSArray * titleArray = @[@"早安签到",@"午间签到",@"晚餐签到"];
    NSArray * timeArray = @[@"每日00:00:00-07:59:59",@"每日08:00:00-15:59:59",@"每日16:00:00-23:59:59"];
    
    
    for (int i = 0; i < 3; i++) {
        UIView * bgview = [[UIView alloc]initWithFrame:CGRectMake(10, i * (100 + 10), (SCREEN_W - 20), 100)];
        bgview.backgroundColor = [UIColor whiteColor];
        [self.scrollView addSubview:bgview];
        
        bgview.layer.cornerRadius = 5;
        bgview.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:199/255.0 blue:60/255.0 alpha:0.5].CGColor;
        bgview.layer.shadowOffset = CGSizeMake(5, 5);
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        imgView.center = CGPointMake(30 + 10, 50);
        imgView.image =[UIImage imageNamed:@"icon_red2.png"];
        [bgview addSubview:imgView];
        
        UILabel * titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10 + CGRectGetMaxX(imgView.frame), 30, 60+2, 20)];
        titlelabel.text = titleArray[i];
        titlelabel.font = [UIFont systemFontOfSize:15];
        [bgview addSubview:titlelabel];
        
        
        UILabel * timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 + CGRectGetMaxX(imgView.frame), CGRectGetMaxY(titlelabel.frame) + 5, 200, 20)];
        timeLabel.text = timeArray[i];
        timeLabel.textColor = [UIColor lightGrayColor];
        timeLabel.font =[UIFont systemFontOfSize:13];
        [bgview addSubview:timeLabel];
        
        
        UIImageView * limitImgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titlelabel.frame), 15, 33, 21)];
        limitImgView.image = [UIImage imageNamed:@"icn_limited.png"];
        [bgview addSubview:limitImgView];
        
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"领取" forState:UIControlStateNormal];
        button.layer.cornerRadius = 3;
        button.backgroundColor = [UIColor colorWithRed:25/255.0 green:152/255.0 blue:85/255.0 alpha:1];
#pragma mark- button.tag-5000+i
        button.tag = 5000+ i;
        [bgview addSubview:button];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(bgview.bounds.size.width - 60, 30, 50, 30);
        
        
        
    }
    
    

}

@end
