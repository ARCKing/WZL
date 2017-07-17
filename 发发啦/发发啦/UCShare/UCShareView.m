//
//  UCShareView.m
//  webShare
//
//  Created by gxtc on 16/9/21.
//  Copyright © 2016年 gxtc. All rights reserved.
//

#import "UCShareView.h"

#import "UMSocialUIManager.h"

#pragma mark- 用户资料
#define UMSUserInfoPlatformTypeKey @"UMSUserInfoPlatformTypeKey"
#define UMSUserInfoPlatformNameKey @"UMSUserInfoPlatformNameKey"
#define UMSUserInfoPlatformIconNameKey @"UMSUserInfoPlatformIconNameKey"

#pragma mark- 用户登录
#define UMSAuthPlatformTypeKey @"UMSAuthPlatformTypeKey"
#define UMSAuthPlatformNameKey @"UMSAuthPlatformNameKey"
#define UMSAuthPlatformIconNameKey @"UMSAuthPlatformImageNameKey"

#define Screen_W [UIScreen mainScreen].bounds.size.width
#define Screen_H [UIScreen mainScreen].bounds.size.height

@interface UCShareView ()

@property(nonatomic,retain)UILabel * titleLabel;
@property (nonatomic, strong) NSMutableArray *platformInfoArray;

@end

@implementation UCShareView


- (instancetype)initWithFrame:(CGRect)frame andIsinvite:(BOOL)isinvite{

    if (self = [super initWithFrame:frame]) {
        
    //======Ushare======
        self.platformInfoArray = [NSMutableArray arrayWithCapacity:4];
        
        //    NSArray *paltformTypeArray = [NSArray arrayWithObjects:@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_TencentWb),@(UMSocialPlatformType_Renren),@(UMSocialPlatformType_Douban),@(UMSocialPlatformType_Facebook),@(UMSocialPlatformType_Twitter),@(UMSocialPlatformType_Linkedin), nil];
        
        NSArray *paltformTypeArray = [NSArray arrayWithObjects:@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ),nil];
        
        
        for (NSNumber *platformType in paltformTypeArray) {
            NSMutableDictionary *dict = [self dictWithPlatformName:platformType];
            [dict setValue:platformType forKey:UMSAuthPlatformTypeKey];
            if (dict) {
                [self.platformInfoArray addObject:dict];
            }
        }
        
        NSLog(@"%@",_platformInfoArray);
  
    
    
    
    NSArray * iconArray = @[@"pic_share_friends.png",@"pic_share_weixin.png",@"pic_share_tencent.png",@"pic_share_zone.png",@"pic_share_sina.png",@"pic_share_copy_link.png"];
    
    
//    NSArray * iconArray = @[@"pic_share_friends.png",@"pic_share_weixin.png",@"pic_share_tencent.png",@"pic_share_zone.png",@"pic_share_copy_link.png"];

   
    NSArray * buttonTitleArray = @[@"微信朋友圈",@"微信好友",@" QQ好友 ",@" QQ空间 ",@"新浪微博",@"复制链接"];
//    NSArray * buttonTitleArray = @[@"微信朋友圈",@"微信好友",@" QQ好友 ",@" QQ空间 ",@"复制链接"];
    
    
//    NSArray * buttonTitleArray2 = @[@"微信朋友圈",@"微信好友",@" QQ好友 ",@" QQ空间 ",@" 面对面收徒"];
//    NSArray * iconArray2 = @[@"pic_share_friends.png",@"pic_share_weixin.png",@"pic_share_tencent.png",@"pic_share_zone.png",@"saoma.png",@"close_blackB.png"];
    
        
       NSArray * buttonTitleArray2 = @[@"微信朋友圈",@"微信好友",@" QQ好友 ",@" QQ空间 ",@"新浪微博",@" 面对面收徒"];

       NSArray * iconArray2 = @[@"pic_share_friends.png",@"pic_share_weixin.png",@"pic_share_tencent.png",@"pic_share_zone.png",@"pic_share_sina.png",@"saoma.png"];
    
    if (self = [super initWithFrame:frame]) {
        self.bgShareView = [[UIView alloc]init];
        
//        self.bgShareView.frame = CGRectMake(0, Screen_H * 2 /3, Screen_W, Screen_H/3);
          self.bgShareView.frame = CGRectMake(0, Screen_H, Screen_W, Screen_H/3);

//        self.bgShareView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        self.bgShareView.backgroundColor =[UIColor whiteColor];
        [self addSubview:_bgShareView];
        
        NSMutableArray * buttonArray = [NSMutableArray new];
        
        
        
        for (int i = 0; i < 6; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
#pragma mark- button.tag-1110+i;
            button.tag = 1110 + i;
            button.frame = CGRectMake(Screen_W/5/2 + ((Screen_W/5/2 + Screen_W/5) * (i % 3)), (10 + Screen_W/5) * (i / 3), Screen_W/5, Screen_W/5);
//            button.backgroundColor = [UIColor purpleColor];
            
            
            if (isinvite) {
                [button setImage:[UIImage imageNamed:iconArray2[i]] forState:UIControlStateNormal];
                
                [button setTitle:buttonTitleArray2[i] forState:UIControlStateNormal];

            }else{
            
            [button setImage:[UIImage imageNamed:iconArray[i]] forState:UIControlStateNormal];
            
            [button setTitle:buttonTitleArray[i] forState:UIControlStateNormal];
            
            }
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            
            button.titleEdgeInsets = UIEdgeInsetsMake(50, -35, 0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(-15, 12, 0, 0);
            
            
            [buttonArray addObject:button];
            
            [_bgShareView addSubview:button];
        }
        
        self.weixinFriend = buttonArray[0];
        self.weixin = buttonArray[1];
        self.sinaWeiBo = buttonArray[4];
        self.QQ = buttonArray[2];
        self.QZone = buttonArray[3];
        self.URLCopy = buttonArray[5];
        self.saoYiSao = self.URLCopy;
        
//        self.saoYiSao = self.URLCopy;
        
//        if (isinvite) {
//            self.exitShare2 = buttonArray[5];
//        }
        
        self.exitShare = [UIButton buttonWithType:UIButtonTypeCustom];
        self.exitShare.frame = CGRectMake(0, CGRectGetMaxY(self.QZone.frame), Screen_W, Screen_W/6);

        [self.exitShare setTitle:@"取消分享" forState:UIControlStateNormal];
        [self.exitShare setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.exitShare.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.bgShareView addSubview:_exitShare];
        self.exitShare.tag = 404040;
//        self.exitShare.backgroundColor =[UIColor redColor];
        
        
        
        /*
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.frame = CGRectMake(0, -20, Screen_W, 20);
        
        if (isinvite) {
            self.titleLabel.text = @"分享收徒链接";

        }else{
            self.titleLabel.text = @"选择你要分享的平台！";
        }
        self.titleLabel.textColor = [UIColor redColor];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.bgShareView addSubview:_titleLabel];
        */
        
    }

    [self performSelector:@selector(shareViewCome) withObject:nil];
    
    }
    
    return self;

}


- (void)shareViewCome{

    [UIView animateWithDuration:0.5 animations:^{
    self.bgShareView.frame = CGRectMake(0, Screen_H * 2 /3, Screen_W, Screen_H/3);
    }];
}




- (void)shareButtonAction:(UIButton *)bt{
    
    
    //判断是否安装有UC
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"ucbrowser://"]] && bt.tag != 1114)
//    {
//        NSLog(@"install--");
//        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"ucbrowser://odogjy92d.qnssl.com/share.html?id=36613&u=2700826"]];
//        
//        //微信好友
//        //view.415003.com/ArticleContent/DynamicShare?uid=2797782&sharebrowser=1&aid=353788&shareType=weixin
//        
//        //朋友圈
//        //view.415003.com/ArticleContent/DynamicShare?uid=2797782&sharebrowser=1&aid=353788&shareType=weixinFriend
//        
//        //QQ好友
//        //view.415003.com/ArticleContent/DynamicShare?uid=2797782&sharebrowser=1&aid=353788&shareType=QQ
//        
//        //QQ空间
//        //view.415003.com/ArticleContent/DynamicShare?uid=2797782&sharebrowser=1&aid=353788&shareType=QZone
//        
//    }
//    else
    {
        NSLog(@"no---");
        
        UIAlertController * alertControll = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您没有安装UC浏览器,无法分享" preferredStyle: UIAlertControllerStyleAlert];
        
        [alertControll addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
        }]];


        
        [self removeFromSuperview];
        
        return;
        
    }
    

    
    
    
    if (bt.tag == 1110) {
        NSLog(@"微信朋友圈分享");
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"ucbrowser://view.415003.com/ArticleContent/DynamicShare?uid=2797782&sharebrowser=1&aid=353788&shareType=weixinFriend"]];
        
    }else if (bt.tag == 1111) {
        NSLog(@"微信好友分享");

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"ucbrowser://view.415003.com/ArticleContent/DynamicShare?uid=2797782&sharebrowser=1&aid=353788&shareType=weixin"]];
        
//    }else if (bt.tag == 1115) {
//        NSLog(@"新浪分享");
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"ucbrowser://view.415003.com/ArticleContent/DynamicShare?uid=2797782&sharebrowser=1&aid=353788&shareType=weixin"]];
//        
    }else if (bt.tag == 1112) {
        NSLog(@"QQ分享");

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"ucbrowser://view.415003.com/ArticleContent/DynamicShare?uid=2797782&sharebrowser=1&aid=353788&shareType=QQ"]];
    }else if (bt.tag == 1113) {
        
        NSLog(@"QQ空间分享");

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"ucbrowser://view.415003.com/ArticleContent/DynamicShare?uid=2797782&sharebrowser=1&aid=353788&shareType=QZone"]];
        
    }else if (bt.tag == 1114) {
        NSLog(@"复制分享链接");
//       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"ucbrowser://view.415003.com/ArticleContent/DynamicShare?uid=2797782&sharebrowser=1&aid=353788&shareType=weixin"]];
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = @"http://m.jikedayin.com/HtmlPage/News/20160920/9/201609201535361907.html?key=013CFFADCB06FAC8432F97EA4E58849F767201C57102146D";
        
        if (pasteboard.string == nil) {
            
            UIAlertController * alertControll = [UIAlertController alertControllerWithTitle:@"复制成功" message:nil preferredStyle: UIAlertControllerStyleAlert];
            
//            [alertControll addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//            }]];

        }
        
    }
    
    
    [self removeFromSuperview];
    

}


//====Ushare======

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







@end
